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
<form action="respCriacaoDeCaminhos.jsp" method="get" >
	<table>
		<tr>
			<td>
				Partida
				<input type= "text" name="txtPartida">				
			</td>
			<td>
				Chegada
				<input type= "text" name="txtChegada">
			</td>
		</tr>	
	</table>
	<input type="submit" value="Enviar" name="B1" />
</form>
</body>
</html>