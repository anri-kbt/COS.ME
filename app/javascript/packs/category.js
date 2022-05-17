$(function(){

  var $jsCategory = $('.js-category');
  var $jsCategoryLi = $('.js-category li');

  var categoryLiLen = $jsCategoryLi.length;
  var categoryLiWid = $jsCategoryLi.eq(0).width();

  //タブエリアの横幅指定
  $jsCategory.css('width',categoryLiWid * categoryLiLen + categoryLiWid );
  
  //スワイプイベント登録
  $jsSwipe.hammer().on('swipeleft',next);  //--------C
  $jsSwipe.hammer().on('swiperight',prev);
 
  function next() {
    tabManager($(ACTIVE_SELECTOR).next('li'));
  }
  function prev() {
    tabManager($(ACTIVE_SELECTOR).prev('li'));
  }                                        //--------C
 
  // 指定されたタブをカレントし要素にスクロールする
  function tabManager($nextTarget){
    $nextTarget.find('a').trigger('click');  //--------D
 
    if($nextTarget.index() != -1){
      $scrollContainer.scrollLeft($nextTarget.index() * tabsLiWid);  //--------E
       
    }
  }

});

<script>
//初期化
const galleryThumbs = new Swiper('.tab-menu', {
  spaceBetween: 20,
  slidesPerView: 'auto',
  freeMode: false,
  watchSlidesVisibility: true,
  watchSlidesProgress: true,
});

const galleryTop = new Swiper('.tab-contents', {
  autoHeight: true,
  thumbs: {
    swiper: galleryThumbs
  }
});
</script>