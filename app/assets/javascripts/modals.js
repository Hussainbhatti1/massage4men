$(function() {
  if($('[data-pic-required=true]').length > 0) {
    var url = $('html').attr('data-pic-upload-url');

    $('.profile-photo-sidebar').remove();

    $('.modal').modal('show');
    load_url_in_modal(url);
  }

	if($('[data-pop-signup=true]').length > 0) {
		//	HACK: Click the signup button to invoke the modal
		$('.btn-signup').click();
	}
});

$(document).on('click', '.modal a[data-stay-in-modal=true]', function(e) {
  e.preventDefault();

  setup_modal($(this));
  
  load_url_in_modal(determine_target_url($(this)), '#none');  
});

$(document).on('show.bs.modal', '.modal', function(e) {
  var relatedTarget = $(e.relatedTarget);
  setup_modal(relatedTarget);
  var url = determine_target_url(relatedTarget);

  //  Start the spinner and load the URL, if one is specified.
  if(url && url != '#') {
    load_url_in_modal(url, '#client_email');		
  }    
});

function determine_target_url(target) {
  if(target.data('url')) {
    return target.data('url');      
  } else {
    return target.attr('href');
  }
}

function load_url_in_modal(url, focus_field) {
  $('.modal-content').spin().load(url, function() {		
    $(this).spin(false);
    
		if(focus_field) {
			$(focus_field).focus();
		}
		
		//	Refresh dynamic elements as needed
		$('.rating').rating();
		$('#review_review').atomicCounter();
					
		init_datepickers();
		init_dynamic_elements();
  });        
}

function setup_modal(link) {
	if(link.data('review-modal')) {
		//	Refresh hands
		$(this).addClass('review-modal');
	}
	
	if(link.data('confirm-close')) {
		$(this).attr('data-confirm-close', true);
	}  
}

function load_in_modal(link) {
  //  `link` is a jQuery object for a link
}

//	Reset regular modal when closing
$(document).on('hidden.bs.modal', '.modal:not(#add-photo-modal)', function(e) {
	$('.modal-content .modal-body').html('&nbsp;');
	$('.modal-title').html('<i class="fa fa-circle-o-notch fa-spin"></i> Loading&hellip;');
});

//	Confirm modal close when registering
$(document).on('hide.bs.modal', '.modal[data-confirm-close=true]', function(e) {
	var modal = $(this);
	
	//	Suppress the closure
	e.preventDefault();
	e.stopImmediatePropagation();

	//	Fire an alert
	swal({
		title: 'Are you sure?',
		text: 'Are you sure you don\'t want to register?',
		type: 'warning',
		showCancelButton: true,
		cancelButtonText: 'Continue Registering',
		confirmButtonClass: "btn-danger",
		confirmButtonText: "Stop Registering",
		closeOnConfirm: true
	}, function() {
		modal.removeAttr('data-confirm-close');
		modal.modal('hide');
		
		//	If they created an account but didn't pay, send them to their dashboard.
		//	Once there, they'll get a notice about their account status.
		if(modal.attr('data-cancel-url')) {
			window.location.replace(modal.attr('data-cancel-url'));
		}				
	});
	
});