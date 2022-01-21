$(function() {

  var cropbox = $('#cropbox');
  var options = {
    aspectRatio : 1.8,
    setSelect   : [0,0, cropbox.width(), 500],
    allowResize : false,
    allowSelect : false,
    onSelect    : function(c) {
        $('#article_page_crop_x').val(c.x);
        $('#article_page_crop_y').val(c.y);
        $('#article_page_crop_h').val(c.h) + 240;
        $('#article_page_crop_w').val(c.w);  
    }
  };

  cropbox.Jcrop(options);
  
});