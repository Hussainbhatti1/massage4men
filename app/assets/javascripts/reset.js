$(function() {
	$(document).on('submit', '.reset-password-form', function(e) {
		e.preventDefault();
	});
	
	$(document).on('click', '.reset-password, .reset-password-from-admin', function(e) {
		e.preventDefault();
		
		//	If email is already provided, send reset
		if($(this).hasClass('reset-password-from-admin')) {
			var email = $(this).attr('data-user-email');
			var success_msg = 'Password reset email sent.';
		} else {
			var email = $('input.email').val();
			var success_msg = 'You will receive an email shortly with instructions to reset your password.';
		}

		if(email != '') {
			$.post($(this).attr('href'), {client: {email: email}}, function(data) {
				if(data.success) {
					if($('.reset-password-form').length > 0) {
						$('.modal').modal('hide');
					} else {
						$('input.password').focus();						
					}

					swal({
						title: 'Reset Requested',
						text: success_msg,
						type: 'success'
					});
				} else {
					$('input.email').focus();
					swal({
						title: 'Error',
						text: data.error,
						type: 'error'
					});
				}
			});
		} else {
			if($('.reset-password-form').length > 0) {
				$('input.email').focus();
				swal({
					title: 'Error',
					text: 'Please specify an email address.',
					type: 'error'
				});
			} else {
				//	Otherwise, load reset modal		
				var reset_url = $(this).attr('data-reset-url');
				$('.modal-title').html('<i class="fa fa-circle-o-notch fa-spin"></i> Loading&hellip;');
	
				$('.modal-content').load(reset_url);						
			}
		}
	});
});