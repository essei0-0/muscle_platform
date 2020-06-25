$(document).on('turbolinks:load', function() {

  $('#micropost_picture').bind('change', function() {
      var size_in_megabytes = this.files[0].size/1024/1024;
      if (size_in_megabytes > 5) {
        alert('ファイルサイズが大きすぎます');
      }
      $('.post_btn').prop('disabled', false);
    });

    $('#mask , .muscle_post_frame').hide();

    $('#muscle_post').click(function(){
      $('#mask, .muscle_post_frame').show();
    });

    $('#mask, #muscle_post_close').click( function () {
			$('#mask, .muscle_post_frame').hide();
		});
});
