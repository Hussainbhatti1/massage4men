$('.metric-toggle').click(function(e) {
  e.preventDefault();

  $('.height-imperial').toggle();
  $('.height-metric').toggle();
});

$('.weight-unit-selector a').click(function(e) {
  e.preventDefault();
  $('#masseur_detail_weight_unit').val($(this).text());
  $('.weight-unit').text($(this).text());
});

$('input[data-social-service]').click(function() {
  var service = $(this).data('social-service');
  
  if($(this).val() == 'true') {
    $('.social-url[data-social-service=' + service + ']').fadeIn('fast');      
  } else {
    $('.social-url[data-social-service=' + service + ']').fadeOut('fast');
  }
});