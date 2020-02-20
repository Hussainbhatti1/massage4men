//	Custom behavior for registration form
$(document).on('ajax:success', '.new_masseur[data-remote=true]', function(event, data, status, xhr) {
	//	If we don't need to pay, go straight to the dashboard
	if(!data.payment_required) {
		window.location.replace(data.dashboard_url);
	} else {
		var subscription_page = data.next_page_url;

		$('.modal').attr('data-cancel-url', data.dashboard_url);
	
		$(this).find('.form-group').addClass('has-success');

		//	Load the subscription page into the modal
		$('.modal-content form').css('opacity', '.25');
	
		$('.modal-content').spin({color: '#000'}).load(subscription_page, function() {
			$('.modal-content').spin(false);
			$('.modal-content form').css('opacity', '1.0');
		});			
	}	
});

$(function() {
  //  Apply phone format when switching countries
  $('[name$="country]"]').on('change', function() {
    $.getJSON('/country_info', {'country_code' : $(this).val()}, function(data) {
      //  Format the phone numbers properly
      if(data.phone_format) {
        $('input[type=tel]').unmask().mask(data.phone_format).attr('data-mask', data.phone_format);      
      } else {
        $('input[type=tel][data-mask]').unmask();
      }
    
      //  Hide postal code if not needed
      if(data.use_postal_code) {
        $('.form-group[class$=_zip], .form-group[class$="_zip hide"]').removeClass('hide').fadeIn();      
      } else {
        $('[name$="zip]"]').val('');
        $('.form-group[class$=_zip], .form-group[class$="_zip show"]').removeClass('show').fadeOut();
      }

      //  Remove everything in the state dropdown
      $('[name$="state]"] option').remove();

      //  Add the states for this region
      $.each(data.subregions, function(key, value) {
        state = $(value);

        add_option_to_select($('[name$="state]"]'), state.last()[0], state.first()[0]);
      });
    

    }).fail(function(jqxhr, text_status, error) {
        swal({
          title: 'Error',
          type: 'error',
          text: jqxhr.responseJSON.error
        });
      });
  });  
});

function add_option_to_select(select, value, text) {
  select.append($('<option></option').attr('value', value).text(text));
}