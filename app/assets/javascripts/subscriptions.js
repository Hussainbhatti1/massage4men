$(document).on('ajax:success', 'form[data-remote=true].new_subscription', function(event, data, status, xhr) {
	if(data.success) {
		//	Redirect to dashboard if we have the URL, otherwise home
		window.location.replace(data.dashboard_url ? data.dashboard_url : '/');		
	} else {
		swal({
			title: 'Error',
			text: 'An unexpected error occured. Please try again.',
			type: 'error'
		});
	}
});

//	Add errors to modal subscription form
$(document).on('ajax:error', 'form[data-remote=true].new_subscription', function(event, xhr, status, error) {
	//	Enumerate through errors if any were found
	$.each(xhr.responseJSON.errors.card, function(field, err) {
		$('.form-group[class$=_' + field + ']').addClass('has-error');

		//	Append a hint for each error to the field
		$('input[id$=card_' + field + ']').after('<p class="help-block error-block">' + err + '</p>');
	});
	
	$(this).find('input').removeAttr('disabled');
	
	//	Reset submit button since disable_with doesn't work on block buttons
	// $(this).find('input[type=submit]').val('<i class="fa fa-lock"></i> Complete Sign Up')
});

/*
	New/Activate Subscription; not modal
*/
$(function() {
	$('.panel-faded input').prop('disabled', true);
});

$(document).on('click', '.subscription-packages button', function(e) {
	$('.subscription-packages button').removeClass('btn-primary').addClass('btn-default').find('small').addClass('text-muted');
	$(this).removeClass('btn-default').addClass('btn-primary').find('.text-muted').removeClass('text-muted');	

	$('#promo_code_subscription_type, #subscription_subscription_type').val($(this).attr('data-subscription-type'));
});

$(document).on('click', '.subscription-packages button, .no-promo-code', function(e) {
	e.preventDefault();

	var next_panel = $($(this).closest('.panel').attr('data-next-panel'));
	
	next_panel.animate({'opacity': '1.0'}, 250, function() {
		next_panel.find('input').prop('disabled', false);
		next_panel.find('input:not([type=hidden])').first().focus();
	});
});