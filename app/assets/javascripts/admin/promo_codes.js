$(function() {
  $('.datepicker').on('blur', function() {
    if($(this).val() == '') {
      $.datepicker._clearDate(this);      
    }
  });
});