
var $selectValue = $('#select_value').find('strong');


$selectValue.text($('#get_value').val());


$('#get_value').selectric().on('change', function() {
  $selectValue.text($(this).val());
});