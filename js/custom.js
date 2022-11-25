// Cache the target element
var $selectValue = $('#select_value').find('strong');

// Get initial value
$selectValue.text($('#get_value').val());

// Initialize Selectric and bind to 'change' event
$('#get_value').selectric().on('change', function() {
  $selectValue.text($(this).val());
});