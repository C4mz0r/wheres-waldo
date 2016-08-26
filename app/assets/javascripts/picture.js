var showContextMenu = function(x, y, characters) {
		
		var content = "<ul>";
		for(var i=0; i < characters.length; i++) {
			content += "<li>"+ characters[i] +"</li>";
		}
		content += "</ul>";
											
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
	window.setTimeout(func, 5000);
	
};

$(function(){
	
	// These variables are exposed here so that li click event can pass these coordinates to Rails
	var lastX, lastY;
	
	// On initial load, the characters are populated from Rails by AJAX request
	// This way, the context menu can only show those characters that need to be found	
	var charactersToFind = [];
	
	// Ask Rails which characters need to be found
	(function(){		
		$.ajax({
			url: "/pictures/charactersToFind",
			type: "GET",
			dataType: 'json',
			complete: function(response){				
				console.log(response.responseJSON);
				charactersToFind = response.responseJSON;
			}			
		});
	})();
	
	$("img").click(function(event){
		var imageLeft = $(this).position().left;
		var imageTop = $(this).position().top;
		var xPosition = event.pageX - imageLeft;
		var yPosition = event.pageY - imageTop;	
		showContextMenu(event.pageX, event.pageY, charactersToFind);	
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
				if (response.responseJSON == true) {
				  showMessage(lastX, lastY, 'You found ' + characterName, "success");
				  $("#"+characterName).removeClass("not-found").addClass("found");
				  var index = charactersToFind.indexOf(characterName);
				  if (index > -1){
				  	charactersToFind.splice(index, 1);
				  }		
				}
				else {
				  showMessage(lastX, lastY, "That's not " + characterName, "failure");
				}
			}			
		});
	});	
});

