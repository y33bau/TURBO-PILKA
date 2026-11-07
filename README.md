# ⚽🚗 Turbo Piłka

Gra w stylu Rocket League zrobiona dla Olafa (5 lat): auta grają w piłkę na stadionie w 3D.

## Jak zagrać

- **W przeglądarce:** otwórz stronę gry z GitHub Pages (link w opisie repozytorium).
- **Na komputerze z Windows:** pobierz repozytorium jako ZIP (zielony przycisk **Code → Download ZIP**), rozpakuj i uruchom `URUCHOM GRE.bat`.

Najlepiej działa w Chrome albo Edge. W Edge lektor ma najładniejszy, naturalny głos.

## Sterowanie

| | Pad | Klawiatura (gracz 1) | Klawiatura (gracz 2) |
|---|---|---|---|
| Jazda | lewa gałka | W A S D | strzałki |
| Skok (2× w powietrzu = salto) | A | spacja | Enter |
| Turbo | B / X / RB | lewy Shift | prawy Shift |
| Klakson | LB | H | / |
| Kamera na piłkę | Y | C | M |
| Pauza | START | Esc | |

## Co jest w grze

- Tryby: sam 1 na 1, sam 2 na 2, współpraca 2 na 2, pojedynek 1 na 1 i 2 na 2 na podzielonym ekranie
- 4 poziomy trudności (od „Maluch” do „Trudny”), 3 kamery, dzień / zachód / noc
- Garaż: 31 aut (w tym bajkowe: biedronka, dinozaur, rakieta, lodziarnia, rekin, lokomotywa), kolory, lakiery (połysk, metalik, perła, satyna), ozdoby na dachu, koguty, spojlery, koła, neon, turbo, klaksony i tablice
- Rozpakowywanie nowych aut z pudełka, gwiazdki za mecze
- Lektor po polsku (można go wyłączyć w menu)

## Technika

Jeden plik `index.html` z [three.js](https://threejs.org/) r128 ładowanym z CDN. Modele są w `models/` zapisane jako JavaScript (base64), żeby gra działała także bez serwera.

## Licencje

- Modele aut, stadionu i kibiców: [Kenney](https://kenney.nl) (Car Kit, Racing Kit, Mini Characters), CC0. Szczegóły w `models/LICENSE-kenney.txt`.
- Auta Błysk, Ratownik, Tropiciel i Żuraw: modele Olaf FC.
- Biedronka, dinozaur, rakieta, lodziarnia, rekin i lokomotywa są budowane w kodzie gry.
