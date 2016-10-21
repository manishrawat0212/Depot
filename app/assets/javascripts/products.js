$(document).on("turbolinks:load", function(){
  $('#main table .product-images').find('img:first').siblings("img").hide();
  createImageNavigators();
  navigateImage();
});

function set_category_type(){
  category_type = $("#product_category_id").find(":selected").data('type');
  $("#product_category_type").val(category_type);
}

function createImageNavigators(){
  image_container = $('.product-images').filter(function(){
    if($(this).find('img').length > 1){
      return true
    }
    return false
  })

  previous_button = $("<button/>");
  previous_button.addClass('previous-button');
  previous_button.html("<b><</b>");
  image_container.append(previous_button);
  $('.previous-button').prop('disabled', true);

  next_button = $("<button/>");
  next_button.addClass('next-button');
  next_button.html("<b>></b>");
  image_container.append(next_button);
}

function navigateImage(){
  $('.previous-button').on('click', function(){
    $(this).closest('td').find('.next-button').prop('disabled', false);
    all_images = $(this).closest('td').find("img");
    current_image = all_images.filter(function(){
      return this.style.display !== 'none';
    });
    current_image_index = all_images.index(current_image);
    previous_image = all_images.eq(current_image_index - 1);
    previous_image.siblings('img').hide();
    previous_image.show();
    if(current_image_index - 1 == 0){
      $(this).prop('disabled', true);
      return;
    }
  });

  $('.next-button').on('click', function(){
    $(this).closest('td').find('.previous-button').prop('disabled', false);
    all_images = $(this).closest('td').find("img");
    current_image = all_images.filter(function(){
      return this.style.display !== 'none';
    });
    current_image_index = all_images.index(current_image);
    next_image = all_images.eq(current_image_index + 1);
    next_image.siblings('img').hide();
    next_image.show();
    if(current_image_index + 1 == all_images.length - 1){
      $(this).prop('disabled', true);
      return;
    }
  });
}

  // image_container.slider({
  //   slide: function (event, ui) {
  //     image_container = $(this).closest("td");
  //     images = image_container.find("img");

  //     if(image_container.find("img").length == 2){
  //       if(ui.value > 0 && ui.value < 50){
  //         images.eq(0).show();
  //         images.eq(0).siblings("img").hide();
  //       }
  //       else{
  //         images.eq(1).show();
  //         images.eq(1).siblings("img").hide();
  //       }
  //     }
  //     else if(image_container.find("img").length == 3){
  //       if(ui.value > 0 && ui.value < 33){
  //         images.eq(0).show();
  //         images.eq(0).siblings("img").hide();
  //       }
  //       else if(ui.value > 33 && ui.value < 66){
  //         images.eq(1).show();
  //         images.eq(1).siblings("img").hide();
  //       }
  //       else{
  //         images.eq(2).show();
  //         images.eq(2).siblings("img").hide();
  //       }
  //     }
  //   }
  // });
