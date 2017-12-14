<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="es.uc3m.tiw.domains.Usr, java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/css/w3.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/css/fonts.css">
<link rel="stylesheet" href="/css/font-awesome-4.7.0/css/font-awesome.min.css">
<title>Gestión de usuarios</title>
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

	<!-- PAGE CONTENT -->
	<div class="w3-main" style="margin-left: 250px">

		<!-- Top header -->
		<header class="w3-container w3-xlarge">
		<p class="w3-left">Gestión de usuarios</p>
		<form action="search" method="post">
			<p class="w3-right">
				<input type="hidden" name="type" value="simple">
				<input class="w3-border" type="text" name="search" style="padding: 8px; font-size: 15px; float: left"
					placeholder="Buscar..." required>
				<button class="w3-bar-item w3-button w3-hover-grey" type="submit">
					<i class="fa fa-search"></i>
				</button>
			</p>
		</form>
		</header>

		<!-- Se muestran todos los usuarios activos -->
		<div class="w3-container w3-center">

			<%
				List<Usr> users = (List<Usr>) request.getAttribute("users");

				if (users.isEmpty()) {
			%>

					No hay ningún usuario todavía.
			<%
				} else {
			%>

			<%
				for (int i = 0; i < users.size(); i++) {
						Usr user = users.get(i);
			%>
			<div class="w3-row w3-border w3-section">
				<div class="w3-container w3-half">
					&nbsp;
					<p>
						<b>Nombre y apellidos: </b><%=user.getName()%>
						<%=user.getSurname()%></p>
					<p>
						<b>Correo electrónico: </b><%=user.getEmail()%></p>
				</div>
				<div class="w3-container w3-half">
					<form method="post" action="editUser">
						<input type="hidden" name="type" value="userToEdit">
						<input type="hidden" name="email" value="<%=user.getEmail()%>">
						<p>
							<button class="w3-button w3-border" style="width: 50%">Modificar datos</button>
						</p>
					</form>

					<form method="post" action="deleteUser">
						<input type="hidden" name="type" value="userToDelete">
						<input type="hidden" name="email" value="<%=user.getEmail()%>">
						<p>
							<button class="w3-button w3-hover-red w3-border" style="width: 50%">Dar de baja</button>
						</p>
					</form>
				</div>
			</div>
			<%
				}
			%>

		</div>

		<%
			}
		%>
		<!-- End page content -->
	</div>

</body>
</html>