
$(document).on('turbolinks:load', function() {　

// edit画面のnavとmainの高さを大きい方に揃える
  function resizeHeight(){
    var nav_h = 0;
    var main_h = 0;

    nav_h = $('.edit_nav').outerHeight();
    main_h = $('.edit_main').outerHeight();


    if(main_h > nav_h){
      $('.edit_nav').css("height", main_h + "px");
    }else{
      $('.edit_main').css("height", nav_h + "px");
    }
    console.log("load");

  };

  resizeHeight();

  $('.edit_link').click(function(){
    resizeHeight();
    console.log("click");
  });


// フォームが変更されたら、送信ボタンを有効にする

  $('#profile input').keyup(function(){
    $('.edit_profile_btn').prop('disabled', false);
    console.log("change prof")
  });

  $('#password input').keyup(function(){
    $('.edit_password_btn').prop('disabled', false);
    console.log("change pass")
  });

  $('input[type="submit"]').click(function(){
    var id = $(this).parents('div.active').attr('id');
    $('a[href="#password"]').addClass('active');
    console.log('addclass!');
  });

  $('#user_image_name').bind('change', function() {
      var size_in_megabytes = this.files[0].size/1024/1024;
      if (size_in_megabytes > 5) {
        alert('ファイルサイズが大きすぎます');
      }
      $('.edit_profile_btn').prop('disabled', false);
    });

});
