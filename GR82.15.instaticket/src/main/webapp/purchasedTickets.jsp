<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.List, es.uc3m.tiw.domains.Purchase, es.uc3m.tiw.domains.Event"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<script src="/lib/jquery-3.2.1.min.js"></script>
<title>Cartera de entradas</title>

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
	<jsp:include page="sidebarLogged.jsp" />

	<!-- !PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-xlarge w3-container">
		<p class="w3-left">Cartera de entradas</p>
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

			No has comprado ninguna entrada todavía.
			<%
				} else {
			%>

			<p>A continuación puedes ver las entradas que has adquirido:</p>

			<div class="w3-row w3-light-grey w3-border-top w3-border-bottom" style="width: 100%">
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>ID DE TICKET</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>EVENTO</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>Nº ENTRADAS</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p></p>
				</div>
			</div>

			<%
				for (int i = 0; i < purchases.size(); i++) {

						Purchase purchase = purchases.get(i);
						Event event = purchase.getEvent();
			%>

			<div class="w3-row w3-border-bottom" style="width: 100%">
				<div class="w3-container w3-quarter">
					<p><%=purchase.getId()%></p>
				</div>
				<div class="w3-container w3-quarter">
					<p><%=event.getTitle()%></p>
				</div>
				<div class="w3-container w3-quarter">
					<p><%=purchase.getTickets()%></p>
				</div>
				<div class="w3-container w3-quarter w3-padding">
					<a href="event?id=<%=event.getId()%>" class="w3-border w3-button">Ver evento</a>
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

