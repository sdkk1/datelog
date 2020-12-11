$(function(){
  //DataTransferオブジェクトで、データを格納する箱を作る
  const dataBox = new DataTransfer();

  //querySelectorでfile_fieldを取得
  const file_field = document.querySelector('input[type=file]')

   //fileが選択された時に発火するイベント
  $('#datespot_image').change(function(){
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      const fileReader = new FileReader();
      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files
      //Fileオブジェクトを読み込む
      fileReader.readAsDataURL(file);
      //DataTransfer構造のデバッグ
      if(dataBox.items.length > 5){
        return false;
     }
    });
  });
});
