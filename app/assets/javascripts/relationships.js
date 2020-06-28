$(document).on('turbolinks:load', function(){
  $('.relationship_nav > li > a').hover(
  function(){
    $(this).addClass('hover');
  },
  function(){
    $(this).removeClass('hover');
  });

  $('.relationship_nav > li > a').click(function(){
    Turbolinks.clearCache();
  });
});
