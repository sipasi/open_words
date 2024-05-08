// import the Workbox library using CDN.

importScripts(
  "https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js"
);

// precacheAndRoute function which takes the path of the files
const { precacheAndRoute } = workbox.precaching;
// self.__WB_MANIFEST will be replased with files precached on the initial load of the app.
CACHE_FILES = self.__WB_MANIFEST ?? [];
precacheAndRoute(CACHE_FILES);

self.addEventListener("install", function (event) {
  self.skipWaiting();
});

self.addEventListener("activate", () => {
  return self.clients.claim();
});
