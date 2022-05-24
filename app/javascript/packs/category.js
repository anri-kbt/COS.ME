$('.cosmetic-box>div').hide();
$('.cosmetic-box>div').first().slideDown();
  $('.category-contents span').click(function(){
    var thisclass=$(this).attr('class');
    $('#lamp').removeClass().addClass('#lamp').addClass(thisclass);
    $('.cosmetic-box>div').each(function(){
      if($(this).hasClass(thisclass)){
        $(this).fadeIn(800);
      }
      else{
        $(this).hide();
      }
    });
  });