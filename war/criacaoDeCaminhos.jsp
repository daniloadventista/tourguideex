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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" type="text/css" href="arquivos/myStyle.css" />
<script type="text/javascript" src="arquivos/jquery-1.8.0.js"></script>
<script type="text/javascript" src="arquivos/jqAnimations.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tour Guide</title>
</head>
<body>
	<form method="post" id="form2">
		<table>
			<tr>
				<td>Partida <input type="text" name="txtPartida">
				</td>
				<td>Chegada <input type="text" name="txtChegada">
				</td>
			</tr>
		</table>
<!-- 		<input type="submit" value="Enviar" name="B1" /> -->
		<div class="botao2"><a class="botao" href="#" name="envia"> Enviar</a></div>
	</form>

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

		if (request.getParameter("txtPartida") != null &&
				request.getParameter("txtChegada") != null) {
			if (!request.getParameter("txtPartida").equals("") && 
					!request.getParameter("txtChegada").equals("")) {
				String partida = request.getParameter("txtPartida");
				String chegada = request.getParameter("txtChegada");

				Entity caminho = new Entity("Caminho");

				caminho.setProperty("dono", dono);

				caminho.setProperty("partida", partida);
				caminho.setProperty("chegada", chegada);

				Date dataCriacao = new Date();
				caminho.setProperty("dataDeCriacao", dataCriacao);

				String chegadaF; 
				String partidaF; 
				boolean existe = false;
				
				for (Entity cami : caminhos) {
					chegadaF = (String) cami.getProperty("chegada");
					partidaF = (String) cami.getProperty("partida");
					
					if(chegada.equals(chegadaF) &&
							partida.equals(partidaF)){
						existe = true;
					}
						
				}
				if(!existe){
					datastore.put(caminho);	
				}
					
			}
		}
	%>
	<%
		// 		TODO arrumar esta bosta
		if (caminhos.isEmpty()) {
	%>
	<p>Nao ha Caminhos.</p>
	<%
		} else {
	%>
	<p>Caminhos de <%=dono%>:</p>
	<%
		for (Entity cami : caminhos) {
				String chegadaF = (String) cami.getProperty("chegada");
				String partidaF = (String) cami.getProperty("partida");
	%>
	<b><%=partidaF%></b> Para:
	<i><%=chegadaF%></i><div><a href=""><a>Excluir</a></div>
	<%
			}
		}
	%>

</body>
</html>