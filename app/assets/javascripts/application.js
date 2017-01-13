// This is a manifest file that'll be compiled into application.js, which will
// include all the files listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts,
// vendor/assets/javascripts, or vendor/assets/javascripts of plugins, if any,
// can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at
// the bottom of the compiled file.
//
// Read Sprockets README
// (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.effect-blind
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function fixDiv() {
  if ($(window).scrollTop() >= '57') {
    $('#cart').css({'position': 'fixed', 'top': '5px', 'border': '3px solid', 'border-radius': '5px', 'margin-left': '-15px', 'margin-right': '5px'});
    $('#cart').height( $(window).height() - 15 );
  } else if ($(window).scrollTop() <= '56') {
    var distance = $(window).scrollTop();
    for (i = 0; i <= distance; i++) {
      var top = 64 - i;
      var window_height = $(window).height() - top - 5;
      $('#cart').css({'position': 'fixed', 'top': top, 'height': window_height, 'border': '3px solid', 'border-radius': '5px', 'margin-left': '-15px', 'margin-right': '5px'});
    }
  }
}

$(window).scroll(fixDiv);
