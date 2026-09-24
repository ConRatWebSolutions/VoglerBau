-- Leistungstitel <h1> → <h3>, ohne Leerzeilen (Vogler Bau, 2026-09-24)
-- Erst zusammen mit dem neuen Design einspielen (design.css stylt die Kacheltitel), sonst werden die Titel kleiner.
-- Wiederholbar.
UPDATE tt_content SET bodytext = REPLACE(REPLACE(REPLACE(REPLACE(bodytext,
    '<h1><br /> ', '<h3>'), '<h1>', '<h3>'), '</h1>', '</h3>'), '<p>&nbsp;</p>', ''),
    tstamp = UNIX_TIMESTAMP() WHERE uid IN (11, 12, 13, 26);
UPDATE tt_content SET bodytext = TRIM(BOTH '\n' FROM bodytext) WHERE uid IN (11, 12, 13, 26);
