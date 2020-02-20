//  Create upload preview with HTML5 File API
$(document).on('change', '.profile-photo-upload input[type=file]', function() {
  var reader = new FileReader();
  
  $(reader).on('load', function(e) {
    $('.profile-photo-preview').attr('src', e.target.result);
  });
  
  reader.readAsDataURL(this.files[0]);

  if($(this).attr('data-auto-upload') == 'true') {
    $('.profile-photo-upload').spin().find('.profile-photo-preview').css('opacity', '0.50');

    $('.upload-profile-photo').submit();
  }
});

//  Handle remote submission of new CLIENT form
$(document).on('ajax:success', '#new_client[data-remote=true]', function(event, data, status, xhr){
  if(data.dashboard_url) {
    window.location.replace(data.dashboard_url);     
  } else {
    window.location.reload();
  }
});
