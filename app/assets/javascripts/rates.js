$(function() {
	//	Inject the rate parameters before sending
	$(document).on('ajax:before', '.update-rate', function(event, xhr, settings) {
		var rate_rate = $(this).closest('tr').find('input#rate').val();
		var rate_time = $(this).closest('tr').find('input#time').val();
		
		if(rate_rate == '' || rate_time == '') {
			swal({
				title: 'Error',
				text: 'Please complete all fields.',
				type: 'error'
			});
			return false;
		}

		$(this).find('input#rate_rate').val(rate_rate);
		$(this).find('input#rate_time').val(rate_time);
	});	
});