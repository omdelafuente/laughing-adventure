<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.math.BigDecimal, java.time.LocalDateTime, java.util.List, org.apache.commons.codec.binary.StringUtils, org.apache.commons.codec.binary.Base64, es.uc3m.tiw.domains.*"%>

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

<!-- Se muestran 9 eventos aleatoriamente -->
		<%
			List<Event> events = (List<Event>) request.getAttribute("events");
		%>

		<!-- Image header -->
		<div class="w3-container w3-center">
			<h1 class="w3-text-grey">
				<b><%=events.get(0).getTitle()%></b>
			</h1>
			<a href="event?id=<%=events.get(0).getId()%>"><img class="event-img"
				src="<%StringBuilder sb = new StringBuilder();
			sb.append("data:image/png;base64,");
			sb.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(0).getImage(), false)));
			out.print(sb.toString());%>"
				style="max-width: 100%; max-height: 600px"></a>
		</div>

		<div class="w3-container">
			<p>&nbsp;</p>
		</div>

		<!-- Product grid -->
		<div class="w3-row">
			<div class="w3-col l3 s6">
				<div class="w3-container">
					<a href="event?id=<%=events.get(1).getId()%>"><img class="event-img"
						src="<%StringBuilder sb1 = new StringBuilder();
			sb1.append("data:image/png;base64,");
			sb1.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(1).getImage(), false)));
			out.print(sb1.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(1).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(1).getTitle()%><br>
						<b><%=events.get(1).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(1).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
				<div class="w3-container">
					<a href="event?id=<%=events.get(2).getId()%>"><img class="event-img"
						src="<%StringBuilder sb2 = new StringBuilder();
			sb2.append("data:image/png;base64,");
			sb2.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(2).getImage(), false)));
			out.print(sb2.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(2).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(2).getTitle()%><br>
						<b><%=events.get(2).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(2).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
			</div>

			<div class="w3-col l3 s6">
				<div class="w3-container">
					<a href="event?id=<%=events.get(3).getId()%>"><img class="event-img"
						src="<%StringBuilder sb3 = new StringBuilder();
			sb3.append("data:image/png;base64,");
			sb3.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(3).getImage(), false)));
			out.print(sb3.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(3).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(3).getTitle()%><br>
						<b><%=events.get(3).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(3).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
				<div class="w3-container">
					<a href="event?id=<%=events.get(4).getId()%>"><img class="event-img"
						src="<%StringBuilder sb4 = new StringBuilder();
			sb4.append("data:image/png;base64,");
			sb4.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(4).getImage(), false)));
			out.print(sb4.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(4).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(4).getTitle()%><br>
						<b><%=events.get(4).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(4).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
			</div>

			<div class="w3-col l3 s6">
				<div class="w3-container">
					<a href="event?id=<%=events.get(5).getId()%>"><img class="event-img"
						src="<%StringBuilder sb5 = new StringBuilder();
			sb5.append("data:image/png;base64,");
			sb5.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(5).getImage(), false)));
			out.print(sb5.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(5).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(5).getTitle()%><br>
						<b><%=events.get(5).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(5).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
				<div class="w3-container">
					<a href="event?id=<%=events.get(6).getId()%>"><img class="event-img"
						src="<%StringBuilder sb6 = new StringBuilder();
			sb6.append("data:image/png;base64,");
			sb6.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(6).getImage(), false)));
			out.print(sb6.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(6).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(6).getTitle()%><br>
						<b><%=events.get(6).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(6).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
			</div>

			<div class="w3-col l3 s6">
				<div class="w3-container">
					<a href="event?id=<%=events.get(7).getId()%>"><img class="event-img"
						src="<%StringBuilder sb7 = new StringBuilder();
			sb7.append("data:image/png;base64,");
			sb7.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(7).getImage(), false)));
			out.print(sb7.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(7).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(7).getTitle()%><br>
						<b><%=events.get(7).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(7).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
				<div class="w3-container">
					<a href="event?id=<%=events.get(8).getId()%>"><img class="event-img"
						src="<%StringBuilder sb8 = new StringBuilder();
			sb8.append("data:image/png;base64,");
			sb8.append(StringUtils.newStringUtf8(Base64.encodeBase64(events.get(8).getImage(), false)));
			out.print(sb8.toString());%>"
						style="width: 100%"></a>
					<%
						if (events.get(8).getPrice().compareTo(BigDecimal.ZERO) != 0) {
					%>
					<p><%=events.get(8).getTitle()%><br>
						<b><%=events.get(8).getPrice()%>€</b>
					</p>
					<%
						} else {
					%>
					<p><%=events.get(8).getTitle()%><br>
						<b>Gratis</b>
					</p>
					<%
						}
					%>
				</div>
			</div>
		</div>
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

