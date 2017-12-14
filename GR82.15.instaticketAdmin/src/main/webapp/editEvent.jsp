<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.ArrayList, es.uc3m.tiw.domains.Event, org.apache.commons.codec.binary.StringUtils, org.apache.commons.codec.binary.Base64"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<title>Editar evento</title>
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
		<p class="w3-left">Editar evento</p>
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
			Event eventToEdit = (Event) request.getAttribute("event");
		%>
		<div class="w3-container w3-center">

			<p>Edita los campos que desees modificar:</p>
			<form method="post" action="editEvent" id="editForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="<%=eventToEdit.getId()%>">
				<p>Título:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="text" name="title"
					minlength="5" maxlength="50" value="<%=eventToEdit.getTitle()%>" />
				<br>
				<p>Imagen:</p>
				<div class="w3-row">
					<div class="w3-container w3-third"></div>
					<div class="w3-container w3-third">
						<img
							src="<%StringBuilder sb = new StringBuilder();
			sb.append("data:image/png;base64,");
			sb.append(StringUtils.newStringUtf8(Base64.encodeBase64(eventToEdit.getImage(), false)));
			out.print(sb.toString());%>"
							style="max-width: 100%; max-height: 100%">
					</div>
					<div class="w3-container w3-third"></div>
				</div>
				<br>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="file" name="image"
					accept="image/*" />
				<p>Precio de la entrada:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="number" name="price"
					min="0.0" max="9999.99" step=".01" value="<%=eventToEdit.getPrice()%>">
				<br>
				<p>Fecha y hora:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="datetime-local"
					name="date" value="<%=eventToEdit.getEventDate()%>" />
				<br>
				<p>Sala, recinto o lugar:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="text" name="place"
					minlength="8" maxlength="50" value="<%=eventToEdit.getPlace()%>" />
				<br>
				<p>Entradas disponibles:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="number"
					name="availableTickets" min="1" max="99999" value="<%=eventToEdit.getAvailableTickets()%>" />
				<br>
				<p>Descripción:</p>
				<textarea class="w3-input w3-border w3-light-grey" rows="16" cols="60" name="description" form="editForm"><%=eventToEdit.getDescription()%></textarea>

			</form>
			<p>
				<button class="w3-button w3-theme w3-grey" onclick="document.getElementById('confirmBox').style.display='block'">Confirmar
					cambios</button>
			<p>
		</div>
		<hr style="border: 1px solid grey; width: 90%; margin-left: 5%">
		<div class="w3-container w3-center">
			<p>Si deseas cancelar el evento:</p>
			<form method="post" id="cancelEventForm" action="cancelEvent">
				<input type="hidden" name="id" value="<%=eventToEdit.getId()%>">
			</form>
			<p>
				<button class="w3-button w3-theme w3-red" onclick="document.getElementById('confirmBox2').style.display='block'">Cancelar
					evento</button>
			<p>
		</div>

	</div>

	<div id="confirmBox" class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity w3-center" style="padding: 16px">
			<p>¿Estás seguro de que quieres cambiar estos datos?</p>
			<div class="w3-row">
				<button class="w3-button w3-theme w3-green w3-medium" type="submit" form="editForm">Sí</button>
				<button class="w3-button w3-theme w3-grey w3-medium" onclick="document.getElementById('confirmBox').style.display='none'">No</button>
			</div>
		</div>
	</div>

	<div id="confirmBox2" class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity w3-center" style="padding: 16px">
			<p>¿Estás seguro de que quieres cancelar el evento?</p>
			<div class="w3-row">
				<button class="w3-button w3-theme w3-grey w3-medium" type="submit" form="cancelEventForm">Sí</button>
				<button class="w3-button w3-theme w3-grey w3-medium"
					onclick="document.getElementById('confirmBox2').style.display='none'">No</button>
			</div>
		</div>
	</div>


</body>
</html>