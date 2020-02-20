$(document).on('change', '#review_masseur_on_time', function(e) {
	if($(this).val() != 'Yes') {
		$('.masseur-on-time-info').removeClass('hide');
	} else {
		$('#review_masseur_notified_of_lateness').val('');
		$('.masseur-on-time-info').addClass('hide');
	}
});

//	Submit review form via AJAX after validation
$(document).on('submit', '.new_review', function(e) {
	$('.has-error').removeClass('.has-error');
	e.preventDefault();
	
	var errors = [];
	
	if($('#review_review').val().length < 80) {
		$('.form-group.review_review').addClass('has-error');
		errors.push('Your review must be at least 80 characters.');
	}
	
	if($('#review_review').val().length > 500) {
		$('.form-group.review_review').addClass('has-error');
		errors.push('Your review cannot exceed 500 characters.');
	}
	
	if(errors.length > 0) {
		swal({
			title: 'Your review cannot be submitted:',
			text: errors.join('<br>'),
			type: 'error'
		});
	} else {
		$.post($(this).attr('action'), $(this).serialize(), function(data) {
			if(data.success) {
				$('.review-modal').modal('hide');
								
				swal({
					title: 'Thanks!',
					text: data.msg,
					type: 'success'
				});
			} else {
				swal({
					title: 'Oops!',
					text: data.error,
					type: 'error'
				});
			}
		});
	}
});