$(window).on('turbolinks:load', function() {
  if($('.datespot-search__search-form').length){
    const row = $(".row");
    const content = $(".content") || $(".home__datespots--content");
    const search_form_sticked = $(".datespot-search__search-form");

    // コンテンツの位置
    const content_top = content.offset().top;
    // 固定する要素の元々の位置
    const search_form_sticked_original_top = search_form_sticked.offset().top;
    // 固定する要素の高さ
    const search_form_sticked_height = search_form_sticked.height();

    // スクロールかリサイズ時
    $(window).on('scroll resize', function(){
        // 現在の位置
        const scrollTop = $(document).scrollTop();
        // メイン要素の最後尾
        const row_bottom = row.offset().top + row.height();
        // 現在の位置が、初期位置より下で、メイン要素の最後尾より上なら、画面上部に検索フォームを固定
        if ((scrollTop > search_form_sticked_original_top) && (scrollTop < row_bottom - search_form_sticked_height)){
            search_form_sticked.css({'position': 'fixed',
                'top': 0,
                'width': content.width(),
            });
        } else if(scrollTop >= row_bottom - search_form_sticked_height){
            // 現在位置がメイン要素の最後尾より下なら、メイン要素の最後尾に検索フォームを位置させる
            search_form_sticked.css({'position': 'absolute',
                'top': row_bottom - search_form_sticked_height - content_top,
                'width': content.width(),
            });
        } else {
            // 現在位置が初期位置より上なら、幅だけリサイズする
            search_form_sticked.css({'position': 'static',
                'width': content.width()
            });
        }
    });
  }
});
