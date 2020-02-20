// $('.grid-view').on('click', function(e) {
//   e.preventDefault();
//
// });
//
// $('.map-view').on('click', function(e) {
//   e.preventDefault();
// });
$('.perform-search').on('click', function() {
  $(this).closest('form').submit();
});

$('form.search').on('submit', function(e) {
  var err = '';
  
  if($('#search_location').val() == '') {
    err += 'Please enter a search location.';
  }
  
  if($('.massage-types input[type=checkbox]:checked').length == 0) {
    err += "\nPlease enter a massage type to search by.";
  }
  
  if(err) {
    e.preventDefault();
    
    swal({
      title: 'Error',
      text: err,
      type: 'error'
    });
  }
});

if($('#map').length > 0) {
  // handler = Gmaps.build('Google');
  // handler.buildMap({
  //   provider: {
  //
  //   },
  //   internal: {
  //     id: 'map'
  //   }
  // }, function(){
  //   console.log('markers here!');
  //   console.log(markers);
  //   m = handler.addMarkers(markers);
  //
  //   handler.bounds.extendWith(markers);
  //   handler.fitMapToBounds();
  // });    
  
  // var handler = Gmaps.build('Google');
  // handler.buildMap({ internal: {id: 'map'} }, function(){
  //   if(navigator.geolocation)
  //     navigator.geolocation.getCurrentPosition(displayOnMap);
  // });
  //
  // function displayOnMap(position){
  //   var marker = handler.addMarker({
  //     lat: position.coords.latitude,
  //     lng: position.coords.longitude
  //   });
  //   handler.map.centerOn(marker);
  // };
}
