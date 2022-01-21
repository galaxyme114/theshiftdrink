$(function() {
  // how are we tracking issue_id?
  var issue_id = $('#issue_id').val();

  /**
   * Track social button sharing
   * 
   * @sends Google Analytics event
   */
  $(document).on('click taphold', '.btn-facebook, .btn-twitter', function() {
    if ( typeof ga === 'function' ) {
      ga('send', {
        hitType       : 'event',
        eventCategory : 'Social',
        eventAction   : $("meta[property='og:url']").attr("content"),
        eventLabel    : $(this).data('social')
      });

      console.log("Social share from "+$(this).data('social')+" tracked.");
    };
  });


  $(document).on('click taphold', '.hyperlink', function() {
    if ( typeof ga === 'function' ) {
      ga('send', {
        hitType       : 'event',
        eventCategory : 'External Link',
        eventAction   : $(this).parent('.map').attr('name'),
        eventLabel    : $(this).attr('href')
      });

      console.log("External hit to "+$(this).attr('href')+" tracked.");
    };
  });
});