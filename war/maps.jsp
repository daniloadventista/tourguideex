<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
html {
	height: 100%;
}

body {
	height: 100%;
	width: 100%;
	margin-left: auto;
	margin-right: auto;
	padding: 0
}

#map_canvas {
	height: 100%
}
</style>
 
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=true"></script>
<script type="text/javascript" src="arquivos/jqAnimations.js"></script>
<script type="text/javascript">

<!--
var styles = [ {
	stylers : [ {
		hue : "#1188ff"
	}, {
		saturation : -20
	} ]
}, {
	featureType : "road",
	elementType : "geometry",
	stylers : [ {
		lightness : 20
	}, {
		visibility : "simplified"
	} ]
} ];

// Create a new StyledMapType object, passing it the array of styles,
// as well as the name to be displayed on the map type control.
var styledMap = new google.maps.StyledMapType(styles, {
	name : "Styled Map"
});

var directionDisplay;
var directionsService = new google.maps.DirectionsService();
var map;

function initialize() {
	
	var directionsDisplay = new google.maps.DirectionsRenderer({ 'map': map }); 
	var mackImg = new google.maps.LatLng(-23.547111, -46.651944);
	var myOptions = {
		zoom : 7,
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		center : mackImg
	}
	map = new google.maps.Map(document.getElementById("map_canvas"),
			myOptions);

	// Associate the styled map with the MapTypeId and set it to display.
	map.mapTypes.set('map_style', styledMap);
	map.setMapTypeId('map_style');

	directionsDisplay.setMap(map);
	directionsDisplay.setPanel(document.getElementById("directionsPanel"));

}

function calcRoute() {
	
	//modo de rota
	var selectedMode = document.getElementById("mode").value;
	//partida e chegada
	var start = document.getElementById("start").value;
	var end = document.getElementById("end").value;
	var request = {
		origin : start,
		destination : end,
		//		
		travelMode : google.maps.TravelMode[selectedMode]
	};
	// ta dando erro
	directionsService.route(request, function(result, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(result);
		}
	});
} 
-->
</script>

</head>
<body onload="initialize()">

	<div>
		<b>Partida: </b> <select id="start" onchange="calcRoute();">
			<option value="mackenzie, sp">Mackenzie</option>
			<option value="maua, sp">maua</option>
			<option value="sao caetano, sp">sao caetano</option>
			<option value="santo andre, sp">santo andre</option>

		</select> <b>Chegada: </b> <select id="end" onchange="calcRoute();">
			<option>value="mackenzie, sp">Mackenzie</option>
			<option value="maua, sp">maua</option>
			<option value="sao caetano, sp">sao caetano</option>
			<option value="santo andre, sp">santo andre</option>
		</select>
	</div>
	<div>
		<b>Tipo de Viagem: </b> <select id="mode" onchange="calcRoute();">
			<option value="DRIVING">Dirigindo</option>
			<option value="WALKING">Andando</option>
			<option value="BICYCLING">Bicicleta</option>
			<option value="TRANSIT">Tranporte publico</option>
		</select>
	</div>


	<div id="map_canvas" style="float: left; width: 70%; height: 100%"></div>
	<div id="directionsPanel" style="float: right; width: 30%;"></div>
</body>

</html>
