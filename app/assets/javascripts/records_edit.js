$(document).on('turbolinks:load', function() {

  $('.meal_record_edit').hide();

  $('#meal_other_options').click(function(){
    base_gram = $('#meal_record_base_gram').val();
    protein = $('#meal_record_protein').val();
    fat = $('#meal_record_fat').val();
    carbo = $('#meal_record_carbo').val();
    food = $('#meal_record_food').val();
    ate_gram = $('#meal_record_ate_gram').val();

    $('.meal_records').hide();
    $('#edit_base_gram').val(base_gram);
    $('#edit_protein').val(protein);
    $('#edit_fat').val(fat);
    $('#edit_carbo').val(carbo);
    $('#edit_food').val(food);
    $('#edit_ate_gram').val(ate_gram);
    $('.meal_record_edit').show();
  });

  $('#meal_record_edit_close').click( function () {
    $('.meal_record_edit').hide();
    $('.meal_records').show();
  });

  $('.meal_records_table tr:not(:first-child)').click(function(){
    $('.records_table tr:not(:first-child)').removeClass('select_record');
    $(this).addClass('select_record');

    var values = [];
    $(this).children().each(function(i,e){
      values.push($(e).text());

    });

    base_gram = $(this).children("input").val();
    $('#meal_record_base_gram').val(base_gram);
    $('#meal_record_protein').val(parseFloat(values[3]));
    $('#meal_record_fat').val(parseFloat(values[4]));
    $('#meal_record_carbo').val(parseFloat(values[5]));
    $('#meal_record_food').val(values[1]);
    $('#meal_record_ate_gram').val(parseFloat(values[2]));

  });

  $('.health_record_edit').hide();

  $('#health_other_options').click(function(){
    $('.health_record_edit').show();

  });

  $('#health_record_edit_close').click( function () {
    $('.health_record_edit').hide();
  });

});
