$(document).on('turbolinks:load', function(){

  $('div.micropost_reply, div.reply_reply').hide();
  $('div.reply').click(function(){
    $(this).parents('article').find('div.micropost_reply, div.reply_reply').stop().slideToggle();

    return false;
  });

});
