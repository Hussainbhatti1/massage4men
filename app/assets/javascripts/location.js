$('.get-location').click(function() {
  $('.location-icon').addClass('fa-circle-o-notch fa-spin');  
  // geolocator.locate(on_geo_success, on_geo_error, 2, {enableHighAccuracy: true, timeout: 6000, maximumAge: 0});
  if ("geolocation" in navigator){ //check geolocation available 
        //try to get user current location using getCurrentPosition() method
        navigator.geolocation.getCurrentPosition(function(position){ 
          $.ajax({
            url: "/get_location",
            type: "GET",
            data: {lat: position.coords.latitude, lng: position.coords.longitude},
             success: function(result){
              $('#search_location').val(result.address)
              $('.location-icon').removeClass('fa-circle-o-notch fa-spin');
          }});
        });
    }else{
        console.log("Browser doesn't support geolocation!");
    }
});

function on_geo_success(location) {
  geo_done();
  
  var assembled_location = location.address.city + ', ' + location.address.region + ' ' + location.address.postalCode;
  $('form.search .search-info').val(assembled_location);
  // $('.perform-search').closest('form').submit();
}

function on_geo_error(error) {
  geo_done();
  
  swal({
    title: 'Error',
    text: 'There was an error determining your location.',
    type: 'error'
  });
}

function geo_done() {
  //  Switch the location icon back to normal
  $('.location-icon').removeClass('fa-spin fa-circle-o-notch');
  $('a.get-location')
}




