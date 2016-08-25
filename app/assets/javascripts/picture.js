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
		
		var func = function() {
			menu.hide();
		};
		
		window.setTimeout(func, 3000);		
};

var showMessage = function(x, y, message, classname) {
	var msg = $("#message");
	msg.empty();
	msg.append(message);
	msg.css("left", x);
  msg.css("top", y);
  msg.addClass(classname);	
	msg.show();	
	
	var func = function() {
		msg.removeClass(classname);
		msg.hide();
	};
	window.setTimeout(func, 2000);
	
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
		$("#menu").hide();
		$.ajax({
			url:"/pictures/tagCharacter",
			type: 'PUT',
			dataType: 'json',
			data: {name: characterName, xPosition: lastX, yPosition: lastY},
			complete: function(response) {
				if (response.responseJSON == true)
				  showMessage(lastX, lastY, 'You found ' + characterName, "success");			
				else
				  showMessage(lastX, lastY, "That's not " + characterName, "failure");
			}			
		});
	});	
});

