var map;
var markersArray = [];
var infoArray = [];

function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(37.555775, 126.972472),
			zoom : 13,
		};
		map = new google.maps.Map(document.getElementById("map"),
				mapOptions);		
		
		var inputStart = document.getElementById('start_search');
		var inputDest = document.getElementById('dest_search');
		var searchBar = document.getElementById('search_bar');
		var options = {
			componentRestrictions : {
				country : 'kr'
			}
		}
		
		map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBar);
		
		var autocompleteStart = new google.maps.places.Autocomplete(inputStart, options);
		var autocompleteDest = new google.maps.places.Autocomplete(inputDest, options);
		autocompleteStart.bindTo('bounds', map);
		autocompleteDest.bindTo('bounds', map);
		
		var infowindow = new google.maps.InfoWindow();
		
		google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
			for(i in markersArray){
				markersArray[i].setVisible(false);
				infoArray[i].close();
			}
			markersArray=[];
			infoArray=[];
			var place = autocompleteStart.getPlace();
			var str = "p1="+place.name;
			sendRequest("DB_show.jsp", str, function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var Location = (xhr.responseText).split(',');
					for(var i=0; i < Location.length/8; i++){
						var latLng = new google.maps.LatLng
							(Location[(i*10)+7], Location[(i*10)+8]);
						var infoWindow = new google.maps.InfoWindow();
						infoWindow.setContent('<form action="DB_show.jsp" method="post">' +
								'<div><input type="hidden" id="t_id" name="t_id" value="' + Location[(i*10)+9] +'"/></div> ' + 
								'<div><strong>' + Location[i*10] + '</strong><br><br>' + 
								'<div>출발지 : ' + Location[(i*10)+1] + '</div><br>' + 
								'<div>목적지 : ' + Location[(i*10)+2] + '</div><br>' + 
								'<div>모집인원 : ' + Location[(i*10)+3] + '</div><br>' +
								'<div>출발일 : ' + Location[(i*10)+5] + '</div><br>' +
								'<div>도착일 : ' + Location[(i*10)+6] + '</div><br><br>' +
								'<div>' + Location[(i*10)+4] + '<div><br>' +
								'<input type="submit" value="여행 참가하기">' +
								'</form>');
						addMarker(latLng, infoWindow);
					}
					map.setCenter(new google.maps.LatLng(Location[7], Location[8]));
					showOverlays();
				}
			}, "post", true);
		});	
		
		google.maps.event.addListener(autocompleteDest, 'place_changed', function() {
			markersArray=[];
			infoArray=[];
			var place = autocompleteDest.getPlace();
			var str = "p2="+place.name;
			sendRequest("DB_show.jsp", str, function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var Location = (xhr.responseText).split(',');
					for(var i=0; i < Location.length/2; i++){
						var latLng = new google.maps.LatLng
							(Location[(i*10)+7], Location[(i*10)+8]);
						var infoWindow = new google.maps.InfoWindow();
						infoWindow.setContent('<form action="DB_show.jsp" method="post">' +
								'<div><input type="hidden" id="t_id" name="t_id" value="' + Location[(i*10)+9] +'"/></div> ' + 
								'<div><strong>' + Location[i*10] + '</strong><br><br>' + 
								'<div>출발지 : ' + Location[(i*10)+1] + '</div><br>' + 
								'<div>목적지 : ' + Location[(i*10)+2] + '</div><br>' + 
								'<div>모집인원 : ' + Location[(i*10)+3] + '</div><br>' +
								'<div>출발일 : ' + Location[(i*10)+5] + '</div><br>' +
								'<div>도착일 : ' + Location[(i*10)+6] + '</div><br><br>' +
								'<div>' + Location[(i*10)+4] + '<div><br>' +
								'<input type="submit" value="여행 참가하기">' +
								'</form>');
						addMarker(latLng);
					}
					map.setCenter(new google.maps.LatLng(Location[7], Location[8]));
					showOverlays();
				}
			}, "post", true);
		});		
}

function addMarker(location, infoWindow) {
	  var marker = new google.maps.Marker({
	    position: location,
	    map: map
	  });
	  markersArray.push(marker);
	  infoArray.push(infoWindow);
}

function setMarkerEvent(marker, i){
	google.maps.event.addListener(marker, 'click', function(){
		map.setCenter(marker.getPosition());
		for(j in infoArray){
			infoArray[j].close();
		}
		infoArray[i].open(map, marker);
	});
}

function showOverlays() {
	if (markersArray) {
		for (i in markersArray) {
			setMarkerEvent(markersArray[i], i);
			markersArray[i].setMap(map);
	    }
	}
}

google.maps.event.addDomListener(window, 'load', initialize);