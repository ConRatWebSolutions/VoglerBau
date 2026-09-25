-- Datenschutzerklärung (tt_content 24): Abschnitt Google Maps an die Zwei-Klick-Lösung angepasst,
-- Rechtsgrundlage Einwilligung statt berechtigtes Interesse. Seite „Test“ (uid 7, leer) gelöscht. 2026-09-25
-- Wiederholbar: REPLACE greift nur, solange der alte Text noch vorhanden ist.

UPDATE tt_content SET bodytext = REPLACE(REPLACE(REPLACE(bodytext,
    'Diese Seite nutzt über eine API den Kartendienst Google Maps.',
    'Auf dieser Seite kann eine Karte des Dienstes Google Maps eingebunden werden.'),
    '<p>Zur Nutzung der Funktionen von Google Maps ist es notwendig, Ihre IP-Adresse zu speichern. Diese Informationen werden in der Regel an einen Server von Google in den USA übertragen und dort gespeichert. Der Anbieter dieser Seite hat keinen Einfluss auf diese Datenübertragung.</p>',
    '<p>Die Karte wird auf unserer Website nicht automatisch geladen. Erst wenn Sie auf „Karte laden“ klicken, wird eine Verbindung zu den Servern von Google hergestellt. Dabei werden insbesondere Ihre IP-Adresse sowie technische Angaben zu Ihrem Browser an Google übertragen, in der Regel an einen Server in den USA, und dort gespeichert. Auf diese Datenübertragung haben wir keinen Einfluss. Solange Sie die Karte nicht laden, werden keine Daten an Google übermittelt.</p>'),
    '<p>Die Nutzung von Google Maps erfolgt im Interesse einer ansprechenden Darstellung unserer Online-Angebote und an einer leichten Auffindbarkeit der von uns auf der Website angegebenen Orte. Dies stellt ein berechtigtes Interesse im Sinne von Art. 6 Abs. 1 lit. f DSGVO dar. Sofern eine entsprechende Einwilligung abgefragt wurde, erfolgt die Verarbeitung ausschließlich auf Grundlage von Art. 6 Abs. 1 lit. a DSGVO; die Einwilligung ist jederzeit widerrufbar.</p>',
    '<p>Die Verarbeitung erfolgt auf Grundlage Ihrer Einwilligung nach Art. 6 Abs. 1 lit. a DSGVO und § 25 Abs. 1 TDDDG, die Sie mit dem Klick auf „Karte laden“ erteilen. Die Einwilligung gilt nur für den jeweiligen Seitenaufruf und wird nicht gespeichert; beim nächsten Besuch wird die Karte erst nach einem erneuten Klick geladen. Sie können Ihre Einwilligung jederzeit mit Wirkung für die Zukunft widerrufen, indem Sie die Seite neu laden und die Karte nicht erneut aktivieren.</p>
<p>Die Datenübertragung in die USA wird auf den Angemessenheitsbeschluss der EU-Kommission zum EU-US Data Privacy Framework gestützt, nach dem Google zertifiziert ist. Über den Link „Route in Google Maps öffnen“ gelangen Sie auf die Website von Google; dort gilt die Datenschutzerklärung von Google.</p>'),
  tstamp = UNIX_TIMESTAMP()
WHERE uid = 24;

-- Leere Seite „Test“ (/leistungen/test) in den Papierkorb (deleted = 1, im Backend wiederherstellbar)
UPDATE pages SET deleted = 1, tstamp = UNIX_TIMESTAMP()
WHERE uid = 7 AND title = 'Test'
  AND NOT EXISTS (SELECT 1 FROM (SELECT pid FROM tt_content WHERE pid = 7 AND deleted = 0) c)
  AND NOT EXISTS (SELECT 1 FROM (SELECT pid FROM pages WHERE pid = 7 AND deleted = 0) p);
