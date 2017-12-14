<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.ArrayList"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<script src="/lib/jquery-3.2.1.min.js"></script>
<title>Log in</title>
</head>

<style>
.w3-sidebar a {
	font-family: "Roboto", sans-serif
}

body, h1, h2, h3, h4, h5, h6, .w3-wide {
	font-family: "Montserrat", sans-serif;
}
</style>

<body class="w3-content" style="max-width: 1200px">

	<jsp:include page="sidebarNotLogged.jsp" />

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-container w3-xlarge">
		<p class="w3-left">Acceder</p>
		<form action="search" method="post">
			<p class="w3-right">
				<input type="hidden" name="type" value="simple">
				<input class="w3-border" type="text" name="search" style="padding: 8px; font-size: 15px; float: left"
					placeholder="Buscar eventos..." required>
				<button class="w3-bar-item w3-button w3-hover-grey" type="submit">
					<i class="fa fa-search"></i>
				</button>
			</p>
		</form>
		</header>

		<div class="w3-container w3-center">

			<!-- Se muestra el error del filtro si se intenta acceder a una página sin estar logeado -->
			<%
				if ((Boolean) request.getAttribute("notLogged") != null) {
					if ((Boolean) request.getAttribute("notLogged") == true) {
			%>
			<div class="w3-card-4 w3-panel w3-leftbar w3-border-blue">
				<p>Debes iniciar sesión para continuar.</p>
			</div>
			<%
				}
				}
			%>

			<div class="w3-container w3-center">

				<!-- Mensaje de éxito del registro -->
				<%
					if ((Boolean) request.getAttribute("registerSuccess") != null) {
						if ((Boolean) request.getAttribute("registerSuccess") == true) {
				%>


				<div id="registerSuccess" class="w3-modal">
					<div class="w3-modal-content w3-animate-opacity">
						<div class="w3-container">
							<i onclick="document.getElementById('registerSuccess').style.display='none'"
								class="fa fa-remove w3-right w3-button w3-transparent w3-large"></i>
							<p>¡Enhorabuena! Te has registrado en Instaticket con éxito.</p>
						</div>
					</div>
				</div>

				<script>
					$(document).ready(function() {
						$("#registerSuccess").css("display", "block");
						$("#registerSuccess").delay(2500).fadeOut();
					});
				</script>
				<%
					}
					}
				%>
				
				<!-- Mensajes de error de login -->
				<%
					if ((Boolean) request.getAttribute("loginSuccess") != null) {
						if ((Boolean) request.getAttribute("loginSuccess") == false) {
							String error = (String) request.getAttribute("errorLogin");
				%>

				<div class="w3-panel w3-red w3-card-4">
					<p><%=error%></p>
				</div>
				<%
					}
					}
				%>

				<p>Inicia sesión en Instaticket:</p>
				<form method="post" action="login">
					<p>Correo electrónico:</p>
					<input class="w3-input w3-border w3-light-grey" style="width: 30%; display: inline-block" maxlength="30" type="email"
						name="email" required>
					<br>
					<p>Contraseña:</p>
					<input class="w3-input w3-border w3-light-grey" style="width: 30%; display: inline-block" maxlength="30" type="password"
						name="psw" value="" required />
					<br>
					<p>
						<button class="w3-button w3-theme w3-grey" type="submit">Acceder</button>
					<p>
				</form>

				<a href="register.jsp">¿Aún no estás registrado? Clic aquí para darte de alta</a>
			</div>
</body>
</html>