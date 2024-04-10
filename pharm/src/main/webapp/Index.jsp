<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>

<%@include file="Header.jsp"%>

<%
	String alertMessage = (String) request.getAttribute("alertMessage");
%>
<div class="container">
	<h1>PHARMACIE MALAGASY</h1>
	<p class="lead">Connectez-vous</p>
	<%
		if (alertMessage == "erreur") {
	%>
	<div class='alert alert-danger'>
		Email et/ou mot de passe incorrect
		<button type='button' class='close' aria-label='Close'
			data-dismiss='alert'>
			<span aria-hidden='true'>&times; </span>
		</button>
	</div>
	
	<% } else if(alertMessage == " ") { %>
		<div class='alert alert-danger'>
		Veuillez entrez votre email et/ou mot de passe
		<button type='button' class='close' aria-label='Close'
			data-dismiss='alert'>
			<span aria-hidden='true'>&times; </span>
		</button>
	</div>
	<% } %>
	<form class="form-inline" action="index" method="post">

		<div class="form-group">
			<label for="login-username" class="sr-only">Email</label> <input
				type="text" class="form-control" id="login-email" name="email"
				placeholder="Email" value="">
		</div>
		<div class="form-group">
			<label for="login-passowrd" class="sr-only">Password</label> <input
				type="password" class="form-control" id="login-password"
				name="password" placeholder="Password">
		</div>

		<button type="submit" class="btn btn-primary" name="login">Connexion</button>
		<a href="#" type="button" class="btn btn-danger">Inscrivez-vous</a>

	</form>
</div>
<!-- #container --><!-- jQuery -->
	<script src="js/jquery-2.1.1.min.js"></script>
	<!-- Bootstrap JS -->
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>