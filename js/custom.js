
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
  if(this.checked){
    $(".workflow-block").fadeIn();
  } else {
    $(".workflow-block").fadeOut();
  }
  
})

$('.add-new-rules-btn').on('click', function(){
  $('#allocated-rules-tab-pane').toggleClass('show active')
  $('#add-rules-tab-pane').toggleClass('show active')
})

$('.rule-list-section').hide();
$('.btn-add-rule-save').on('click', function(){
  $('.rule-list-section').fadeIn();
})

$(document).ready(function(){
    $('.select_all').on('click',function(){
        if(this.checked){
            $('.form-check-input').each(function(){
                this.checked = true;
            });
        }else{
             $('.form-check-input').each(function(){
                this.checked = false;
            });
        }
    });
});

$('.table-row:first-child input').addClass('select_all show-link');
