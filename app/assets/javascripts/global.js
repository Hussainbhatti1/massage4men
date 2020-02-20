function init_datepickers() {
	$('input.datepicker:not(.dob)').each(function() {
		$(this).datepicker({
			altFormat: 'yy-mm-dd',
			dateFormat: 'mm/dd/yy',
			altField: $(this).next(),
			changeMonth: true,
	    changeYear: true,
		});
  });
	
	if($('[class$=-alt]:not(.dob-alt)').length > 0) {
		$.each($('[class$=-alt]:not(.dob-alt)'), function() {
			$(this).prev().val(date_string(new Date($(this).val())));
		});
	}

  $('input.datepicker').mask('99/99/9999');
}

function date_string(date) {
  function pad(n){return n<10 ? '0'+n : n}
  return pad(date.getUTCMonth() + 1) + '/'
  + pad(date.getUTCDate()) + '/'
  + date.getUTCFullYear();
}

function init_dynamic_elements() {
	/*	Initialize:
			- Masked inputs (phone, etc.)
			-	Tooltips
			- Popovers
			-	NOT datepickers (these are currently done separately)
	*/
  $('input[type=tel]').each(function(i, v) {
    if(!$(v).attr('data-mask')) {
      $(v).mask('(999) 999-9999');
    }
  });

	$('input#card_expiry_string').mask('99/99');
  $('input#card_number').mask('9999-9999-9999-9999');
  $('input#card_verification_value').mask('999');

  $('[data-toggle=tooltip]').tooltip();
  
	$('[data-toggle=popover]').popover({
		trigger: 'hover',
		container: 'body'
		}
	);
	
	//	WYSIHTML5 textareas, if any
	if($('.wysihtml5').length > 0) {
	  $('.wysihtml5').each(function(i, elem) {
			//	Setup custom buttons for the email editor			
			if($(elem).hasClass('email-editor')) {
        //  Add the base buttons for the email editor
				var buttons = {
					'font-styles': false,
					'blockquote': false,
					'image': false,
					'html': true,
				};
        
        //  Parse the custom buttons
        if($(elem).attr('data-custom-buttons')) {
          var customButtons = {}

          $.each(JSON.parse($(elem).attr('data-custom-buttons')), function(i, button_name) {
            //  Sanitize the button name
            var sanitized_button_name = button_name.replace('{', '').replace('}', '');

            //  Sanitize it some more for use as a hash index
            var index = sanitized_button_name.replace('$', '').toLowerCase();
                        
            customButtons[index] = function(context) {
              return '<li><a class="btn btn-default" data-wysihtml5-command="insertHTML" data-wysihtml5-command-value="' + button_name + '">' + sanitized_button_name + '</a></li>';
            };
            
            //  Add this button to the toolbar
            buttons[index] = true
          }); 
        }
			} else {
				var buttons = {
					'html': true
				};
				
				var customButtons = {};
			}

	    $(elem).wysihtml5('deepExtend',
	      { toolbar: buttons,
					customTemplates: customButtons,
	        parserRules: { tags: { address: {}}}
	      }
	    );
	  });		
	}
}

$(document).on('page:load', function(){
  window['rangy'].initialized = false;
});

$(document).on("page:load ready", function(){
	init_dynamic_elements();
  
	//	DATEPICKERS
	init_datepickers();
});

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox({always_show_close: false});
});

//	Clear all errors from remote forms when submitting
$(document).on('ajax:send', 'form[data-remote=true]', function(event, xhr) {
	$(this).find('.form-group').removeClass('has-error');
	$(this).find('.error-block').remove();
	
	$(this).find('input').prop('disabled', true);
});

$(document).on('ajax:success', '.new-rate-0, .new-rate-1', function(event, data, status, xhr) {
	$(this).find('input').prop('disabled', false);
});

//	Add errors to all remote forms
$(document).on('ajax:error', 'form[data-remote=true]', function(event, xhr, status, error) {
	//	Enumerate through errors if any were found
	if(xhr.responseJSON) {
		$.each(xhr.responseJSON.errors, function(field, err) {
			$('.form-group[class$=_' + field + ']').addClass('has-error');

			//	Append a hint for each error to the field
			$('input[id$=_' + field + ']').after('<p class="help-block error-block">' + err + '</p>');
		});		
	}
		
	$(this).find('input:not([type=submit])').removeAttr('disabled');
});