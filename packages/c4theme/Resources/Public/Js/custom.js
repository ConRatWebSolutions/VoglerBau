document.addEventListener('DOMContentLoaded', function () {
    // Logo beim Scrollen verkleinern (Größen stehen in design.css)
    var onScroll = function () {
        document.body.classList.toggle('is-scrolled', window.scrollY >= 50);
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();

    // Mobiles Menü – Bootstrap-JS ist nicht eingebunden, daher hier selbst
    var toggler = document.querySelector('.navbar-toggler');
    var menu = document.getElementById('navbarSupportedContent');
    if (toggler && menu) {
        var setOpen = function (open) {
            menu.classList.toggle('show', open);
            toggler.setAttribute('aria-expanded', open ? 'true' : 'false');
        };
        toggler.addEventListener('click', function () {
            setOpen(!menu.classList.contains('show'));
        });
        menu.querySelectorAll('a').forEach(function (link) {
            link.addEventListener('click', function () { setOpen(false); });
        });
    }

    // Telefonnummer im roten Kasten anklickbar machen
    document.querySelectorAll('.text-notably').forEach(function (el) {
        if (el.querySelector('a')) {
            return;
        }
        var match = el.textContent.match(/\+?[\d][\d\s\/-]{6,}\d/);
        if (!match) {
            return;
        }
        var link = document.createElement('a');
        link.href = 'tel:' + match[0].replace(/[^\d+]/g, '');
        link.innerHTML = el.innerHTML;
        el.innerHTML = '';
        el.appendChild(link);
    });
});

// Spamschutz Kontaktformular: das versteckte Feld "spamschutz" wird erst beim
// Absenden gefüllt – und nur, wenn seit dem Laden mindestens 3 Sekunden vergangen sind.
// Bots ohne JavaScript oder mit Sofort-Absendung scheitern an der Prüfung im Formular.
document.addEventListener('DOMContentLoaded', function () {
    var loadedAt = Date.now();
    document.querySelectorAll('form').forEach(function (form) {
        var field = form.querySelector('input[type="hidden"][name$="[spamschutz]"]');
        if (!field) {
            return;
        }
        form.addEventListener('submit', function () {
            var seconds = Math.floor((Date.now() - loadedAt) / 1000);
            field.value = seconds >= 3 ? 'vb-' + seconds : '';
        });
    });
});


// Mobiles Menü öffnen/schließen – Bootstrap-JS ist nicht eingebunden
document.addEventListener('DOMContentLoaded', function () {
    var toggler = document.querySelector('.navbar-toggler');
    var menu = document.getElementById('navbarSupportedContent');
    if (!toggler || !menu) {
        return;
    }
    var setOpen = function (open) {
        menu.classList.toggle('show', open);
        toggler.setAttribute('aria-expanded', open ? 'true' : 'false');
    };
    toggler.addEventListener('click', function () {
        setOpen(!menu.classList.contains('show'));
    });
    menu.querySelectorAll('a').forEach(function (link) {
        link.addEventListener('click', function () { setOpen(false); });
    });
});
