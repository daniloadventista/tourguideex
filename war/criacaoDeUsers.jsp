<%@ page import="javax.jws.soap.SOAPBinding.Use"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
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
<title>Tour Guide!</title>
</head>
<body>
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
				<div class="itemPai">Opcoes</div>
				<img
					src="https://developers.google.com/appengine/images/appengine-noborder-120x30.gif"
					alt="Powered by Google App Engine" />
			</div>
			<div id="painelDireito">
				<div class="conteudo">
					<!-- 					fim do cabecalho -->


					<%
						String userS = "";
						String logout = "";

						logout = request.getParameter("txtLogout");
						userS = session.toString();
						userS = (String) session.getAttribute("sesNome");

						if (logout != null) {
							if (logout.equals("logout")) {
								userS = "";
							}
						}

						if (userS != null) {
							if (!userS.equals("")) {
								out.println("<div class=\"hidden\">");
							}
						}
					%>
					<!-- 	criacao de usuarios -->
					<!-- 	Formulario de usuario -->
					<div class="form">
						<form method="post" id="form1">
							<table>
								<tr>
									<td>Nome <input type="text" name="txtNome">
									</td>
									<td>Senha <input type="password" name="passSenha">
									</td>
								</tr>
							</table>
							<div class="areaForm">
								<div class="areaFormInt">
									<div class="botao1">
										<a class="botao" href="#" name="envia">Enviar</a>
									</div>
								</div>
							</div>
							<!--  	<input type="submit" value="Enviar" name="B1" /> 	 -->
						</form>
					</div>

					<!-- 	Chamada do banco de dados -->
					<%
						if (userS != null) {
							if (!userS.equals("")) {
								out.println("</div>");
							}
						}
						if (userS != null) {
							if (!userS.equals("")) {
								out.println("<div class=\"resposta\"><p>Ola " + userS
										+ ", seja bem vindo(a) ou Tour Guide</p>");
								out.println("<form method=\"post\" id=\"form1\">");
								out.println("	<div class=\"areaFormInt\">");
								out.println("		<div class=\"botao1\">");
								out.println("			<input class=\"hidden\" type=\"text\" value=\"logout\" name=\"txtLogout\">");
								out.println("			<a class=\"botao\" href=\"#\" name=\"envia\">Logout</a>");
								out.println("		</div>");
								out.println("	</div>");
								out.println("</form></div>");

								// 				<!-- 				<div class="areaFormInt"> -->
								// 				<!-- 					<div class="botao1"> -->
								// 				<!-- 						<a class="botao" href="#" name="envia">Logout</a> -->
								// 				<!-- 					</div> -->
								// 				<!-- 				</div> -->

							}
						} else {
							out.println("<div class=\"resposta\"><p>Faca ou crie seu login</p></div>");
						}

						DatastoreService datastore = DatastoreServiceFactory
								.getDatastoreService();
						// 		out.print("<p>Conectado</p>");	

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
									session.setAttribute("sesNome", nome);
								}
							}
							if (!existe && !("").equals((String) user.getProperty("nome"))) {
								datastore.put(user);
								out.print("<div class=\"resposta\"><p>Usuario Cadastrado</p>");
								out.println("</div>");
							} else {
								if (valido) {
									out.println("<div class=\"resposta\"><p>Usuario valido</p>");
									out.println("</div>");
								} else {
									out.print("<div class=\"resposta\"><p>Usuario e/ou senha Invalido(s)</p>");
									out.println("</div>");
								}
							}
						}
					%>
					<!-- 	Fim de criacao de usuario -->
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