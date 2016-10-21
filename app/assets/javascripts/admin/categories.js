$(document).on("turbolinks:load", function(){
  $(".category-name").on('click', function(){
    _this = $(this);

    info = {
      id: $(this).data('id'),
      type: $(this).data('type')
    };
    
    $.ajax({
      url: $(this).data('url'),
      data: info
    })
    .done(function(json_data){
      $("#details").empty();

      heading = $("<p/>");
      heading.html("<u>" + info.type + " " + _this.text() + "</u>");
      list = $("<ol/>");

      $.each(json_data, function(type, products){
        $.each(products, function(index, info){
          item = $("<li/>");
          item.text(info.title);
          list.append(item);
        });
      });

      // $("#details").html(JSON.stringify(json_data));
      $("#details").append(heading);
      $("#details").append(list);
      if (list.find('li').length == 0){
        detail = $("<p/>");
        detail.text("No product available!!!");
        $("#details").append(detail);
      }
    })
    .fail(function(){
      alert('Request Failed.\nSomething went wrong!!!');
    })
  });
});
