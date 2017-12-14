<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
</head>

<style>
.w3-sidebar a {
	font-family: "Roboto", sans-serif
}

body, h1, h2, h3, h4, h5, h6, .w3-wide {
	font-family: "Montserrat", sans-serif;
}
</style>

<body>

	<%
		if (session.getAttribute("loggedUser") != null) {
	%>

	<!-- Sidebar/menu -->
	<nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:250px" id="sidebar">
	<div class="w3-container w3-display-container w3-padding-16">
		<i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i> <a href="index.jsp"
			style="text-decoration: none"><h3 class="w3-wide">
				<b>INSTATICKET<br>
				<b style="font-size: 0.4em">Administración</b></b>
			</h3></a>
	</div>
	<div class="w3-padding-32 w3-large w3-text-grey" style="font-weight: bold">
		<a href="users" class="w3-bar-item w3-button">Gestión de usuarios</a> <a href="events" class="w3-bar-item w3-button">Gestión
			de eventos</a><br> <a href="availableChats" class="w3-bar-item w3-button">Buzón de conversaciones</a> <a href="logOut"
			class="w3-bar-item w3-button">Cerrar sesión</a>
	</div>
	</nav>
	<%
		}
	%>
</body>
</html>