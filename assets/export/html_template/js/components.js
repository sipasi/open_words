class HtmlUtils {
  /**
   * @param {string} tag 
   * @param {Object} options 
   * @param {String} options.text
   * @param {Map<string,string>} options.attrs
   * @param {HTMLElement[]} options.children
   * @returns {HTMLElement}
   */
  static el(tag, { text, attrs, children } = {}) {
    const node = document.createElement(tag);

    if (text) node.textContent = text;
    if (attrs) Object.entries(attrs).forEach(([k, v]) => node.setAttribute(k, v));
    if (children) node.append(...children);

    return node;
  }
  /**
  * @param {T[]|null} items 
  * @param {(item: T) => HTMLElement} factory 
  * @returns {HTMLElement[]}
  */
  static listFrom(items, factory, fallback = []) {
    if (!Array.isArray(items) || items.length == 0) {
      return fallback;
    }

    const nodes = [];

    for (let i = 0; i < items.length; i++) {
      nodes.push(
        factory(items[i])
      );
    }

    return nodes;
  }
};

/** 
 * @field {HTMLElement} template
*/
class HtmlTemplate {
  /** @type {HTMLElement} */
  #html;

  /**
  * @param {String} html
  */
  constructor(html) {
    this.#html = html;
  }

  /** 
   * @return {String}
   */
  html() {
    return this.#html;
  }
}

class Templates {
  static #theme_selector = new HtmlTemplate(`
    		<button>
    		  <span class="icon">🎨</span>
    		</button>
    		<ul class="theme-dropdown"></ul>
      `);
  static #global_search_field = new HtmlTemplate(`
    		<input type="text" class="glass" placeholder="Search words..." />
    		<div class="glass">
    		  <span></span>
    		</div>
      `);
  static #app_nav_bar = new HtmlTemplate(`
        <global-search-field></global-search-field>
        <theme-selector></theme-selector>
      `);

  static #dictionary_item = new HtmlTemplate(`
        <div class="header">
          <h3 class="name"></h3> 
          <div class="languages">
            <p>en</p>
            <p>ua</p>
          </div>
          <button class="collapce-toggle" aria-expanded="true">✚</button>
        </div>
        <div class="word-list"></div>
      `);
  static #word_card = new HtmlTemplate(`
    		<div class="header">
          <p class="origin"></p>
          <p class="translation"></p>
        </div>
        <metadata-container></metadata-container>
      `);
  static #metadata_container = new HtmlTemplate(`
        <titled-list title="Phonetics"></titled-list>
        <titled-list title="Meanings"></titled-list>  
      `);
  static #titled_list = new HtmlTemplate(`
        <h4 class="title"></h4>
        <div class="list"></div>  
      `);
  static #phonetic_item = new HtmlTemplate(`
        <p class="value"></p>
        <p class="audio"></p>  
      `);
  static #meaning_item = new HtmlTemplate(`
        <p class="part-of-speech"></p>
      
        <titled-list title="Synonyms" class="chips"></titled-list>
        <titled-list title="Antonyms" class="chips"></titled-list>
        <titled-list title="Definitions" class="definition-list"></titled-list>
      `);
  static #definition_item = new HtmlTemplate(`
        <p></p>
        <p></p>
      `);

  /** @return {HtmlTemplate} */
  static theme_selector() { return this.#theme_selector }
  /** @return {HtmlTemplate} */
  static global_search_field() { return this.#global_search_field }
  /** @return {HtmlTemplate} */
  static app_nav_bar() { return this.#app_nav_bar }
  /** @return {HtmlTemplate} */
  static dictionary_item() { return this.#dictionary_item }
  /** @return {HtmlTemplate} */
  static word_card() { return this.#word_card }
  /** @return {HtmlTemplate} */
  static metadata_container() { return this.#metadata_container }
  /** @return {HtmlTemplate} */
  static titled_list() { return this.#titled_list }
  /** @return {HtmlTemplate} */
  static phonetic_item() { return this.#phonetic_item }
  /** @return {HtmlTemplate} */
  static meaning_item() { return this.#meaning_item }
  /** @return {HtmlTemplate} */
  static definition_item() { return this.#definition_item }
}

class ThemeService {
  static #attribute = "data-theme";
  static #default = "Moss Vale Dark";

  static get theme() {
    return localStorage.getItem(this.#attribute) ?? this.#default;
  }

  static set theme(value) {
    localStorage.setItem(this.#attribute, value);
    this.syncThemeAttribute();
  }

  static syncThemeAttribute() {
    const current = this.theme;

    document.documentElement.setAttribute(this.#attribute, current);
  }

  static getAllThemes() {
    const themes = new Set();

    for (const sheet of document.styleSheets) {
      try {
        for (const rule of sheet.cssRules ?? []) {
          const matches = rule.selectorText?.match(/data-theme\s*=\s*"([^"]+)"/g);
          matches?.forEach(m => themes.add(m.match(/"([^"]+)"/)[1]));
        }
      } catch { /* cross-origin */ }
    }

    return [...themes];
  }
}

class ThemeSelector extends HTMLElement {
  /** @type {HTMLElement} */
  #button;
  /** @type {HTMLElement} */
  #dropdown;

  constructor() {
    super();

    this.innerHTML = Templates
      .theme_selector()
      .html();

    this.#button = this.querySelector("button");
    this.#dropdown = this.querySelector(".theme-dropdown");
  }

  connectedCallback() {
    ThemeService.syncThemeAttribute();

    this.#fillThemeDropdown(
      ThemeService.getAllThemes(),
      ThemeService.theme
    );

    this.#button.addEventListener("click", () => this.#toggleDropdown());
    this.#dropdown.addEventListener("click", e => this.#onSelect(e));
  }

  #toggleDropdown() {
    this.#button.classList.toggle("active");
    this.#dropdown.classList.toggle("show");
  }

  #onSelect(e) {
    const li = e.target.closest("li");
    if (!li) return;

    ThemeService.theme = li.dataset.theme;
    this.#toggleDropdown();
    this.#fillThemeDropdown(
      ThemeService.getAllThemes(),
      ThemeService.theme
    );
  }

  #fillThemeDropdown(themes, current) {
    this.#dropdown.replaceChildren(
      ...themes.map(theme =>
        HtmlUtils.el("li", {
          text: theme,
          attrs: {
            "data-theme": theme,
            "class": theme == current ? "active" : ''
          }
        })
      )
    );
  }
}

class GlobalSearchField extends HTMLElement {
  /** @type {HTMLElement} */
  #input;
  /** @type {HTMLElement} */
  #found;

  constructor() {
    super();

    this.innerHTML = Templates
      .global_search_field()
      .html();

    this.#input = this.querySelector("input");
    this.#found = this.querySelector("span");
  }

  connectedCallback() {
    const enable = window.enable_search_field ?? true;

    if (!enable) return this.remove();

    this.#input.addEventListener("input", () =>
      GlobalSearchField.#onInput(this.#input.value.toLowerCase(), this.#found),
    );
  }

  /**
   * @param {String} query
   * @param {HTMLElement} foundNode
   */
  static #onInput(query, foundNode) {
    let foundCount = 0;

    document.querySelectorAll("dictionary-item").forEach((dictionary) => {
      const name = dictionary
        .querySelector(".name")
        .textContent.toLowerCase();

      const mutched = GlobalSearchField.#mutchedWords(query, dictionary);

      let visible = name.includes(query) || mutched.times > 0;

      dictionary.style.display = visible ? "" : "none";

      foundCount += mutched.times;
    });

    foundNode.textContent = query ? `${foundCount}` : "not found";
  }

  /**
   * @param {String} query
   * @param {HTMLElement} dictionary
   * @returns {{times: number}}
   */
  static #mutchedWords(query, dictionary) {
    let times = 0;

    dictionary.querySelectorAll("word-card").forEach((card) => {
      const origin = card.querySelector(".origin").textContent.toLowerCase();
      const translation = card
        .querySelector(".translation")
        .textContent.toLowerCase();

      const visible = origin.includes(query) || translation.includes(query);
      card.style.display = visible ? "" : "none";

      if (visible) {
        times++;
      }
    });

    return { times: times };
  }
}

class AppNavBar extends HTMLElement {
  constructor() {
    super();

    this.classList.add("sticky-nav");

    this.innerHTML = Templates
      .app_nav_bar()
      .html();
  }
}

/**
 * @typedef {Object} Dictionary
 * @property {string} name
 * @property {Word[]} words
 * 
 * @typedef {Object} Word
 * @property {string} origin
 * @property {string} translation
 * @property {Metadata} metadata
 *
 * @typedef {Object} Metadata
 * @property {Phonetic[]} phonetics
 * @property {Meaning[]} meanings
 *
 * @typedef {Object} Phonetic
 * @property {string} value
 * @property {string} audio
 *
 * @typedef {Object} Meaning
 * @property {string} partOfSpeech
 * @property {string[]} synonyms
 * @property {string[]} antonyms
 * @property {Definition[]} definitions
 *
 * @typedef {Object} Definition
 * @property {string} value
 * @property {string} example
 */

class DictionaryList extends HTMLElement {
  constructor() {
    super();
  }

  /**@param {Array<Dictionary>} value */
  set items(value) {
    for (let i = 0; i < value.length; i++) {
      const dictionary = new DictionaryItem();
      dictionary.value = value[i];

      this.appendChild(dictionary);
    }
  }
}

class DictionaryItem extends HTMLElement {
  #name_node;
  #words_node;
  #toggle_node;

  constructor() {
    super();

    this.innerHTML = Templates
      .dictionary_item()
      .html();

    this.#name_node = this.querySelector(".name");
    this.#words_node = this.querySelector(".word-list");
    this.#toggle_node = this.querySelector(".collapce-toggle");

    this.#listDisplayStyle({ expanded: this.#ariaExpanded == "true" });

    this.querySelector(".header").addEventListener("click", () =>
      this.#onTap(),
    );
  }

  /** @param {Dictionary} value  */
  set value(value) {
    this.#name_node.textContent = value.name;

    this.#words_node.replaceChildren(
      ...HtmlUtils.listFrom(
        value.words,
        item => WordCard.create(item)
      )
    );
  }

  #onTap() {
    const expanded = this.#ariaExpanded == "true";

    this.#listDisplayStyle({ expanded: !expanded });

    this.#ariaExpanded = !expanded;
  }

  #listDisplayStyle({ expanded }) {
    const style = this.#words_node.style;

    style.display = expanded ? "flex" : "none";
  }

  /** @returns {String} */
  get #ariaExpanded() {
    return this.#toggle_node.getAttribute("aria-expanded");
  }
  /** @param {bool} value */
  set #ariaExpanded(value) {
    this.#toggle_node.setAttribute("aria-expanded", value);
  }
}

class WordCard extends HTMLElement {
  /** @type {HTMLElement} */
  #origin;
  /** @type {HTMLElement} */
  #translation;
  /** @type {MetadataContainer} */
  #metadata;

  constructor() {
    super();

    this.innerHTML = Templates
      .word_card()
      .html();

    this.#origin = this.querySelector(".origin");
    this.#translation = this.querySelector(".translation");
    this.#metadata = this.querySelector("metadata-container");
  }

  /**
   * @param {Word} word
   * @returns {WordCard}
   */
  static create(word) {
    const card = new WordCard();

    card.word = word;

    if (word.metadata) {
      card.metadata = word.metadata;
    }

    return card;
  }

  /** @param {Word} value  */
  set word(value) {
    this.#origin.textContent = value.origin;
    this.#translation.textContent = value.translation;
  }
  /** @param {Metadata} value  */
  set metadata(value) {
    this.#metadata.value = value;
  }
}

class MetadataContainer extends HTMLElement {
  /** @type {TitledList} */
  #phonetics;
  /** @type {TitledList} */
  #meanings;

  constructor() {
    super();

    this.innerHTML = Templates
      .metadata_container()
      .html();

    const lists = this.querySelectorAll("titled-list");
    this.#phonetics = lists[0];
    this.#meanings = lists[1];
  }

  /** @param {Metadata} value  */
  set value(value) {
    const phonetics = PhoneticItem.listFrom(value.phonetics);
    const meanings = MeaningItem.listFrom(value.meanings);

    if (phonetics) this.#phonetics.list = phonetics;
    if (meanings) this.#meanings.list = meanings;
  }
}

class TitledList extends HTMLElement {
  #title;
  #list;

  constructor() {
    super();

    this.innerHTML = Templates
      .titled_list()
      .html();

    this.#title = this.querySelector("h4");
    this.#list = this.querySelector("div");
  }

  attributeChangedCallback(name, _, newValue) {
    if (name === "title") {
      this.#title.textContent = newValue;
    }
  }
  static get observedAttributes() {
    return ["title"];
  }

  /** @prop {string} value */
  set title(value) {
    this.setAttribute("title", value);
  }
  /** @return {string} value */
  get title() {
    return this.getAttribute("title");
  }

  /** @prop {HTMLElement[]} value */
  set list(value) {
    this.#list.replaceChildren(...value);
  }

  /** @param {String} tag */
  /** @param {String[]|null} value */
  /** @return {HTMLElement[]|null}  */
  static wrap(tag, value) {
    return HtmlUtils.listFrom(
      value,
      item => HtmlUtils.el(tag, { text: item }),
    );
  }
}

class PhoneticItem extends HTMLElement {
  #phonetic;
  #audio;

  constructor() {
    super();

    this.innerHTML = Templates
      .phonetic_item()
      .html();

    this.#phonetic = this.querySelector(".value");
    this.#audio = this.querySelector(".audio");
  }

  /** @param {Phonetic} value */
  set value(value) {
    this.#phonetic.textContent = value.value;
    this.#audio.textContent = value.audio;
  }

  /** @param {Phonetic|null} value */
  /** @return {PhoneticItem|null} */
  static create(value) {
    const phonetic = new PhoneticItem();

    phonetic.value = value;

    return phonetic;
  }

  /** @param {Phonetic[]|null} value */
  /** @return {PhoneticItem[]} */
  static listFrom(value) {
    return HtmlUtils.listFrom(
      value,
      item => this.create(item)
    )
  }
}

class MeaningItem extends HTMLElement {
  /** @type {HTMLElement} value  */
  #partOfSpeech;
  /** @type {TitledList} value  */
  #synonyms;
  /** @type {TitledList} value  */
  #antonyms;
  /** @type {TitledList} value  */
  #definitions;

  constructor() {
    super();

    this.innerHTML = Templates
      .meaning_item()
      .html();

    this.#partOfSpeech = this.querySelector(".part-of-speech");

    const lists = this.querySelectorAll("titled-list");
    this.#synonyms = lists[0];
    this.#antonyms = lists[1];
    this.#definitions = lists[2];
  }

  /** @param {Meaning} value  */
  set value(value) {
    this.partOfSpeech = value.partOfSpeech;
    this.synonyms = value.synonyms;
    this.antonyms = value.antonyms;
    this.definitions = value.definitions;
  }
  /** @param {string} value  */
  set partOfSpeech(value) {
    this.#partOfSpeech.textContent = value;
  }
  /** @param {String[]} elements  */
  set synonyms(elements) {
    this.#synonyms.list = TitledList.wrap('p', elements);
  }
  /** @param {String[]} elements  */
  set antonyms(elements) {
    this.#antonyms.list = TitledList.wrap('p', elements);
  }
  /** @param {Definition[]} elements  */
  set definitions(elements) {
    this.#definitions.list = DefinitionItem.fromList(elements);
  }

  /** @param {Meaning} value */
  /** @return {MeaningItem} */
  static create(value) {
    const meaning = new MeaningItem();

    meaning.value = value;

    return meaning;
  }

  /** @param {Meaning[]|null} value */
  /** @return {MeaningItem[]|null} */
  static listFrom(value) {
    return HtmlUtils.listFrom(
      value,
      item => this.create(item)
    );
  }
}

class DefinitionItem extends HTMLElement {
  /** @type {TitledList} value  */
  #value;
  #example;

  constructor() {
    super();

    this.innerHTML = Templates
      .definition_item()
      .html();

    const lists = this.querySelectorAll("p");
    this.#value = lists[0];
    this.#example = lists[1];
  }
  /** @param {Definition} value  */
  set value(value) {
    this.#value.textContent = value.value;
    this.#example.textContent = value.example;
  }

  /** @param {Definition} value  */
  static create(value) {
    const node = new DefinitionItem();

    node.value = value;

    return node;
  }
  /** @param {Definition[]|null} value  */
  static fromList(value) {
    return HtmlUtils.listFrom(
      value,
      item => this.create(item)
    )
  }
}

customElements.define("theme-selector", ThemeSelector);
customElements.define("global-search-field", GlobalSearchField);
customElements.define("app-nav-bar", AppNavBar);

customElements.define("dictionary-list", DictionaryList);
customElements.define("dictionary-item", DictionaryItem);
customElements.define("word-card", WordCard);

customElements.define("metadata-container", MetadataContainer);
customElements.define("titled-list", TitledList);
customElements.define("phonetic-item", PhoneticItem);
customElements.define("meaning-item", MeaningItem);
customElements.define("definition-item", DefinitionItem);