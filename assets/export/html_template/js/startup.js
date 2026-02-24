/**
 * @param {string} url - The URL of the template file.
 * @returns {Promise<string>} The text content of the response.
 */
async function fetchJson() {
  return window.json_source_data ?? {};
}

async function initializeApp() {
  const appRoot = document.getElementById('app-root');

  const lits = new DictionaryList();

  appRoot.appendChild(lits);

  try {
    lits.items = await fetchJson();
  } catch (error) {
    console.error("Error during app initialization:", error);
    rootListContainer.innerHTML = '<p class="error">Could not load dictionary data.</p>';
  }
}


document.addEventListener('DOMContentLoaded', initializeApp);