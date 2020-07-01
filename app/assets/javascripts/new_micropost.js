$(document).on('turbolinks:load', function() {

  $('#mask , .muscle_post_frame').hide();

  $('#muscle_post').click(function(){
    $('#mask, .muscle_post_frame').show();
  });

  $('#mask, #muscle_post_close').click( function () {
    $('#mask, .muscle_post_frame').hide();
  });


  $('#muscle_post_picture').bind('change', function() {
      if(this.files){
        var size_in_megabytes = this.files[0].size/1024/1024;
        if (size_in_megabytes > 5) {
          alert('ファイルサイズが大きすぎます');
        }else {
          $(".muscle_post_btn").prop("disabled", false);
        }
      }
  });

  $("#muscle_post_content").on("keydown keyup keypress change", function() {
  if ($(this).val().length == 0) {
  $(".muscle_post_btn").prop("disabled", true);
  } else {
  $(".muscle_post_btn").prop("disabled", false);
  }
  });


});
