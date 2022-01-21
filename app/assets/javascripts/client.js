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
//= require admin/extensions
//= require_tree ./vendor
//= require_tree ./client

$(function() {
  $('map').imageMapResize();
});

$(document).on('click', 'a.disabled', function(e) {
  e.preventDefault(); e.stopPropagation();
});

$.fn.adRequest = function(url) {
  var $object = $(this);

  $.getJSON(url).success(function(response) {
  	var placement = response['placements']['placement_1'];

    // Google ads
  	if ( placement !== undefined && placement.body != "" ) {
      $object.html(placement.body);
  	};

    // Image ads
  	if ( placement !== undefined && placement.image_url !== "" ) {
      $object.html('<a href="'+placement.redirect_url+'" target="_blank"><img src="'+placement.image_url+'"></a>');
  	};
  });
};
