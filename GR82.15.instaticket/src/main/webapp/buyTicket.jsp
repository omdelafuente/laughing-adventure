<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="es.uc3m.tiw.domains.Event"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<script src="/lib/jquery-3.2.1.min.js"></script>
<title>Comprar entrada</title>

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
		<p class="w3-left">Comprar entrada</p>
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

		<% Event event = (Event)request.getAttribute("event");%>

		<div class="w3-container w3-center">

			<div class="w3-row w3-light-grey w3-border-top w3-border-bottom" style="width: 100%">
				<div class="w3-container w3-half">
					<p class="w3-text-grey">
						<b>ENTRADA</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>PRECIO</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p class="w3-text-grey">
						<b>UNIDADES</b>
					</p>
				</div>
			</div>

			<div class="w3-row w3-border-bottom" style="width: 100%">
				<div class="w3-container w3-half">
					<p><%=event.getTitle()%></p>
				</div>
				<div class="w3-container w3-quarter">
					<p><%=event.getPrice()%>€
					</p>
				</div>
				<div class="w3-container w3-quarter w3-padding">
					<input type="number" id="numberOfTickets" min="1" value="1" style="text-align: center; max-width: 50%">
				</div>
			</div>
			<div class="w3-row" style="width: 100%">
				<div class="w3-container w3-half">&nbsp;</div>
				<div class="w3-container w3-quarter">
					<p>
						<b>TOTAL(€)</b>
					</p>
				</div>
				<div class="w3-container w3-quarter">
					<p id="total"><%=event.getPrice()%></p>
				</div>
			</div>
			
			<!-- Modificación dinámica del precio total con JQuery -->
			<script>
				var price = <%=event.getPrice()%>;
				$("#numberOfTickets").change(function() {
					var total =  $("#numberOfTickets").val();
					var num = (total*price).toFixed(2);
					$("#total").html(num);
					$("#ccTickets").val($("#numberOfTickets").val());			
				});
			</script>

			<% if((Boolean)request.getAttribute("purchaseSuccess") != null) {
			if((Boolean)request.getAttribute("purchaseSuccess") == false) { %>
			<div class="w3-panel w3-red w3-card-4">
				<% if(request.getAttribute("transactionFailed") == null){%>
					<p>No puedes comprar más entradas de las que hay disponibles.</p>
				<%} 
				else {%>
					<p>Error al hacer el pago: <%=request.getAttribute("transactionFailed")%></p>
				<%} %>
			</div>
			<%} }%>

			<div class="w3-row w3-padding-16" style="width: 100%">
				<a href="javascript:history.back()" class="w3-btn w3-white w3-border w3-left">Cancelar compra</a> <a id="checkout"
					class="w3-btn w3-white w3-border w3-right w3-border-green">Continuar</a>
			</div>


		</div>

		<!-- Selección del método de pago -->
		<div class="w3-container w3-center" id="payment" style="display: none">
			<p>
				<b>Método de pago</b>
			</p>		
			<form method="post" id="creditCardForm" action="buyTicket">
				<input type="hidden" name="tickets" id="ccTickets">
				<input type="hidden" name="id" value="<%=event.getId()%>">
				<input type="hidden" name="buy">
				<div class="w3-row-padding w3-padding-16">
					<label><b>Número de la tarjeta de crédito</b></label><br>
					<input class="w3-input w3-border w3-light-grey" name="cc" type="text" style="width: 50%; display: inline-block;"
						required>
				</div>
				<div class="w3-row-padding w3-padding-16">
					<div class="w3-quarter">&nbsp;</div>
					<div class="w3-quarter">
						<label><b>Código CV</b></label>
						<input class="w3-input w3-border w3-light-grey" name="cvc" type="text" pattern="^[0-9]{3,4}$" required>
					</div>
					<div class="w3-quarter">
						<label><b>Fecha de expiración</b></label>
						<input class="w3-input w3-border w3-light-grey" name="date" type="date" required>
					</div>
				</div>
				<div class="w3-row w3-padding-16">
					<button class="w3-btn w3-green w3-border" type="submit">Finalizar compra</button>
				</div>
			</form>
			

		</div>
		<!-- End page content -->
	</div>

	<script>

$( document ).ready(function() {
	
	$("#ccTickets").val($("#numberOfTickets").val());
	$("#paypalTickets").val($("#numberOfTickets").val());
    
	$("#checkout").click(function() {
		$("#payment").show();
	});
	
});

</script>

</body>
</html>

