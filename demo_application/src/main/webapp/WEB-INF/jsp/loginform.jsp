<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns:mso="urn:schemas-microsoft-com:office:office"
 xmlns:msdt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882">
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/static/css/style.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<!------ Include the above in your HEAD tag ---------->

<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <img src="/resources/static/images/login.png" id="icon" alt="User Icon" />
    </div>
	<h1>Login</h1>
	<form method="post" action="/checklogin" modelAttibute="command">
	      <input type="text" id="account" class="fadeIn second" name="account" placeholder="account">
	      <input type="text" id="password" class="fadeIn third" name="password" placeholder="password">
	      <input type="submit" class="fadeIn fourth" value="Login">
    </form>
     <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="underlineHover" href="#">Forgot Password?</a>
    </div>
  </div>
  	<c:if test="${not empty errorMessage}">
   	 	<div class="alert alert-danger" role="alert">${errorMessage}</div>
	</c:if>
	<c:if test="${not empty successMessage}">
	    <div class="alert alert-success" role="alert">${successMessage}</div>
	</c:if>

</div>
	
</body>
</html>