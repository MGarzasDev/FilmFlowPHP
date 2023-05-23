/*Boton*/
var mybutton = document.getElementById("scrollToTopButton");

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

mybutton.onclick = function() {topFunction()};

function topFunction() {
  document.body.scrollTop = 0; 
  document.documentElement.scrollTop = 0; 
}

/*Advice*/
 var images = document.querySelectorAll('.movies_container img');

 var modal = document.getElementById('modal');
 var modalBackground = document.getElementById('modal-background');
 var close = document.getElementById('close');

 for (var i = 0; i < images.length; i++) {
        images[i].addEventListener('click', function(e) {
            e.preventDefault();
            modal.style.display = 'block';
            modalBackground.style.display = 'block';
        });
    }

    close.addEventListener('click', function() {
        modal.style.display = 'none';
        modalBackground.style.display = 'none';
    });