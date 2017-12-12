<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.math.BigDecimal, java.util.List, es.uc3m.tiw.domains.Purchase, es.uc3m.tiw.domains.Event, es.uc3m.tiw.domains.Usr, java.time.LocalDateTime"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<script src="/lib/jquery-3.2.1.min.js"></script>
<title>Estadística de ventas</title>

<style>
body, h1, h2, h3, h4, h5, h6, .w3-wide {
	font-family: "Montserrat", sans-serif;
}
</style>

<body class="w3-content" style="max-width: 1200px">

	<!-- Sidebar/menu -->
	<jsp:include page="sidebarLogged.jsp" />

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-xlarge w3-container">
		<p class="w3-left">Estadística de ventas</p>
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

			<%
				List<Purchase> purchases = (List<Purchase>) request.getAttribute("purchases");

				if (purchases.isEmpty()) {
			%>

			No se han vendido entradas de este evento todavía.
			<%
				} else {
			%>

			<p>
				Entradas que se han vendido del evento
				<%=purchases.get(0).getEvent().getTitle()%>:
			</p>

			<%
				int availableTickets = purchases.get(0).getEvent().getAvailableTickets();
					int soldTickets = 0;

					for (int i = 0; i < purchases.size(); i++) {
						soldTickets += purchases.get(i).getTickets();
					}
			%>

			<div class="w3-row w3-border">
				<div class="w3-row w3-light-grey">
					<p class="w3-text-grey">
						<b>ESTADÍSTICAS TOTALES</b>
					</p>
				</div>
				<div class="w3-row">
					<div class="w3-container w3-third">
						<p>Entradas disponibles:</p>
						<p><%=availableTickets%></p>
					</div>
					<div class="w3-container w3-third">
						<p>Entradas vendidas:</p>
						<p><%=soldTickets%></p>
					</div>
					<div class="w3-container w3-third">
						<p>Beneficios:</p>
						<p><%=purchases.get(0).getEvent().getPrice().multiply(new BigDecimal(soldTickets))%>€
						</p>
					</div>
				</div>
			</div>

			<p>Detalle de compras:</p>

			<div class="w3-row w3-light-grey w3-border-top w3-border-bottom" style="width: 100%">
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>ID DE TICKET</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>COMPRADOR</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>Nº ENTRADAS</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>FECHA DE COMPRA</b>
					</p>
				</div>
			</div>

			<%
				for (int i = 0; i < purchases.size(); i++) {

						Purchase purchase = purchases.get(i);
						Usr client = purchase.getClient();
						LocalDateTime dateTime = purchase.getDate();
			%>

			<div class="w3-row w3-border-bottom" style="width: 100%">
				<div class="w3-container w3-quarter">
					<p><%=purchase.getId()%></p>
				</div>
				<div class="w3-container w3-quarter">
					<p><%=client.getName()%>
						<%=client.getSurname()%></p>
				</div>
				<div class="w3-container w3-quarter">
					<p><%=purchase.getTickets()%></p>
				</div>
				<div class="w3-container w3-quarter">
					<p><%=dateTime.toLocalDate()%></p>
				</div>
			</div>
			<%
				}
				}
			%>
		</div>
		<!-- End page content -->
	</div>

</body>
</html>

