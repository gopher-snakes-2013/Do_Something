$(document).ready(function(){
  $("#select_random").on("click", function(){
    $.ajax({
      url: "activities/select",
      type: "post", 
      success: function(activity_id){
        $(".activity_pieces").css({
                                    "background-color": "rgba(255,255,255,0.7)",
                                    "color": "rgba(0, 0, 0, 0.6)",
                                    "border": "none"
                                    });
        $("#activity_"+activity_id).css({
                                          "background-color" : "lemonchiffon",
                                          "border" : "4px solid rgba(50, 66, 98, 0.8)",
                                          "color": "black"
                                        });
      }
    })
    .fail(function(){
      alert("You don't have any activities to choose from! Please add activities.");
    });
  });
});
