var map;
var markerStart, markerDest;

function initialize() {
	var myLating = new google.maps.LatLng(37.555775, 126.972472);
	var mapOptions = {
		center : myLating,
		zoom : 12
	};
	map = new google.maps.Map(document.getElementById("map"), mapOptions);

	var inputStart = document.getElementById('tstart');
	var inputDest = document.getElementById('tdest');
	var options = {
		componentRestrictions : {
			country : 'kr'
		}
	}

	var autocompleteStart = new google.maps.places.Autocomplete(inputStart,
			options);
	var autocompleteDest = new google.maps.places.Autocomplete(inputDest,
			options);

	autocompleteStart.bindTo('bounds', map);
	autocompleteDest.bindTo('bounds', map);

	var infowindowStart = new google.maps.InfoWindow();
	var infowindowDest = new google.maps.InfoWindow();
	
	var isVisibleStart = false;
	var isVisibleDest = false;

	markerStart = new google.maps.Marker({
		map : map,
		anchorPoint : new google.maps.Point(0, -29)
	});
	markerDest = new google.maps.Marker({
		map : map,
		anchorPoint : new google.maps.Point(0, -29)
	});

	google.maps.event
			.addListener(
					autocompleteStart,
					'place_changed',
					function() {
						infowindowStart.close();
						markerStart.setVisible(false);
						var place = autocompleteStart.getPlace();
						if (!place.geometry) {
							return;
						}

						// If the place has a geometry, then present it on a
						// map.
						if (place.geometry.viewport) {
							map.fitBounds(place.geometry.viewport);
						} else {
							map.setCenter(place.geometry.location);
							map.setZoom(17);
						}

						markerStart.setPosition(place.geometry.location);
						markerStart.setVisible(true);
						
						var address = '';
						if (place.address_components) {
							address = [
									(place.address_components[2]
											&& place.address_components[2].short_name || ''),
									(place.address_components[1]
											&& place.address_components[1].short_name || ''),
									(place.address_components[0]
											&& place.address_components[0].short_name || '') ]
									.join(' ');
						}
						
						infowindowStart.setContent('<div><strong>' + place.name
								+ '</strong><br>' + address);
						isVisibleStart = true;
						infowindowStart.open(map, markerStart);
						infowindowDest.close();
					});

	google.maps.event
			.addListener(
					autocompleteDest,
					'place_changed',
					function() {
						infowindowDest.close();
						markerDest.setVisible(false);
						var place = autocompleteDest.getPlace();
						if (!place.geometry) {
							return;
						}

						// If the place has a geometry, then present it on a
						// map.
						if (place.geometry.viewport) {
							map.fitBounds(place.geometry.viewport);
						} else {
							map.setCenter(place.geometry.location);
							map.setZoom(17);
						}

						markerDest.setPosition(place.geometry.location);
						markerDest.setVisible(true);
						
						var address = '';
						if (place.address_components) {
							address = [
									(place.address_components[2]
											&& place.address_components[2].short_name || ''),
									(place.address_components[1]
											&& place.address_components[1].short_name || ''),
									(place.address_components[0]
											&& place.address_components[0].short_name || '') ]
									.join(' ');
						}

						infowindowDest.setContent('<div><strong>' + place.name
								+ '</strong><br>' + address);
						isVisibleDest = true;
						infowindowDest.open(map, markerDest);
						infowindowStart.close();
					});

	google.maps.event.addListener(markerStart, 'click', function() {
		if (isVisibleStart == false) {
			infowindowStart.open(map, markerStart);
			infowindowDest.close();
			isVisibleStart = true;
		} else {
			infowindowStart.close();
			isVisibleStart = false;
		}
		isVisibleDest = false;
		map.setCenter(markerStart.getPosition());
	});

	google.maps.event.addListener(markerDest, 'click', function() {
		if (isVisibleDest == false) {
			infowindowDest.open(map, markerDest);
			infowindowStart.close();
			isVisibleDest = true;
		} else {
			infowindowDest.close();
			isVisibleDest = false;
		}
		isVisibleStart = false;
		map.setCenter(markerDest.getPosition());
	});
}

function sendLocation(type){
	var startX = markerStart.getPosition().lat();
	var startY = markerStart.getPosition().lng();
	var endX = markerDest.getPosition().lat();
	var endY = markerDest.getPosition().lng();
	
	if(type == "sX")
		return startX;
	else if(type == "sY")
		return startY;
	else if(type == "eX")
		return endX;
	else if(type == "eY")
		return endY;
}


google.maps.event.addDomListener(window, 'load', initialize);