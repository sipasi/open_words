# Open Words

**Open Words** is a simple yet powerful app for creating personal dictionaries, reviewing vocabulary through games, and learning foreign languages.

This app is the **next generation** of my earlier [.NET MAUI](https://github.com/sipasi/OpenDictionary), now fully rewritten in **Flutter** with expanded **functionality** and a **modern UI**..

> For the best results, use **English** as the base language along with the language you're learning.

## Table of Contents
- [Open Words](#open-words)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Data Format (Import/Export Json)](#data-format-importexport-json)
    - [Example JSON](#example-json)
    - [Structure](#structure)
  - [Data Sources](#data-sources)
  - [Supported Platforms](#supported-platforms)
  - [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Install and Run](#install-and-run)
  - [Bug Reporting](#bug-reporting)
  - [License](#license)
  - [Screenshots](#screenshots)

## Features
All features are **designed** to help you **stay organized** and make **learning** more **interactive** and **fun**.

-   🎙️ **Text-to-Speech support and configuration** — listen to word pronunciation.
    
-   🎨 **Multiple themes and color schemes** — choose the look that suits you.
    
-   📁 **Create folders and dictionaries** — organize your vocabulary into structured groups.
    
-   🎮 **Games based on your dictionaries** — reinforce learning through interactive practice.
    
-   🌐 **Quick translation in browser** — open words in a translator with one tap.
    
-   🔍 **Fetch metadata for English words** — get meanings, definitions, phonetics, synonyms, and antonyms (English only for now).
    
-   📤📥 **Export and import dictionaries** — share or save them locally.
 
## Data Format (Import/Export JSON)

The app uses a clean and simple **JSON** format for **importing** and **exporting** dictionaries.
Internally, Open Words stores data in a **local SQL database** for performance and scalability.

### Example JSON

```json
[
  {
    "name": "Nature",
    "origin": "en",
    "translation": "uk",
    "words": [
      { "origin": "tree", "translation": "дерево" },
      { "origin": "garden", "translation": "сад" },
      { "origin": "mountain", "translation": "гора" }
    ]
  }
]
```

### Structure

Each dictionary (or word group) is represented as an object inside a JSON array:

- **`name`**: The title of the word group (e.g., `"Nature"`).
- **`origin`**: Either an ISO language code (e.g., `"en", "uk"`)
- **`translation`**: Same as `origin`, but for the target language.
- **`words`**: An array of word pairs:
  - `origin`: Word in the source language
  - `translation`: Corresponding word in the target language

This flexible and minimal structure makes it easy to back up, share, and transfer your vocabulary across devices.
 
## Data Sources

Open Words fetches English word metadata — including definitions, phonetics, synonyms, and antonyms — from the [Dictionary API](https://dictionaryapi.dev/), a free and open-source dictionary API.

Example API request for the word "advice":  
[https://api.dictionaryapi.dev/api/v2/entries/en/advice](https://api.dictionaryapi.dev/api/v2/entries/en/advice)

You can find their source code and documentation here:  
[GitHub - meetDeveloper/freeDictionaryAPI](https://github.com/meetDeveloper/freeDictionaryAPI)

## Supported Platforms

| Platform  | Status                | Notes                                                   |
| --------- | --------------------- | ------------------------------------------------------- |
| 🪟 Windows | ✅ Fully tested        | Stable and fully functional                             |
| 🤖 Android | ✅ Fully tested        | Optimized for phones and tablets                        |
| 🌐 Web     | ⚠️ Partially supported | UI works, but local database is **not implemented yet** |
| 🐧 Linux   | ❓ Untested            | Expected to work, but not yet tested                    |
| 🍏 iOS     | ❓ Untested            | Expected to work, but not yet tested                    |
| 🍏 macOS   | ❓ Untested            | Expected to work, but not yet tested                    |

> 🧪 If you test on an unverified platform, feel free to [open an issue](https://github.com/sipasi/open_words/issues) or contribute!

## Getting Started

### Requirements

* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* A device or emulator (Android, iOS, Windows, macOS, or Linux)

### Install and Run

Clone the repository:

```bash
git clone https://github.com/sipasi/open_words.git
cd open_words
```

Get the dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Make sure you have the appropriate platform toolchains installed. Refer to the [official Flutter docs](https://docs.flutter.dev/get-started/install) if needed.
  
## Bug Reporting

Found a bug or want to request a feature?

1. Go to the [Issues page](https://github.com/sipasi/open_words/issues)
2. Click **New issue**
3. Choose **Bug report** or **Feature request**
4. Fill in the template with as much detail as possible:

   * Steps to reproduce
   * Expected vs actual behavior
   * Device and OS info
   * Screenshots (if relevant)

Your feedback helps make Open Words better — thank you! 💛

## License

MIT — free to use, modify, and share ❤️

## Screenshots

<details>
  <summary>expand</summary> 

  ### Dark and Light

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/explorer_page_dark.png?raw=true" width="30%"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/explorer_page_light.png?raw=true" width="30%"/>

  ### Build Vocabulary

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/group_detail_page_light.png?raw=true" width="30%"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/word_detail_page_dark.png?raw=true" width="30%"/>

  > metadata web loading supports only english words
 
  ### Export your Dictionaries

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/export_page_dark.png?raw=true" width="30%"/>

  > supports formats: json, text and pdf (will be available in future releases)
 
  ### Play Games

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_list_page_light.png?raw=true" width="30%"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_compare_dark.png?raw=true" width="30%"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_constructor_dark.png?raw=true" width="30%"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_match_audios_dark.png?raw=true" width="30%"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/phone/game_match_words_dark.png?raw=true" width="30%"/>

  ### Desktop or Tablet

  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/desktop/explorer_page_dark.png?raw=true"/>
  <img src="https://github.com/sipasi/open_words/blob/main/screenshots/desktop/group_detail_page_dark.png?raw=true"/>

</details>