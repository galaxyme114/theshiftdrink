// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require jquery.Jcrop
//= require_tree ./vendor
//= require_tree ./admin


$( document ).ajaxStart(function() {
  NProgress.start();
})
.ajaxComplete(function() {
  NProgress.done();
});



$(function() {

  var cropper = $('#link-crop');
  var ratio = 1536 / cropper.width();

  var cropOpts = {
    x      : parseInt($('#hyperlink_coord_x').val()),
    y      : parseInt($('#hyperlink_coord_y').val()),
    width  : parseInt($('#hyperlink_coord_w').val()),
    height : parseInt($('#hyperlink_coord_h').val())
  };

  $('#link-crop').cropper({
    zoomable: false,
    checkCrossOrigin: false,
    checkOrientation: false,
    data: cropOpts,
    crop: function(e) {
      $('#hyperlink_coord_x').val(Math.round(e.x));
      $('#hyperlink_coord_y').val(Math.round(e.y));
      $('#hyperlink_coord_w').val(Math.round(e.width));
      $('#hyperlink_coord_h').val(Math.round(e.height));
    }
  });
});
