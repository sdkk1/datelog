function initAutocomplete(){

  tochou = {lat: 35.6895014, lng: 139.6917337}

  map = new google.maps.Map(document.getElementById('map'), {
    center: tochou,
    zoom: 15,
  });

  marker = new google.maps.Marker({
    position: tochou,
    map: map
  });

  var input = document.getElementById('address');

  var options = {
      types: ['establishment'],
      componentRestrictions: {country: 'jp'}
  };

  autocomplete = new google.maps.places.Autocomplete(input, options);
}

function codeAddress(){
  geocoder = new google.maps.Geocoder();

  inputAddress = document.getElementById('address').value;

  geocoder.geocode({ 'address': inputAddress}, function(results, status){
    if (status == 'OK') {
      map.setCenter(results[0].geometry.location);

      marker = new google.maps.Marker({
        position: results[0].geometry.location,
        map: map,
        animation: google.maps.Animation.DROP
      });

      var content = '<div id="map_content"><p>' + inputAddress + '</p></div>';

      var infowindow = new google.maps.InfoWindow({
        content: content,
      });

      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
      });
    } else {
      alert("住所から位置の取得ができませんでした。" + status);
    }
  });
}
