$(document).ready(function(){
	
	function ratingToStars() {
		var $scores = $('.rating_score')
		for (var i=0;i<$scores.length;i++)
		{ 	var $score = $scores[i].innerText
			var $scoreInteger = parseInt($score)
			if ($scoreInteger === 5){
				$scores[i].innerText = "★★★★★"
			} else if ($scoreInteger === 4){
				$scores[i].innerText = "★★★★"				
			} else if ($scoreInteger === 3){
				$scores[i].innerText = "★★★"				
			} else if ($scoreInteger === 2){
				$scores[i].innerText = "★★"				
			} else if ($scoreInteger === 1){
				$scores[i].innerText = "★"				
			}
		}
	}

	ratingToStars();
});