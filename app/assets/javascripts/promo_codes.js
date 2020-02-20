$(document).on('ajax:success', '.validate-code', function(event, data, status, xhr) {
	if(data.valid) {
		$('.promo-code-container').fadeOut(250, function() {
			if(!data.requires_payment) {
				//	If the rest is free then display success and forward...
				show_success('Starting your free trial...');
				window.location.href = data.dashboard_url;			
			} else {
				if($('#code_code')) {
					$('#code_code').val(data.code)
				}
				show_success(data.description);
			}
		});		
	} else {
		swal({
			title: 'Invalid Promo Code',
			text: 'That promo code has expired or doesn\'t exist.',
			type: 'error'
		});
	}
});

$(document).on('ajax:error', '.validate-code', function(event, xhr, status, error) {
	//	This shoud handle itself...
});

function show_success(msg) {
	$('.promo-code-panel').hide();
	$('.validate-code-success span').text(msg);
	$('.validate-code-success').removeClass('hide');
	
	// Fade in the next panel if necessary
	if($('.payment-panel')) {
		$('.payment-panel').animate({'opacity':'1.0'}, 250, function() {
			$('.payment-panel input').prop('disabled', false);
			$('.payment-panel input:not([type=hidden])').first().focus();
		});
	}
}