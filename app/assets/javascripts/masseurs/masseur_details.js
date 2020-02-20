$(function() {
  //  Set initial state for fake age entry
  if($('.real-age-entry').data('visible')) {
    $('.real-age-entry').show();
  } else {
    $('.real-age-entry').hide();
  }

  if($('.work-location-radius').data('visible')) {
    $('.work-location-radius').show();
  } else {
    $('.work-location-radius').hide();
  }
});

$('#masseur_detail_display_real_age_true').click(function() {
  $('.real-age-entry').fadeOut('fast');
});

$('#masseur_detail_display_real_age_false').click(function() {
  $('.real-age-entry').fadeIn('fast');
});

//  FIXME: This is a point of failure if "Your place" is not ID #2!
$('#masseur_detail_work_location_ids_2').click(function() {
  if($(this).is(':checked')) {
    $('.work-location-radius').fadeIn('fast');    
  } else {
    $('.work-location-radius').fadeOut('fast');
  }
});