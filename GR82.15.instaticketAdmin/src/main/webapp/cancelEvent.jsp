<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="es.uc3m.tiw.domains.Event"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<title>Cancelar evento</title>
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

	<jsp:include page="sidebarLogged.jsp" />

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-container w3-xlarge">
		<p class="w3-left">Cancelar evento usuario</p>
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
		</header>

		<div class="w3-container w3-center">

			<%
				Event event = (Event) request.getAttribute("event");
			%>

			<p>
				¿Estás seguro de que quieres cancelar el evento <b><%=event.getTitle()%></b>?
			</p>

			<form method="post" action="cancelEvent" id="cancelForm">
				<input type="hidden" name="id" value="<%=event.getId()%>">
			</form>
			<div class="w3-row">
				<button class="w3-button w3-theme w3-grey w3-medium" type="submit" form="cancelForm">Sí</button>
				<a href="javascript:history.back()" class="w3-button w3-theme w3-grey w3-medium">No</a>
			</div>

		</div>

	</div>
</body>
</html>