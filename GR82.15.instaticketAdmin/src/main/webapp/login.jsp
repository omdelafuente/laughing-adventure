<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
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

	<div class="w3-main" style="margin-left: 250px">

		<!--  Top header -->

		<header class="w3-container w3-xlarge">
		<p class=w3-left>Acceder</p>
		</header>

		<div class="w3-container w3-center">
		
			<!-- Se muestrna los fallos de login, si los hubiera -->
			<%
				if ((Boolean) request.getAttribute("loginSuccess") != null) {
					if ((Boolean) request.getAttribute("loginSuccess") == false) {
			%>

			<div class="w3-panel w3-red w3-card-4">
				<p><%=request.getAttribute("errorLogin")%></p>
			</div>
			<%
				}
				}
			%>
			
			<!-- Formulario de inicio de sesión -->
			<p>Iniciar sesión como administrador en Instaticket:</p>
			<form method="post" action="login">
				<p>Usuario administrador:</p>
				<input class="w3-input w3-border w3-light-grey w3-text-grey" style="width: 30%; display: inline-block" type="text"
					name="user" value="admin" disabled>
				<br>
				<p>Contraseña:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 30%; display: inline-block" maxlength="30" type="password"
					name="psw" required />
				<br>
				<p>
					<button class="w3-button w3-theme w3-grey" type="submit">Acceder</button>
				<p>
			</form>

		</div>
	</div>
	>
</body>
</html>