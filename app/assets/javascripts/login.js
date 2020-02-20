$(function() {
	$(document).on('ajax:success', 'form.login', function(event, data, status, xhr) {
		if(data.success) {
			swal({
				title: 'Welcome back!',
				text: 'Loading your dashboard...',
				type: 'success',
				allowEscapeKey: false,
				showConfirmButton: false
			});
			
			data.redirect_url ? window.location.replace(data.redirect_url) : window.location.reload();
		} else {
			swal({
				title: 'Login Error',
				text: 'There was an error logging you in. Please try again.',
				type: 'error'
			});
		}
	});

	$(document).on('ajax:error', 'form.login', function(event, xhr, status, error) {
		$(this).find('.password').val('').focus();
		
    swal({
      title: 'Error',
      text: xhr.responseJSON.error,
      type: 'error'
    });
	});
});