$.fn.extend({
  asynchronously: function(params) {
    var method   = $(this).find("input[name='_method']").val();
    var defaults = {
      type     : ( method === undefined ) ? 'POST' : method,
      url      : $(this).attr('action'),
      data     : $(this).serialize(),
      dataType : 'json',
      encode   : true
    };

    var options = $.extend({}, params = params || {}, defaults);
    
    return $.ajax(options);          
  }
});
