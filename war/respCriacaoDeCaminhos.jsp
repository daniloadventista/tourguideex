<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="java.util.Date"  %>
<%@ page import="java.util.List"  %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"  %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"  %>
<%@ page import="com.google.appengine.api.datastore.Entity"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<% DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		if (request.getParameter("txtPartida")!= null){
			String partida = request.getParameter("txtPartida");	
			String chegada = request.getParameter("txtChegada");
			
			Entity caminho = new Entity("Caminho");
			
			caminho.setProperty("dono", "");
			caminho.setProperty("partida", partida);
			caminho.setProperty("chegada", chegada);
			
			Date dataCriacao = new Date();
			caminho.setProperty("dataDeCriacao", dataCriacao);
			
			datastore.put(caminho);
		}
	%>
	<% 	
		Query query = new Query("Caminho").addSort("dataDeCriacao", Query.SortDirection.DESCENDING);	
		List<Entity> caminhos = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
		
		
		if (caminhos.isEmpty()) {
	        %>
	        <p>Nao ha Caminhos.</p>
	        <%
	    } else {
	        %>
	        <p>Caminhos:</p>
	        <%
	        for (Entity cami : caminhos) {
	            String chegadaF = (String) cami.getProperty("chegada");
	            String partidaF = "";
	            if (cami.getProperty("partida") == null) {
	                %>
	                <p>Caminho Vazio</p>
	                <%
	            } else {
	            	partidaF = (String) cami.getProperty("partida");
	                %>
	                <p><b><%=partidaF%></b> Para:</p>
	                <%
	                %>
		            <blockquote><%=chegadaF%></blockquote>
		            <%
	            }
	        }
	    }
	%>
	</body>
</html>