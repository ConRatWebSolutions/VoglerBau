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