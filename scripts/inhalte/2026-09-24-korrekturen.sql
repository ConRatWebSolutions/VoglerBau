-- Inhaltskorrekturen Vogler Bau, 2026-09-24 (Punkt 5 „Leistungstitel“ separat: 2026-09-24-leistungstitel.sql, erst mit dem neuen Design)
-- Wiederholbar (idempotent). Ausführen lokal:  ddev mysql < scripts/inhalte/2026-09-24-korrekturen.sql
-- Danach: vendor/bin/typo3 cache:flush

-- 1) Kontakt: E-Mail-Link (Leerzeichen nach "mailto:" machte den Link kaputt)
UPDATE tt_content SET bodytext = REPLACE(bodytext, 'mailto: info@', 'mailto:info@'), tstamp = UNIX_TIMESTAMP() WHERE uid = 10;

-- 2) Google Maps nur nach Klick laden (vorher sofort mit API-Key ohne Einwilligung)
UPDATE tt_content SET bodytext = '<div class="vb-map" id="map" style="position:relative;height:350px;width:100%;background:#e9e7e3;">
  <div class="vb-map__consent" style="position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:14px;padding:24px;text-align:center;font-size:15px;line-height:1.5;color:#2b2b2b;">
    <svg width="40" height="40" viewBox="0 0 24 24" fill="#c8302a" aria-hidden="true"><path d="M12 2a7 7 0 0 0-7 7c0 5.25 7 13 7 13s7-7.75 7-13a7 7 0 0 0-7-7zm0 9.5A2.5 2.5 0 1 1 12 6.5a2.5 2.5 0 0 1 0 5z"/></svg>
    <strong style="font-size:18px;">Vogler Bau GmbH &middot; Am Brühl 9 &middot; 99996 Unstruttal OT Ammern</strong>
    <span style="max-width:560px;">Beim Laden der Karte werden Daten (u.&nbsp;a. Ihre IP-Adresse) an Google übertragen. Mehr dazu in unserer <a href="/datenschutz" style="color:#c8302a;">Datenschutzerklärung</a>.</span>
    <button type="button" class="vb-map__load" style="background:#c8302a;color:#fff;border:0;border-radius:4px;padding:10px 26px;font-weight:600;letter-spacing:.04em;text-transform:uppercase;cursor:pointer;">Karte laden</button>
    <a href="https://www.google.com/maps/dir/?api=1&amp;destination=51.2404978,10.4525038" target="_blank" rel="noopener noreferrer" style="color:#2b2b2b;font-size:14px;">Route in Google Maps öffnen</a>
  </div>
</div>
<script>
  (function () {
    var box = document.getElementById(\'map\');
    var button = box && box.querySelector(\'.vb-map__load\');
    if (!button) { return; }
    button.addEventListener(\'click\', function () {
      box.innerHTML = \'<iframe title="Karte Vogler Bau GmbH" src="https://www.google.com/maps?q=51.2404978,10.4525038&z=14&output=embed" style="border:0;width:100%;height:100%;" loading="lazy" referrerpolicy="no-referrer-when-downgrade" allowfullscreen></iframe>\';
    });
  })();
</script>
', tstamp = UNIX_TIMESTAMP() WHERE uid = 27 AND CType = 'html';

-- 3) Impressum: TMG wurde 2024 durch das DDG ersetzt (Paragraphen gleich)
UPDATE tt_content SET bodytext = REPLACE(REPLACE(REPLACE(bodytext,
    '§ 5 TMG', '§ 5 DDG'), '§ 7 Abs.1 TMG', '§ 7 Abs. 1 DDG'), '§§ 8 bis 10 TMG', '§§ 8 bis 10 DDG'),
    tstamp = UNIX_TIMESTAMP() WHERE uid = 4;

-- 4) Footer: „Datenschutzhinweis“ verlinkte auf ?cmpscreen (Cookie-Tool, das nicht eingebunden ist) → ausblenden
UPDATE pages SET hidden = 1, tstamp = UNIX_TIMESTAMP() WHERE uid = 13 AND link = '?cmpscreen';
