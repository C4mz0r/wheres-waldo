var showContextMenu = function(x, y) {
		var content = "<ul>"
									+ "<li>Waldo</li>"
									+ "<li>Wenda</li>"
									+ "<li>Odlaw</li>"
									+ "<li>Wizard</li>"
									+ "</ul>";									
	  var menu = $("#menu");
		menu.empty();
		menu.append(content);		
		menu.css("left", x);
		menu.css("top", y);
		menu.show();
};

$(function(){
	
	// These variables are exposed here so that li click event can pass these coordinates to Rails
	var lastX, lastY;
	
	$("img").click(function(event){
		var imageLeft = $(this).position().left;
		var imageTop = $(this).position().top;
		var xPosition = event.pageX - imageLeft;
		var yPosition = event.pageY - imageTop;	
		showContextMenu(event.pageX, event.pageY);	
		lastX = xPosition;
		lastY = yPosition;	
	});
	
	$("#menu").on("click", "li", function(event){		
		var characterName = $(this).text();		
		$.ajax({
			url:"/pictures/tagCharacter",
			type: 'PUT',
			dataType: 'json',
			data: {name: characterName, xPosition: lastX, yPosition: lastY},
			complete: function(response) {
				if (response.responseJSON == true)
				  alert('You found ' + characterName);			
				else
				  alert("That's not " + characterName);
			}			
		});
	});
	
});

