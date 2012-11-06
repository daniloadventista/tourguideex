<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page
	import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="arquivos/myStyle.css" />
<script type="text/javascript" src="arquivos/jquery-1.8.0.js"></script>
<script type="text/javascript" src="arquivos/jqAnimations.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript" src="arquivos/jsScripts.js"></script>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?sensor=true"></script>
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
	
	directionsDisplay = new google.maps.DirectionsRenderer(); 
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
	calcRoute();
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
<title>Tour Guide!</title>
</head>
<body onload="initialize()">
	<%
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();

		String dono = "";
		dono = (String) session.getAttribute("sesNome");

		Filter myFilter = new Query.FilterPredicate("dono",
				FilterOperator.EQUAL, dono);

		Query query = new Query("Caminho").addSort("dataDeCriacao",
				Query.SortDirection.DESCENDING);
		query.setFilter(myFilter);

		List<Entity> caminhos = datastore.prepare(query).asList(
				FetchOptions.Builder.withDefaults());

		String chegadaF = "";
		String partidaF = "";

		for (Entity cami : caminhos) {
			chegadaF = (String) cami.getProperty("chegada");
			partidaF = (String) cami.getProperty("partida");

		}
	%>

	<div id="painelSuperior">
		<h1>Tour Guide</h1>
		<div id="menu">
			<div class="botao">
				<a href="index.jsp">mapa</a>
			</div>
			<div class="botao">
				<a href="criacaoDeCaminhos.jsp">minhas rotas</a>
			</div>

			<div class="botao">
				<a href="criacaoDeUsers.jsp">login</a>
			</div>
		</div>
	</div>
	<div id="pagina">
		<div id="conteudo">
			<div id="painelEsquerdo">
				<br>
				<div class="itemPai">
					Opcoes de
					<%
					if (dono == null) {
						out.println("Nao Logado");
					} else {
						out.println(dono);
					}
				%>
				</div>
				<div class="filho">
					<b>Partida: </b><br> <select id="start"
						onchange="calcRoute();">
						<%
							for (Entity cami : caminhos) {
								chegadaF = (String) cami.getProperty("chegada");
								partidaF = (String) cami.getProperty("partida");
								out.print("<option value=\"" + partidaF + "\">" + partidaF
										+ "</option>");
							}
						%>
					</select>
				</div>
				<div class="filho">
					<b>Chegada: </b><br> <select id="end" onchange="calcRoute();">
						<%
							for (Entity cami : caminhos) {
								chegadaF = (String) cami.getProperty("chegada");
								partidaF = (String) cami.getProperty("partida");
								out.print("<option value=\"" + chegadaF + "\">" + chegadaF
										+ "</option>");
							}
						%>

					</select>
				</div>
				<div class="filho">
					<b>Tipo de Viagem: </b><br> <select id="mode"
						onchange="calcRoute();">
						<option value="DRIVING">Dirigindo</option>
						<option value="WALKING">Andando</option>
						<option value="BICYCLING">Bicicleta</option>
						<option value="TRANSIT">Tranporte publico</option>
					</select>
				</div>
				<img
					src="https://developers.google.com/appengine/images/appengine-noborder-120x30.gif"
					alt="Powered by Google App Engine" />
			</div>
			<div id="painelDireito">
				<div class="conteudo">
					<!-- 					fim do cabecalho -->
					<div id="map_canvas" style="float: left; width: 70%; height: 100%"></div>
					<div id="directionsPanel"
						style="float: right; width: 30%; height: 100%"></div>
					<!-- 						inicio do footer -->
				</div>
			</div>
		</div>
	</div>
	<div id="painelInferior">
		<h4>Tecnologia de Programacao Aplicada 2</h4>
	</div>

</body>

</html>