<%-- 
    Document   : index
    Created on : 24/08/2012, 17:50:31
    Author     : 41080130
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="arquivos/myStyle.css" />
        <script type="text/javascript" src="arquivos/jquery-1.8.0.js"></script>
        <script type="text/javascript" src="arquivos/jqAnimations.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="atualisaConteudo()" >
        <div id ="painelSuperior"><h1>Tour Guide</h1>
            <div id ="menu">
                <div class ="botao"><a href="#">home</a></div>
                <div class ="botao"><a href="#">meus destinos</a></div>

                <div class ="botao"><a href="#">log in</a></div>
                <!-- <ul>
                    <li><a href="#">home</a></li>
                </ul>
                <ul>
                    <li><a href="#">meus destinos</a></li>
                </ul>
                <ul>
                    <li><a href="#">log in</a></li>
                </ul>-->

            </div>
        </div>
        <div id ="pagina">
            <div id ="conteudo">
                <div id ="painelEsquerdo"><br>
                    <div class ="itemPai">Meus Destinos</div>
                    <div class ="filho">Morro de sao paulo</div>                    
                </div>
                <div id ="painelDireito">
                	<div class ="conteudo">
                	<!--  <iframe src="maps.jsp" width="100%" height="100%"></iframe> -->
                	</div>
                </div>
            </div>
        </div>
        <div id="painelInferior">
            <h4>Mackenzie!</h4>
        </div>
    </body>
</html>
