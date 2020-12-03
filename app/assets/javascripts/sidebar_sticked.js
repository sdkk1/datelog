$(function($){
  var content = $(".row");
  var sidebar = $(".sidebar");
  var sticked = $(".sticked");

  // サイドバーの位置
  var sidebar_top = sidebar.offset().top;
  // 固定する要素の元々の位置
  var sticked_original_top = sticked.offset().top;
  // 固定する要素の高さ
  var sticked_height = sticked.height();

  // スクロールかリサイズ時
  $(window).on('scroll resize', function(){
      // 現在の位置
      var scrollTop = $(document).scrollTop();
      // メイン要素の最後尾
      var content_bottom = content.offset().top + content.height();
      // 現在の位置が、初期位置より下で、メイン要素の最後尾より上なら、画面上部にサイドバーを固定
      if ((scrollTop > sticked_original_top) && (scrollTop < content_bottom - sticked_height)){
          sticked.css({'position': 'fixed',
              'top': 0,
              'width': sidebar.width()
          });
      } else if(scrollTop >= content_bottom - sticked_height){
          // 現在位置がメイン要素の最後尾より下なら、メイン要素の最後尾にサイドバーを位置させる
          sticked.css({'position': 'absolute',
              'top': content_bottom - sticked_height - sidebar_top,
              'width': sidebar.width()
          });
      } else {
          // 現在位置が初期位置より上なら、幅だけリサイズする
          sticked.css({'position': 'static',
              'width': sidebar.width()
          });
      }
  });
});
