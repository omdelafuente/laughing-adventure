<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<script src="/lib/jquery-3.2.1.min.js"></script>
<script src="/lib/jquery.validate.js"></script>
<script src="/lib/additional-methods.js"></script>
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

	<!-- Modal con el formulario de búsqueda avanzada -->
	<div class="w3-container">
		<div id="searchModal" class="w3-modal">
			<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width: 650px">
				<div class="w3-center">
					<br> <span onclick="document.getElementById('searchModal').style.display='none'"
						class="w3-button w3-xlarge w3-hover-red w3-display-topright">&times;</span>
					<h3>Búsqueda avanzada</h3>
				</div>

				<div class="w3-panel w3-red w3-card-4 form-errors" style="display: none"></div>

				<form id="searchForm" class="w3-container" method="post" action="search">
					<div class="w3-section">
						<input type="hidden" name="type" value="advanced">
						<label><b>Título</b></label>
						<input name="title" class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="text" maxlength="30">
						<label><b>Categoría</b></label>
						<select name="category" class="w3-select w3-border w3-light-grey w3-margin-bottom input-group">
							<option value="" disabled selected>Escoge una categoría</option>
							<option value="Cine">Cine</option>
							<option value="Teatro">Teatro</option>
							<option value="Conciertos">Conciertos</option>
							<option value="Festivales">Festivales</option>
							<option value="Arte">Arte</option>
							<option value="Deportes">Deportes</option>
							<option value="Otros">Otros</option>
						</select>

						<label><b>Sala, recinto o lugar</b></label>
						<input class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="text" name="place" maxlength="25">
						<div class="w3-row">
							<div class="w3-center">Intervalo de fechas</div>
							<div class="w3-container w3-half">
								<label><b>Desde</b></label>
								<input class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="date" name="dateMin">
							</div>
							<div class="w3-container w3-half">
								<label><b>Hasta</b></label>
								<input class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="date" name="dateMax">
							</div>
						</div>

						<div class="w3-row">
							<div class="w3-center">Rango de precios</div>
							<div class="w3-container w3-half">
								<label><b>Precio mínimo</b></label>
								<input class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="number" name="priceMin" min="0.0"
									max="9999.99" step=".01">
							</div>
							<div class="w3-container w3-half">
								<label><b>Precio máximo</b></label>
								<input class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="number" name="priceMax" min="0.0"
									max="9999.99" step=".01">
							</div>
						</div>
						<label><b>Texto en descripción</b></label>
						<input name="description" class="w3-input w3-border w3-light-grey w3-margin-bottom input-group" type="text"
							maxlength="50">
						<label><b>Estado</b></label>
						<select name="state" class="w3-select w3-border w3-light-grey w3-margin-bottom input-group">
							<option value="" disabled selected>Estado del evento</option>
							<option value="Disponible">Disponibe</option>
							<option value="Completo">Completo</option>
							<option value="Finalizado">Finalizado</option>
							<option value="Cancelado">Cancelado</option>
						</select>
						<div class="w3-container w3-center">
							<button class="w3-button w3-green" type="submit">
								<i class="fa fa-search w3-margin-right"></i>Buscar evento
							</button>
							<button class="w3-button w3-grey" type="reset">
								<i class="fa fa-trash w3-margin-right"></i>Limpiar campos
							</button>
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>

	<script>
		//validación del formulario client-side con JQuery Validation plugin
		$(document)
				.ready(
						function() {

							$("input[name='dateMin']").on(
									'input',
									function() {

										$("input[name='dateMax']").attr("min",
												$(this).val());
									});
							$("input[name='dateMax']").on(
									'input',
									function() {

										$("input[name='dateMin']").attr("max",
												$(this).val());
									});

							$("input[name='priceMin']").on(
									'input',
									function() {

										$("input[name='priceMax']").attr("min",
												$(this).val());
									});
							$("input[name='priceMax']").on(
									'input',
									function() {

										$("input[name='priceMin']").attr("max",
												$(this).val());
									});

							$("#searchForm")
									.validate(
											{
												errorLabelContainer : ".form-errors",
												wrapper : "p",
												groups : {
													name : "title place category dateMin dateMax priceMax priceMin state description"
												},
												rules : {
													title : {
														require_from_group : [
																1,
																".input-group" ]
													},
													place : {
														require_from_group : [
																1,
																".input-group" ]
													},
													category : {
														require_from_group : [
																1,
																".input-group" ]
													},
													dateMin : {
														require_from_group : [
																1,
																".input-group" ]
													},
													dateMax : {
														require_from_group : [
																1,
																".input-group" ]
													},
													priceMax : {
														require_from_group : [
																1,
																".input-group" ]
													},
													priceMin : {
														require_from_group : [
																1,
																".input-group" ]
													},
													description : {
														require_from_group : [
																1,
																".input-group" ]
													},
													state : {
														require_from_group : [
																1,
																".input-group" ]
													}

												},
												messages : {
													title : "Debes rellenar al menos un campo.",
													place : "Debes rellenar al menos un campo.",
													category : "Debes rellenar al menos un campo.",
													dateMax : "Debes rellenar al menos un campo.",
													dateMin : "Debes rellenar al menos un campo.",
													priceMax : {
														min : "El precio máximo no puede ser menor que el mínimo."
													},
													priceMin : {
														max : "El precio mínimo no puede ser mayor que el máximo."
													},
													description : "Debes rellenar al menos un campo.",
													state : "Debes rellenar al menos un campo."
												}

											});

							if (!($("#searchForm").valid())) {
								$(".form-errors").css('display', 'block');
							}

						});
	</script>



</body>
</html>