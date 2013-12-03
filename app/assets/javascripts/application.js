// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require twitter/bootstrap
//= require jquery.rateit
//= require_tree .

$(function() {
  $('.text').attr('rows', 5);
  $(".datepicker").datepicker();
});

function toggleOverlay() {
  var overlay = document.getElementById('overlay');
  var specialBox = document.getElementById('specialBox');

  overlay.style.opacity = 0.8;

  if(overlay.style.display == 'block') {
    overlay.style.display = 'none';
    specialBox.style.display = 'none';
  }
  else {
    overlay.style.display = 'block';
    specialBox.style.display = 'block';
  }
}

function showOverlay() {
  var overlay = document.getElementById('overlay');
  var specialBox = document.getElementById('specialBox');

  overlay.style.opacity = 0.8;

  if(overlay.style.display != 'block') {
    overlay.style.display = 'block';
    specialBox.style.display = 'block';
  }
}

function hideOverlay() {
  var overlay = document.getElementById('overlay');
  var specialBox = document.getElementById('specialBox');

  overlay.style.opacity = 0.8;

  if(overlay.style.display == 'block') {
    overlay.style.display = 'none';
    specialBox.style.display = 'none';
  }
}
