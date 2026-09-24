$(document).ready(function(){
    $(window).scroll(function(){
        if($(this).scrollTop()>=50){
        $('.logo').attr('style','width:65px !important;');
        
    }  
        else if ($(this).scrollTop()<50) {
        $('.logo').attr('style','width:220px !important')
             
        }
    })
    
    $( ".primary-menu__link" ).click(function() {
      
        if ($(this).attr('href') == "#karriere") {
  window.location.href = "https://www.vogler-bau.de/karriere";
}
        
            
            
        
   });
})

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
