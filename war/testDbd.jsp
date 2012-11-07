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
<title>Insert title here</title>
</head>
<body>

<form action="testDbd_2.jsp" method="get" >
	<table>
		<tr>
			<td>
				Primeiro nome			
				<input type= "text" name="txtFirtName">
			</td>
			<td>
				Segundo Nome
				<input type= "text" name="txtLastName">
			</td>
		</tr>	
	</table>
	Salvar
	<input type= "button" name="bButton" value = "Enviar">		
</form>
</body>
	<% DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		
		Entity employee = new Entity("Employee");
		
		employee.setProperty("firstName", "Danilo");
		employee.setProperty("lastName", "Salieri");
		
		Date hireDate = new Date(20);
		employee.setProperty("hireDate", hireDate);
		
		employee.setProperty("attendedHrTraining", true);
		
		datastore.put(employee);
	
	%>
	<% 	
		String employeeName = "Danilo";
		Key employeeKey = KeyFactory.createKey("Employee", employeeName);
		Query query = new Query("Employee").addSort("hireDate", Query.SortDirection.DESCENDING);	
		List<Entity> employees = datastore.prepare(query).asList(FetchOptions.Builder.withDefaults());
		
		
		if (employees.isEmpty()) {
	        %>
	        <p>Nao ha Empregados.</p>
	        <%
	    } else {
	        %>
	        <p>Empregados:</p>
	        <%
	        for (Entity emplo : employees) {
	            String lastName = (String) emplo.getProperty("lastName");
	            String firstName = "";
	            if (emplo.getProperty("firstName") == null) {
	                %>
	                <p>An anonymous person wrote:</p>
	                <%
	            } else {
	                firstName = (String) emplo.getProperty("firstName");
	                %>
	                <p><b><%=lastName%></b> wrote:</p>
	                <%
	            }
	            %>
	            <blockquote><%=firstName%></blockquote>
	            <%
	        }
	    }
		
		out.println("<p>" + employee.getKey().toString());
		//employee = datastore.get(employee.getKey());
		out.println("<p>" + employee.getProperty("hireDate"));
		//out.println("<p>" + datastore.);
	%>
</html>