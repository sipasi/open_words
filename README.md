# Open Words

**Open Words** is a simple yet powerful app for creating personal dictionaries, reviewing vocabulary through games, and learning foreign languages.

This project is an **evolution** of my previous app built with [.NET MAUI](https://github.com/sipasi/OpenDictionary), now fully rewritten in **Flutter**.

> It works best when used with **English** and the language you want to learn.

## Features

-   🎙️ **Text-to-Speech support and configuration** — listen to word pronunciation.
    
-   🎨 **Multiple themes and color schemes** — choose the look that suits you.
    
-   📁 **Create folders and dictionaries** — organize your vocabulary into structured groups.
    
-   🎮 **Games based on your dictionaries** — reinforce learning through interactive practice.
    
-   🌐 **Quick translation in browser** — open words in a translator with one tap.
    
-   🔍 **Fetch metadata for English words** — get meanings, definitions, phonetics, synonyms, and antonyms (English only for now).
    
-   📤📥 **Export and import dictionaries** — share or save them locally.
    
-   📄 **Clean and simple import/export Json format**:

```json
[
  {
    "name": "Nature",
    "origin": {
      "code": "en",
      "name": "English",
      "native": "English"
    },
    "translation": {
      "code": "uk",
      "name": "Ukrainian",
      "native": "Українська"
    },
    "words": [
      {
        "origin": "tree",
        "translation": "дерево"
      },
      {
        "origin": "garden",
        "translation": "сад"
      },
      {
        "origin": "mountain",
        "translation": "гора"
      }
    ]
  }
]
```

## License

MIT — free to use, modify, and share ❤️

---

<details>
  <summary>Screenshots</summary> 

  ### 🌗 Dark and Light

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/explorer_page_dark.png?raw=true" width="30%"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/explorer_page_light.png?raw=true" width="30%"><img/> 

  ### 📚 Build Vocabulary

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/group_detail_page_light.png?raw=true" width="30%"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/word_detail_page_dark.png?raw=true" width="30%"><img/> 

  > metadata web loading supports only english words
 
  ### 📤 Export your Dictionaries

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/export_page_dark.png?raw=true" width="30%"><img/> 

  > supports formats: json, text and pdf (will be available in future releases)
 
  ### 🎮 Play Games

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_list_page_light.png?raw=true" width="30%"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_compare_dark.png?raw=true" width="30%"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_constructor_dark.png?raw=true" width="30%"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_match_audios_dark.png?raw=true" width="30%"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_match_words_dark.png?raw=true" width="30%"><img/> 

  ### 💻 Desktop or 📱 Tablet

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/desktop/explorer_page_dark.png?raw=true"><img/> 
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/desktop/group_detail_page_dark.png?raw=true"><img/> 

</details>