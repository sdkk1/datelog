function initMap() {
  //地図を表示する領域の div 要素のオブジェクトを変数に代入
  var target = document.getElementById('map');
  //マーカーのタイトル
  var title = $('.datespot-name').text();
  //HTMLに記載されている住所の取得
  var address = document.getElementById('address').textContent;
  //ジオコーディングのインスタンスの生成
  var geocoder = new google.maps.Geocoder();

  //geocoder.geocode() にアドレスを渡して、コールバック関数を記述して処理
  geocoder.geocode({ address: address }, function(results, status){
  //ステータスが OK で results[0] が存在すれば、地図を生成
    if (status === 'OK' && results[0]){
      //マップのインスタンスを変数に代入
      var map = new google.maps.Map(target, {
      //results[0].geometry.location に緯度・経度のオブジェクトが入っている
        center: results[0].geometry.location,
        zoom: 15
      });
      //マーカーの生成
      var marker = new google.maps.Marker({
        position: results[0].geometry.location,
        map: map,
        animation: google.maps.Animation.DROP
      });
      //取得した座標の生成
      var latlng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
      //情報ウィンドウに表示するコンテンツを作成
      var content = `<div id="map_content"><p>${title}<br/>${address}<br/><a href="https://maps.google.co.jp/maps?q=${latlng}&iwloc=J" target="_blank" rel="noopener noreferrer">Googleマップで見る</a></p></div>`;
      //情報ウィンドウのインスタンスを生成
      var infowindow = new google.maps.InfoWindow({
        content: content,
      });
      //marker をクリックすると情報ウィンドウを表示(リスナーの登録）
      google.maps.event.addListener(marker, 'click', function() {
        //第2引数にマーカーを指定して紐付け
        infowindow.open(map, marker);
      });
    }else{
    //ステータスが OK 以外の場合や results[0] が存在しなければ、アラートを表示して処理を中断
      alert("住所から位置の取得ができませんでした。: " + status);
      return;
    }
  });
}
