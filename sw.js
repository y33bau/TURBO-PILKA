// Turbo Piłka – service worker: gra instaluje się jak aplikacja i działa też bez internetu.
const CACHE = 'turbo-pilka-v2';
const CORE = [
  './',
  './index.html',
  './manifest.webmanifest',
  './models/cars.js',
  './models/olaf.js',
  './models/stadium.js',
  './models/Textures/colormap.png',
  './models/chars/Textures/colormap.png',
  './icons/icon-192.png',
  './icons/icon-512.png'
];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(CORE)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', e => {
  e.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  // strona gry: najpierw sieć (żeby od razu była najnowsza wersja), bez internetu – kopia z pamięci
  if (req.mode === 'navigate' || (url.origin === location.origin && url.pathname.endsWith('/index.html'))) {
    e.respondWith(fetch(req).then(r => { const copy = r.clone(); caches.open(CACHE).then(c => c.put('./index.html', copy)); return r; })
      .catch(() => caches.match('./index.html')));
    return;
  }
  // modele, biblioteki z CDN i czcionki: z pamięci, w tle odświeżane
  e.respondWith(caches.match(req).then(hit => {
    const net = fetch(req).then(r => { if (r && (r.ok || r.type === 'opaque')) { const copy = r.clone(); caches.open(CACHE).then(c => c.put(req, copy)); } return r; }).catch(() => hit);
    return hit || net;
  }));
});
