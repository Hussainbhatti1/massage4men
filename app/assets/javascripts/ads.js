//	Remove all handlers to prevent static rating widget from changing
$(function() {
	$('.static-rating').unbind();
});

//  CALL MASSEUR
$(document).on('click', '.call-masseur', function(e) {
  e.preventDefault();
  var phone = $(this).data('number');
  
  swal({
    title: 'Call ' + $('.user-meta .panel-title .masseur-name').text(),
    text: phone,
    imageUrl: '/icon-phone.png'
  });
});

//  FAVORITE/DEFAVORITE
$(document).on('click', '.favorite-masseur', function(e) {
  e.preventDefault();
  
  $.post($(this).attr('href'), {id: $(this).data('masseur-id')}, function(data) {
    if(data.success) {     
      $('.favorite-masseur').html('<i class="fa fa-ban"></i> Defavorite').removeClass('favorite-masseur').addClass('defavorite-masseur').attr('href', data.defavorite_url);
    } else {
      swal({
        title: 'Error',
        text: data.error,
        type: 'error'
      });
    }
  });
});

$(document).on('click', '.defavorite-masseur', function(e) {
  e.preventDefault();
  
  $.post($(this).attr('href'), {id: $(this).data('masseur-id')}, function(data) {
    if(data.success) {     
      $('.defavorite-masseur').html('<i class="fa fa-heart"></i> Favorite').removeClass('defavorite-masseur').addClass('favorite-masseur').attr('href', data.favorite_url);
    } else {
      swal({
        title: 'Error',
        text: data.error,
        type: 'error'
      });
    }
  });
});

//  Ad type management
$('.massage-type-select').on('change', function(e) {
  //  Each option can be selected only once
  selected_option = $(this).val();
  ad_index = $(this).data('ad-index');
	
  if(selected_option) {
    if($('.massage-type-select').length > 1) {
      $('.massage-type-select:not([data-ad-index=' + ad_index + ']) option[value=' + selected_option + ']').prop('disabled', true);        
    }
		
		//	TODO FIX THIS IT'S HARDCODED
		if($(this).val() != 1) {
			$('[data-toggle=modal][data-ad-index=' + ad_index + ']').attr('data-show-nsfw', true);
		} else {
			$('.remove-photo-from-ad[data-nsfw=true]').click();
			$('[data-toggle=modal][data-ad-index=' + ad_index + ']').attr('data-show-nsfw', false);			
		}    
  }
});

var form_promises = [$.Deferred(), $.Deferred(), $.Deferred()];
var all_forms_submitted = $.when(form_promises[0], form_promises[1], form_promises[2]);

all_forms_submitted.done(function() {
  window.location.replace($('.continue-to-checkout').attr('href'));
});

$('form.new_ad').bind('ajax:complete', function() {
  var ad_index = $(this).attr('data-ad-index');
  form_promises[ad_index].resolve();
});


$('.continue-to-checkout').on('click', function(e) {
  e.preventDefault();
  
  var form1 = $('form.new_ad[data-ad-index=0]');
  var form2 = $('form.new_ad[data-ad-index=1]');
  var form3 = $('form.new_ad[data-ad-index=2]');

  if(form1.length > 0) {
    //  If the form exists, check if it's submittable
    if(form1.data('submittable')) {
      form1.submit();
    } else {
      form_promises[0].resolve();      
    }
  } else {
    //  Resolve the promise if the form doesn't exist, so we can continue
    form_promises[0].resolve();
  }

  if(form2.length > 0) {
    //  If the form exists, check if it's submittable
    if(form2.data('submittable')) {
      //  Submit the form
      form2.submit();
    } else {
      form_promises[1].resolve();      
    }
  } else {
    form_promises[1].resolve();
  }

  if(form3.length > 0) {
    //  If the form exists, check if it's submittable
    if(form3.data('submittable')) {
      //  Submit the form
      form3.submit();
    } else {
      form_promises[2].resolve();
    }
  } else {
    form_promises[2].resolve();
  }
});

function initialize_slider(slider) {
  slider.slick({
    dots: false,
    infinite: false,
    speed: 300,
    slidesToShow: 3,
    slidesToScroll: 3,
    responsive: [
      {
        breakpoint: 1024,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 3,
          infinite: true,
          dots: false
        }
      },
      {
        breakpoint: 600,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2
        }
      },
      {
        breakpoint: 480,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }
    ]
  });  
}

$(function() {
  //  AD PHOTO CAROUSEL
  initialize_slider($('.slider-responsive'));
});

//  PHOTO ATTACHMENT
$(document).on('show.bs.modal', '.add-photo-modal', function(e) {
  var btn = $(e.relatedTarget);
  
  if(btn.data('primary')) {
    //  Set a flag on the modal so we know it's the primary photo
    $(this).data('primary', true);
  }
	
	if(btn.attr('data-show-nsfw') == 'true') {
		$(this).find('[data-nsfw=true]').show();
	} else {
		$(this).find('[data-nsfw=true]').hide();
	}  
});

$(document).on('hide.bs.modal', '.add-photo-modal', function(e) {
  $(this).removeData('primary');
});

$(document).on('click', '.add-photo-to-ad', function(e) {
  e.preventDefault();
  
  var photo_id = $(this).data('photo-id');
  var ad_index = $(this).data('ad-index');
  
  //  Check the proper association checkbox
  $('input[type=checkbox][value=' + photo_id + '][data-ad-index=' + ad_index + ']').prop('checked', true);

  //  Make sure it removes when clicked
  $(this).removeClass('add-photo-to-ad').addClass('remove-photo-from-ad');
  
  if($('.add-photo-modal[data-ad-index=' + ad_index + ']').data('primary')) {
    //  Update primary_photo_id field
    $('form[data-ad-index=' + ad_index + '] #primary_photo_id').val($(this).attr('data-photo-id'));
    
    //  Hide Add Primary button
    $('form[data-ad-index=' + ad_index + '] .add-primary').addClass('hide');
    
    //  Move to primary grid
    $(this).detach().attr('data-primary', true).prependTo($('.primary-ad-photo[data-ad-index=' + ad_index + '] .row:last-child'));

    //  Show next step
    // $('form.new_ad[data-ad-index=' + ad_index + '] .other-photos-panel').fadeIn();

    //  Close modal
    $('.add-photo-modal[data-ad-index=' + ad_index + ']').modal('hide');
  } else {
    //  If an ad has at least one photo, it is submittable
    $('form.new_ad[data-ad-index=' + ad_index + ']').attr('data-submittable', true);

    //  MOVE to main grid
    $(this).detach().appendTo($('.ad-photos[data-ad-index=' + ad_index + '] .row:last-child'));
    
    //  Redraw main grid
    redraw_grid($('.ad-photos[data-ad-index=' + ad_index + ']'), 'div[data-photo-id]', 4);

    //  Redraw modal grid
    redraw_grid($('.add-photo-modal[data-ad-index=' + ad_index + '] .add-photo-grid'), 'div[data-photo-id]', 4);    
  }
});  

$(document).on('click', '.remove-photo-from-ad', function(e) {
  e.preventDefault();

  var photo_id = $(this).data('photo-id');
  var ad_index = $(this).data('ad-index');
  
  //  Uncheck the appropriate checkbox
  $('input[type=checkbox][value=' + photo_id + '][data-ad-index=' + ad_index + ']').prop('checked', false);
    
  $(this).removeClass('remove-photo-from-ad').addClass('add-photo-to-ad');
    
  if($(this).data('primary')) {
    //  Clear the hidden field
    $('form[data-ad-index=' + ad_index + '] #primary_photo_id').val('');
    
    //  Move back to the modal grid
    $(this).detach().removeData('primary').appendTo('.add-photo-modal[data-ad-index=' + ad_index + '] .add-photo-grid .row:last-child');

    //  Restore the Primary button
    $('form[data-ad-index=' + ad_index + '] .add-primary').removeClass('hide');
  } else {
    //  Move from main grid to modal grid
    $(this).detach().appendTo('.add-photo-modal[data-ad-index=' + ad_index + '] .add-photo-grid .row:last-child');

    //  Redraw main grid
    redraw_grid($('.ad-photos[data-ad-index=' + ad_index + ']'), 'div[data-photo-id]', 4);
  }
});

$(document).on('show.bs.modal', '.add-photo-modal', function (event) {
  var button = $(event.relatedTarget);
  var ad_index = button.data('ad-index');

  redraw_grid($('.add-photo-modal[data-ad-index=' + ad_index + '] .add-photo-grid'), 'div[data-photo-id]', 4);

  $(this).find('.selected').removeClass('selected');
  
  $(this).find('.add-photo-to-ad').attr('data-ad-index', ad_index);  
});

$(document).on('click', '.ad-change-step', function(e) {
	e.preventDefault();
	
	var next_panel = $(this).data('next-panel');
	
	$(this).closest('.panel-default').fadeOut('fast', function(e) {
		$(next_panel).fadeIn('fast');
	});
});

function redraw_grid(grid, item_selector, items_per_row) {
  //  Accepts a jQuery object
  //  Unwrap all of the rows in the grid
  //  How many items total are in the grid?
  var items = grid.find(item_selector);
    
  //  Remove all rows from the grid
  $(items).unwrap();
  
  // Go through the items in groups of $items_per_row
  $.each(items.inGroupsOf(items_per_row), function(i, v) {
    $(v).wrapAll('<div class="row">');
  });
}