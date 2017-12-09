<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="es.uc3m.tiw.model.Event, java.time.LocalDateTime, org.apache.commons.codec.binary.StringUtils, org.apache.commons.codec.binary.Base64;"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="resources/css/fonts.css">
<link rel="stylesheet" href="resources/css/font-awesome-4.7.0/css/font-awesome.min.css">
<title>Evento</title>

<style>
.w3-sidebar a {
	font-family: "Roboto", sans-serif
}

body, h1, h2, h3, h4, h5, h6, .w3-wide {
	font-family: "Montserrat", sans-serif;
}
</style>

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

	<%
		if ((Boolean) request.getAttribute("cannotBuy") != null) {
			if ((Boolean) request.getAttribute("cannotBuy") == true) {
	%>
	<div id="cannotBuy" class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity">
			<div class="w3-container">
				<i onclick="document.getElementById('cannotBuy').style.display='none'"
					class="fa fa-remove w3-right w3-button w3-transparent w3-large"></i>
				<p>No puedes comprar entradas para un evento que tú mismo has creado.</p>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#cannotBuy").css("display", "block");
			$("#cannotBuy").delay(2500).fadeOut();
		});
	</script>
	<%
		}
		}
	%>

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-xlarge w3-container">
		<p class="w3-left">Información del evento</p>
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

		<%
			Event event = (Event) request.getAttribute("event");
		%>

		<!-- Image header -->
		<div class="w3-container w3-center">
			<img
				src="<%StringBuilder sb = new StringBuilder();
			sb.append("data:image/png;base64,");
			sb.append(StringUtils.newStringUtf8(Base64.encodeBase64(event.getImage(), false)));
			out.print(sb.toString());%>"
				style="max-width: 100%; max-height: 400px">
		</div>
		<br>
		<div class="w3-main">
			<div class="w3-row">
				<div class="w3-col s9 w3-center" style="padding-top: 0.25em">
					<h1><%=event.getTitle()%></h1>
				</div>
				<div class="w3-col s3 w3-center">
					<%
						if (event.getState().equals("Disponible")) {
					%>
					<a href="buyTicket?id=<%=event.getId()%>"><span
						class="w3-tag w3-large w3-padding-large w3-light-grey w3-center w3-hover-orange" style="cursor: pointer"> <strong>COMPRAR<br>ENTRADAS
						</strong></span></a>
					<%
						} else {
					%>
					<span class="w3-tag w3-large w3-padding-large w3-red w3-center" style="cursor: pointer"> <strong>EVENTO<br><%=event.getState().toUpperCase()%></strong></span>
					<%
						}
					%>
				</div>
			</div>
			<hr style="border: 1px solid grey; width: 90%; margin-left: 5%">

			<div class="w3-row w3-padding-16" style="width: 90%; margin-left: 5%">
				<div class="w3-twothird w3-container">
					<%
						String description = event.getDescription();
						description = description.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
					%>
					<h5>Descripción</h5>
					<p style="text-align: justify"><%=description%></p>
				</div>
				<div class="w3-third w3-container">
					<h5>Información del evento</h5>
					<label>Categoría</label>
					<p class="w3-border w3-padding-large w3-padding-16 w3-center"><%=event.getCategory()%></p>
					<label>Precio</label>
					<p class="w3-border w3-padding-large w3-padding-16 w3-center"><%=event.getPrice()%>€
					</p>
					<label>Entradas disponibles</label>
					<p class="w3-border w3-padding-large w3-padding-16 w3-center"><%=event.getAvailableTickets()%></p>
					<label>Fecha y hora</label>
					<%
						LocalDateTime dateTime = event.getEventDate();
					%>
					<p class="w3-border w3-padding-large w3-padding-16 w3-center"><%=dateTime.toLocalDate()%><br><%=dateTime.toLocalTime()%>h
					</p>
					<label>Lugar</label>
					<p class="w3-border w3-padding-large w3-padding-16 w3-center" style="word-break: break-all"><%=event.getPlace()%></p>
				</div>
			</div>


		</div>
		<!-- End page content -->
	</div>

</body>
</html>

