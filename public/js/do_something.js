$(document).ready(function(){
  $("#select_random").on("click", function(){
    $.ajax({
      url: "activities/select",
      type: "post", 
      success: function(activity_id){

      $(".activity").css("background-color", "white");
      $("#activity_"+activity_id).css("background-color", "lightblue");
    }
    })
    .fail(function(){
      alert("You don't have any activities to choose from! Please add activities.");
    });
  });
});
