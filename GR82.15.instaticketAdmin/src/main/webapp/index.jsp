<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<title>Instaticket</title>
</head>
<body class="w3-content" style="max-width: 1200px">

	<!-- Sidebar/menu -->

	<%
		if (session.getAttribute("loggedUser") != null) {
	%>
	<jsp:include page="sidebarLogged.jsp" />
	<%
		} else {
	%>
	<jsp:include page="sidebarNotLogged.jsp" />
	<%
		}
	%>


	<!-- !PAGE CONTENT! -->

	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-xlarge w3-container">
		<p class="w3-left">Bienvenido, administrador</p>

		<!-- Si el usuario está logeado se le permite buscar  --> <%
			if (session.getAttribute("loggedUser") != null) {
		%>
		<form action="search" method="post">
			<p class="w3-right">
				<input type="hidden" name="type" value="simple">
				<input class="w3-border" type="text" name="search" style="padding: 8px; font-size: 15px; float: left"
					placeholder="Buscar..." required>
				<button class="w3-bar-item w3-button w3-hover-grey" type="submit">
					<i class="fa fa-search"></i>
				</button>
			</p>
		</form>
		<%
			}
		%> </header>

		<!-- Body content -->

		<div class="w3-large w3-container w3-padding-64">
			<p class="w3-center">
				¡Bienvenido a la página de Instaticket para administradores!<br>Aquí podras gestionar los usuarios y eventos
				presentes en el portal.
			</p>
		</div>

		<!-- Si el usuario está logeado se muestran botones para gestionar eventos o usuarios, y sino, para iniciar sesión -->
		<div class="w3-center w3-container">

			<%
				if (session.getAttribute("loggedUser") != null) {
			%>
			<div class="w3-container w3-half">
				<a href="users"><button class="w3-button w3-border w3-hover-grey w3-right">Usuarios</button></a>
			</div>
			<div class="w3-container w3-half">
				<a href="events"><button class="w3-button w3-border w3-hover-grey w3-left">Eventos</button></a>
			</div>
			<%
				} else {
			%>
			<div class="w3-container w3-center">
				<a href="login.jsp"><button class="w3-button w3-border w3-hover-grey">Iniciar sesión</button></a>
			</div>
			<%} %>
		</div>
</body>
</html>