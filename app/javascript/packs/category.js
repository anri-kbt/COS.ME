$(function(){

  var $jsCategory = $('.js-category');
  var $jsCategoryLi = $('.js-category li');

  var categoryLiLen = $jsCategoryLi.length;
  var categoryLiWid = $jsCategoryLi.eq(0).width();

  //タブエリアの横幅指定
  $jsCategory.css('width',categoryLiWid * categoryLiLen + categoryLiWid );
});

$('.cosmetic-box').hide();
$('.cosmetic-box').first().slideDown();
  $('.category-table span').click(function(){
    var thisclass=$(this).attr('class');
    $('#lamp').removeClass().addClass('#lamp').addClass(thisclass);
    $('.cosmetic-container').each(function(){
      if($(this).hasClass(thisclass)){
        $(this).fadeIn(800);
      }
      else{
        $(this).hide();
      }
    });
  });