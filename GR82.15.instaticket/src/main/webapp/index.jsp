<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.math.BigDecimal, java.time.LocalDateTime, java.util.List, org.apache.commons.codec.binary.StringUtils, org.apache.commons.codec.binary.Base64"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<script src="/lib/jquery-3.2.1.min.js"></script>
<title>Instaticket</title>

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

	<!-- Mensaje de éxito al darse de baja -->
	<%
		if ((Boolean) request.getAttribute("dropOutSuccess") != null) {
			if ((Boolean) request.getAttribute("dropOutSuccess") == true) {
	%>
	<div id="dropOutSuccess" class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity">
			<div class="w3-container">
				<i onclick="document.getElementById('dropOutSuccess').style.display='none'"
					class="fa fa-remove w3-right w3-button w3-transparent w3-large"></i>
				<p>Tu cuenta ha sido eliminada. Sentimos que te vayas y esperamos volver a verte.</p>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#dropOutSuccess").css("display", "block");
			$("#dropOutSuccess").delay(5000).fadeOut();
		});
	</script>
	<%
		}
		}
	%>

	<!-- Mensaje de éxito al editar el perfil -->
	<%
		if ((Boolean) request.getAttribute("editSuccess") != null) {
			if ((Boolean) request.getAttribute("editSuccess") == true) {
	%>
	<div id="editSuccess" class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity">
			<div class="w3-container">
				<i onclick="document.getElementById('editSuccess').style.display='none'"
					class="fa fa-remove w3-right w3-button w3-transparent w3-large"></i>
				<p>Tus datos han sido cambiados correctamente.</p>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#editSuccess").css("display", "block");
			$("#editSuccess").delay(2500).fadeOut();
		});
	</script>
	<%
		}
		}
	%>

	<!-- Mensaje de éxito al comprar una entrada -->
	<%
		if ((Boolean) request.getAttribute("purchaseSuccess") != null) {
			if ((Boolean) request.getAttribute("purchaseSuccess") == true) {
	%>
	<div id="purchaseSuccess" class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity">
			<div class="w3-container">
				<i onclick="document.getElementById('purchaseSuccess').style.display='none'"
					class="fa fa-remove w3-right w3-button w3-transparent w3-large"></i>
				<p>
					<i class="w3-text-green w3-large fa fa-check-square-o"></i>&nbsp;La transacción ha sido satisfactoria, ¡gracias por
					comprar en Instaticket!
				</p>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#purchaseSuccess").css("display", "block");
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
		<p class="w3-left">Eventos destacados</p>
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


		
		<div class="w3-container">
			<p>&nbsp;</p>
		</div>
		<div class="w3-black w3-center w3-padding-24">Powered by Óscar Martín de la Fuente, Saúl Martín Rodríguez & Luis
			Miguel Sánchez</div>

		<!-- End page content -->
	</div>


	<script>
		$(document).ready(function() {
			$('.event-img').hover(function() {
				$(this).addClass('transition');

			}, function() {
				$(this).removeClass('transition');
			});
		});
	</script>
</body>
</html>

