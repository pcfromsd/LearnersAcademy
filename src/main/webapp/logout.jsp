<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Thank you!</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<b>
		<h1>Thanks for visiting our website, Will see you soon!</h1>
		<a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a>
</body>
</html>
