
var $selectValue = $('#select_value').find('strong');


$selectValue.text($('#get_value').val());


// $('#get_value').selectric().on('change', function() {
//   $selectValue.text($(this).val());
// });

$('.removeToDashboard').on('click', function(){
  $('.selected-user').fadeOut()
  window.location.href = "https://claptek.vercel.app/business-user/pendancy-dashboard.html"
})

$(".workflow-block").hide();
$('#workflow').on('click', function(){
  $(".workflow-block").fadeToggle();
})

$('.add-new-rules-btn').on('click', function(){
  $('#allocated-rules-tab-pane').toggleClass('show active')
  $('#add-rules-tab-pane').toggleClass('show active')
})

$('.rule-list-section').hide();
$('.btn-add-rule-save').on('click', function(){
  $('.rule-list-section').fadeIn();
})

