$.fn.extend({
  updateSorted: function(items, object) {
    var params = {};
    var items  = $(items).map(function() {
        return $(this).data('identifier');
    }).get();

    params[object] = items;

    var options = {
      url         : $(this).data('href'),
      data        : JSON.stringify(params),
      type        : 'PATCH',
      contentType : 'application/json',
      processData : false,
      dataType    : 'json'            
    };

    return $.ajax(options);
  },

  visible: function() {
    return $(this).css('visibility', 'visible');
  },

  invisible: function() {
    return $(this).css('visibility', 'hidden');    
  }
});

jQuery.extend({
  getValues: function(url) {
    var result = null;
    
    $.ajax({
      url      : url,
      type     : 'get',
      dataType : 'json',
      async    : false,
      success  : function(data) {
        result = data;
      }
    });
   
   return result;
  }
});