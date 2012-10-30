<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="com.google.appengine.api.datastore.Key"%>
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
<title>Tour Guide</title>
</head>
<body>
<form action="#" method="post" >
	<table>
		<tr>
			<td>
				Nome
				<input type= "text" name="txtNome">				
			</td>
			<td>
				Senha
				<input type= "password" name="passSenha">
			</td>
		</tr>	
	</table>
	<input type="submit" value="Enviar" name="B1" />
</form>
	<%
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();

		Query query = new Query("Usuario").addSort("dataDeCriacao",
				Query.SortDirection.DESCENDING);
		List<Entity> users = datastore.prepare(query).asList(
				FetchOptions.Builder.withDefaults());

		String senha;
		String nome;
		boolean existe = false;
		boolean valido = false;

		if (request.getParameter("txtNome") != null) {

			senha = request.getParameter("passSenha");
			nome = request.getParameter("txtNome");

			Entity user = new Entity("Usuario");

			user.setProperty("nome", nome);
			user.setProperty("senha", senha);

			Date dataCriacao = new Date();
			user.setProperty("dataDeCriacao", dataCriacao);

			//if (nomeF.equals(request.getParameter("txtNome")) {
			//existe = true;

			for (Entity u : users) {
				if (nome.equals(u.getProperty("nome"))) {
					existe = true;
					if (senha.equals(u.getProperty("senha")))
						valido = true;
				}
			}
			if (!existe)
				datastore.put(user);

			if (valido) {
				out.print("<p>Usuario valido</p>");
			} else {
				out.print("<p>Usuario Invalido</p>");
			}
		}

		if (users.isEmpty()) {
	%>

	<p>Nao ha Usuarios.</p>
	<%
		} else {
	%>
	<p>Usuarios:</p>
	<%
		for (Entity u : users) {
				String nomeF = (String) u.getProperty("nome");
				String senhaF = (String) u.getProperty("senha");
				if (u.getProperty("nome") == null) {
	%>
	<p>Usuario Invalido</p>
	<%
		} else {
	%>
	<p>
		<b><%=senhaF%></b> = senha de:
	</p>
	<%
		
	%>
	<blockquote><%=nomeF%></blockquote>
	<%
		}
			}
		}
	%>

</body>
</html>