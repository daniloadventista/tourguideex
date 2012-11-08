
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

function atualisaDocumento() {
	$(".filho").hide();
}

function initialize() {
	atualiasaDocumento();
	
	directionsDisplay = new google.maps.DirectionsRenderer();
	var mackImg = new google.maps.LatLng(-23.547111, -46.651944);
	var myOptions = {
		zoom : 7,
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		center : mackImg
	}
	map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

	// Associate the styled map with the MapTypeId and set it to display.
	map.mapTypes.set('map_style', styledMap);
	map.setMapTypeId('map_style');

	directionsDisplay.setMap(map);
	directionsDisplay.setPanel(document.getElementById("directionsPanel"));
}