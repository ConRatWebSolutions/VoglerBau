-- Karriere-Seite (uid 14): Bewerbungs-Kasten ergänzen, E-Mail-Link Ausbildung reparieren. 2026-09-25
-- Wiederholbar: Der Kasten wird nur angelegt, wenn er noch nicht existiert.
-- Styling: c4theme design.css, Abschnitt „Karriere“. Texte aus den Stellenanzeigen übernommen.

-- 1) Bewerbungs-Kasten unter den Stellen (colPos 0, nach dem 2-Spalten-Container)
INSERT INTO tt_content (pid, CType, colPos, sorting, header, header_layout, bodytext, tstamp, crdate, sys_language_uid)
SELECT 14, 'text', 0, 512, 'Jetzt bewerben', 2,
 '<p>Haben wir Ihr Interesse geweckt? Senden Sie uns Ihre Bewerbung mit Lebenslauf und Zeugnissen – digital oder per Post.</p>\n<p class="vb-buttons"><a href="mailto:info@vogler-bau-gmbh.de">Bewerbung per E-Mail</a> <a href="tel:+493601440614">03601 440614</a></p>\n<p>Vogler Bau GmbH · GF Marko Vockrodt · Am Brühl 9 · 99996 Unstruttal / OT Ammern</p>',
 UNIX_TIMESTAMP(), UNIX_TIMESTAMP(), 0
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tt_content WHERE pid = 14 AND header = 'Jetzt bewerben' AND deleted = 0);

-- 2) Ausbildung (uid 30): Leerzeichen nach "mailto:" machte den Link kaputt
UPDATE tt_content SET bodytext = REPLACE(bodytext, 'mailto: info@', 'mailto:info@'), tstamp = UNIX_TIMESTAMP() WHERE uid = 30;
