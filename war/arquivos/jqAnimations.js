/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

<<<<<<< HEAD
function atualisaConteudo() {
	$(".conteudo").load('criacaoDeUsers.jsp');
}

$(document).ready(function() {

	$(".botao1").click(function() {
		$("form#form1").submit();
=======

$(document).ready(function() {
	
	$(".botao1").click(function() {
		$("form#form1").submit();

>>>>>>> 35ded0a4534dbdcaddf8675b1c9f4cff16ab0027
	});
	$(".botao2").click(function() {
		$("form#form2").submit();
	});

	$(".itemPai").click(function() {
		$(".filho").show(500);
	});

<<<<<<< HEAD
	$(".filho").click(function() {
		$(".filho").hide(500);
	});
	(".filho").mouseover(function() {
=======
	$(".filho").mouseover(function() {
>>>>>>> 35ded0a4534dbdcaddf8675b1c9f4cff16ab0027
		$(".descricao").show(500);
	});
	$(".descricao").click(function() {
		$(".descricao").hide(500);
	});
});
<<<<<<< HEAD

/*
 * var mackImg = new google.maps.LatLng(40.740, -74.18); var imageBounds = new
 * google.maps.LatLngBounds( new google.maps.LatLng(40.716216,-74.213393), new
 * google.maps.LatLng(40.765641,-74.139235));
 */

// -23.547111 -46.651944
// -23.497686 -46.577786
// calcular lat e long do centro do mapa
// Create an array of styles.
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
/*
 * logica para inserir poligonos var predio13;
 * 
 * var triangleCoords = [ new google.maps.LatLng(-23.546973,-46.652201), new
 * google.maps.LatLng(-23.546501,-46.651429), new
 * google.maps.LatLng(-23.547642,-46.651515), new
 * google.maps.LatLng(-23.546973,-46.652201) ];
 * 
 * predio13 = new google.maps.Polygon({ paths: triangleCoords, strokeColor:
 * "#FF00ff", strokeOpacity: 0.8, strokeWeight: 2, fillColor: "#FF00ff",
 * fillOpacity: 0.35 });
 * 
 * predio13.setMap(map);
 */
// var oldmap = new google.maps.GroundOverlay(
// "http://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg",
// imageBounds);
// oldmap.setMap(map);
=======
>>>>>>> 35ded0a4534dbdcaddf8675b1c9f4cff16ab0027
