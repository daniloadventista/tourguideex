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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link rel="stylesheet" type="text/css" href="arquivos/myStyle.css" />
<script type="text/javascript" src="arquivos/jquery-1.8.0.js"></script>
<script type="text/javascript" src="arquivos/jqAnimations.js"></script>
<script type="text/javascript" src="arquivos/jsScripts.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tour Guide</title>
</head>
<body>
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

		// 		// logica para pegar caminhos a serem deletados	
		String pExcluir = "";//partida
		String cExcluir = "";//chegada
		int numExcluir = -1;
		if (request.getParameter("bExcluirP") != null) {
			if (!request.getParameter("bExcluirP").equals("")) {
				pExcluir = request.getParameter("bExcluirP");
			}
		}
//		out.print("<h1> o valor eh: " + pExcluir + "</h1>");
		if (request.getParameter("bExcluirC") != null) {
			if (!request.getParameter("bExcluirC").equals("")) {
				cExcluir = request.getParameter("bExcluirC");
			}
		}
//		out.print("<h1> o valor eh: " + cExcluir + "</h1>");
		// fim logica para pegar caminhos a serem deletados

		String chegadaF = "";
		String partidaF = "";

		for (Entity cami : caminhos) {
			chegadaF = (String) cami.getProperty("chegada");
			partidaF = (String) cami.getProperty("partida");

			if (cExcluir.equals(chegadaF) && pExcluir.equals(partidaF)) {
				datastore.delete(cami.getKey());
			}
		}
	%>

	<div class="form">
		<form method="post" id="form2">
			<table>
				<tr>
					<td>Partida <input type="text" name="txtPartida">
					</td>
					<td>Chegada <input type="text" name="txtChegada">
					</td>
				</tr>
			</table>
			<!-- 					<input type="submit" value="Enviar" name="B1" />  -->
			<div class="areaForm">
				<div class="botao2">
					<a class="botao" href="#" name="envia"> Enviar</a>
				</div>
			</div>
		</form>
	</div>
	<%
		// 		String dono = "";
		// 		dono = (String) session.getAttribute("sesNome");

		// 		Filter myFilter = new Query.FilterPredicate("dono",
		// 				FilterOperator.EQUAL, dono);

		// 		Query query = new Query("Caminho").addSort("dataDeCriacao",
		// 				Query.SortDirection.DESCENDING);
		// 		query.setFilter(myFilter);

		// 		List<Entity> caminhos = datastore.prepare(query).asList(
		// 				FetchOptions.Builder.withDefaults());

		if (request.getParameter("txtPartida") != null
				&& request.getParameter("txtChegada") != null) {
			if (!request.getParameter("txtPartida").equals("")
					&& !request.getParameter("txtChegada").equals("")) {
				String partida = request.getParameter("txtPartida");
				String chegada = request.getParameter("txtChegada");

				Entity caminho = new Entity("Caminho");

				caminho.setProperty("dono", dono);

				caminho.setProperty("partida", partida);
				caminho.setProperty("chegada", chegada);

				Date dataCriacao = new Date();
				caminho.setProperty("dataDeCriacao", dataCriacao);

				chegadaF = "";
				partidaF = "";
				boolean existe = false;

				for (Entity cami : caminhos) {
					chegadaF = (String) cami.getProperty("chegada");
					partidaF = (String) cami.getProperty("partida");

					if (chegada.equals(chegadaF)
							&& partida.equals(partidaF)) {
						existe = true;
					}

				}
				if (!existe) {
					datastore.put(caminho);
				}

			}
		}
	%>
	<%
		// 		TODO arrumar esta bosta
		if (caminhos.isEmpty()) {
	%>
	<p>
		Nao ha Caminhos de
		<%=dono%>.
	</p>
	<%
		} else {
	%>
	<p>
		Caminhos de
		<%=dono%>:
	</p>
	<%
		int num = 10;
			for (Entity cami : caminhos) {
				chegadaF = (String) cami.getProperty("chegada");
				partidaF = (String) cami.getProperty("partida");
	%>
	<div class="caminho">
		<div class="descCaminho">
			<b><%=partidaF%></b> Para: <i><%=chegadaF%></i>
		</div>
		<form method="post" id="form<%=num%>">
			<div class="excluir">

				<input class="hidden" name="bKey<%=num%>" value="<%=num%>" /> <input
					class="hidden" name="bExcluirP" value="<%=partidaF%>" /> <input
					class="hidden" name="bExcluirC" value="<%=chegadaF%>" /> <input
					type="submit" name="Excluir" value="Excluir" />
			</div>
		</form>
	</div>


	<%
		num++;
			}
		}
	%>

</body>
</html>