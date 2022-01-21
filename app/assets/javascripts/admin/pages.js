
$(function() {

/* -----------------------------------------*
 *             SORTABLE FUNCTIONS           *
 * -----------------------------------------*/

  $('#pages').sortable({ forcePlaceholderSize: true }).bind('sortupdate', function(e, ui) {
    $(this).updateSorted('div#pages .col-md-3', 'page');
  });

  $('#articles .sortable').sortable().bind('sortupdate', function(e, ui) {
    $(this).updateSorted('#articles li', 'article');
  });

/* -----------------------------------------*
 *             THUMBNAIL CAPTIONS           *
 * -----------------------------------------*/

  $("[rel='tooltip']").tooltip();

  $('.thumbnail').hover(
    function() {
      $(this).find('.caption').slideDown(250); //.fadeIn(250)
    },
    function() {
      $(this).find('.caption').slideUp(250); //.fadeOut(205)
    }
  );

/* -----------------------------------------*
 *            SET THUMBNAIL HEIGHT          *
 * -----------------------------------------*/

  $("#create-page").on('click', function () {
    $("#page_image").trigger('click');
  });

  $("#page_image").change(function() {
    $("#new_page").submit();
  });

  $("#create-media").on('click', function () {
    $("#media_asset").trigger('click');
  });

  $("#media_asset").change(function() {
    $("#new_media").submit();
  });
});
