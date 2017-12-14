<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="es.uc3m.tiw.domains.Usr, java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<script src="/lib/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<title>Comunicación con usuarios</title>
</head>

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
		<p class="w3-left">Comunicación con usuarios</p>
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

		<%if(request.getAttribute("noUsers") != null){ %>
		<div class="w3-container w3-center">
			<p>No hay usuarios que hayan creado eventos todavía</p>
		</div>
		<%}
		
		else {%>

		<div class="w3-container w3-center">
			<p>A continuación, los usuarios creadores de eventos con los que se puede comunicar:</p>

			<%List<Usr> users = (List<Usr>) request.getAttribute("users"); %>

			<%for(int i = 0; i < users.size();i++) {%>
			<div class="w3-row w3-border-bottom">
				<div class="w3-container w3-third">
					<p><%=users.get(i).getName()%>
						<%=users.get(i).getSurname()%></p>
				</div>
				<div class="w3-container w3-third">
					<p><%=users.get(i).getEmail()%></p>
				</div>
				<div class="w3-container w3-third">
					<form action="chat" method="post">
						<input type="hidden" name="userEmail" value="<%=users.get(i).getEmail()%>">
						<p>
							<button class="w3-btn w3-border">Ver conversación</button>
						<p>
					</form>
				</div>
			</div>
			<%} 
		}%>
		</div>

		<!-- End page content -->
	</div>

</body>
</html>