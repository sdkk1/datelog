function initMap(){
  tokyo = {lat: 35.6803997, lng: 139.7690174}

  map = new google.maps.Map(document.getElementById('map'), {
    center: tokyo,
    zoom: 15,
  });

  marker = new google.maps.Marker({
    position: tokyo,
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
      });
      addressDis.innerHTML = results[0].formatted_address;
    } else {
      alert("該当する結果がありませんでした：" + status);
    }
  });
}
