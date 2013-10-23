$(document).ready(function(){
  $("#select_random").on("click", function(){
    $.ajax({
      url: "activities/select",
      type: "post",
      success: function(activity_id){
        top.location.href = '/activities/' + activity_id
      }
    })
    .fail(function(){
      alert("You don't have any activities to choose from! Please add activities.");
    });
  });
});
