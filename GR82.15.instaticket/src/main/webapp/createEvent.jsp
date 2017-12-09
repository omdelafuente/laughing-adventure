<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="resources/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="resources/css/fonts.css">
<title>Create an event</title>
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
		<p class="w3-left">Crear un evento</p>
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

		<!-- Formulario de creación de un evento -->
		<div class="w3-container w3-center">
			<p>Por favor, rellena el siguiente formulario para crear un nuevo evento:</p>
			<form method="post" action="createEvent" id="createEventForm" enctype="multipart/form-data">
				<p>Título:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="text" name="title"
					placeholder="Mínimo un texto descriptivo de 8 letras" minlength="5" maxlength="50" required />
				<br>
				<p>Categoría del evento:</p>
				<select name="category" class="w3-select w3-border w3-light-grey" style="width: 50%; display: inline-block" required>
					<option value="" disabled selected>Escoge una categoría</option>
					<option value="Cine">Cine</option>
					<option value="Teatro">Teatro</option>
					<option value="Conciertos">Conciertos</option>
					<option value="Festivales">Festivales</option>
					<option value="Arte">Arte</option>
					<option value="Deportes">Deportes</option>
					<option value="Otros">Otros</option>
				</select>
				<p>Imagen del evento:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="file" name="image"
					accept="image/*" required />
				<br>
				<p>Precio de la entrada:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="number" name="price"
					min="0.0" max="9999.99" step=".01" placeholder="Número entero o decimal con dos decimales" required />
				<br>
				<p>Fecha y hora:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="datetime-local"
					name="date" required />
				<br>
				<p>Sala, recinto o lugar:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="text" name="place"
					placeholder="Mínimo un texto descriptivo de 8 letras" minlength="8" maxlength="50" required />
				<br>
				<p>Entradas disponibles:</p>
				<input class="w3-input w3-border w3-light-grey" style="width: 50%; display: inline-block" type="number"
					name="availableTickets" min="1" max="99999" required />
				<br>
				<p>Descripción:</p>
				<textarea class="w3-input w3-border w3-light-grey" rows="16" cols="60" name="description" form="createEventForm" required></textarea>
				<p>
					<button class="w3-button w3-theme w3-grey" type="submit">Crear evento</button>
				<p>
			</form>
		</div>

	</div>

</body>
</html>