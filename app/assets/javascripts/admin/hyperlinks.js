$(function() {
  var overlay = $('.page-overlay');
  var styles  = {
    '#hyperlink_coord_x': 'left',
    '#hyperlink_coord_y': 'top',
    '#hyperlink_coord_w': 'width',
    '#hyperlink_coord_h': 'height'      
  };

  $('#page-coordinates input').on('change', function() {
    var id = '#' + $(this).attr('id');
    var value = $(this).val();

    overlay.css(styles[id], value + 'px');
  });
});