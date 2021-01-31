$(function(){
	$(window).scroll(function(){
		// 対象までの高さ
		const distanceTop = 200;

		// 対象に達しているかどうかを判別
		if ($(window).scrollTop() < distanceTop) {
			// していれば、pageTopをfadeIn
			$('.home__slider--scroll').fadeIn("slow");
		} else {
			// していなければ、pageTopをfadeOut
			$('.home__slider--scroll').fadeOut("slow");
		}
	});
});
