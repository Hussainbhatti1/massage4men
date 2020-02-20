$.fn.atomicCounter = function() {
	if(this.length > 0) {
		//	Generate help-block
		var counter_block = $('<p>').addClass('help-block');
	
		var start_length = this.val().length
		var maxlength = this.attr('maxlength');
	
		if(maxlength) {
			counter_block.html('<span class="char-counter">' + start_length + '</span>/' + maxlength);		
		} else {
			counter_block.html('<span class="char-counter">' + start_length);		
		}

		return this.after(counter_block);		
	}
}

$(document).on('keyup', '.ap-counter', function() {
	var char_count = $(this).val().length;
	
	$(this).next('.help-block').find('.char-counter').text($(this).val().length);
	
	//	Fix plurals
	// if(char_count == 1) {
	// 	$(this).next('.help-block').find('.plural').hide();
	// } else {
	// 	$(this).next('.help-block').find('.plural').show();
	// }
});