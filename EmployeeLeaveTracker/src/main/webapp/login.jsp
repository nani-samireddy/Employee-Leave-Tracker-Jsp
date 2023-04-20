<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>



</head>

<style>
body {
	background-color: #21618c;
	font-family: sans-serif;
	align-items: center;
	justify-content: center;
	display: flex;
}

.container {
	position: relative;
	margin-top: 100px;
	width: 440px;
	height: auto;
	background: #dedede;
	border-radius: 5px;
	margin-left: 100px;
}

.label1 {
	padding: 20px 130px;
	font-size: 35px;
	font-weight: bold;
	color: #130f40;
	text-align: center;
}

.login_form {
	padding: 20px 40px;
}

.login_form .font {
	font-size: 18px;
	color: #130f40;
	margin: 5px 0;
}

.login_form input {
	height: 40px;
	width: 350px;
	padding: 0 5px;
	outline: none;
	border: 1px solid silver;
}

.login_form .font2 {
	margin-top: 30px;
}

.login_form button {
	margin: 45px 0 30px 0;
	height: 45px;
	width: 365px;
	font-size: 20px;
	color: white;
	outline: none;
	cursor: pointer;
	font-weight: bold;
	background: #2471A3;
	border-radius: 3px;
	border: 1px solid #3949AB;
	transition: .5s;
}

.login_form button:hover {
	background: #1A5276;
}

.login_form #email_error, .login_form #pass_error {
	margin-top: 5px;
	width: 345px;
	font-size: 18px;
	color: #C62828;
	background: rgba(255, 0, 0, 0.1);
	text-align: center;
	padding: 5px 8px;
	border-radius: 3px;
	border: 1px solid #EF9A9A;
	display: none;
}
</style>

<body>

	<div class="container">
		<h1 class="label1">LOGIN</h1>
		<form class="login_form" method="post" name="form"
			onsubmit="return validated()">
			<div class="font">Email</div>
			<input type="text" name="">
			<div id="email_error">Please fill up your Email</div>
			<div class="font2">Password</div>
			<input type="password" name="">
			<div id="pass_error">Please fill your Password</div>
			<button type="submit">Login</button>
		</form>
	</div>
	
<script>
  var email = document.forms['form']['email'];
  var password = document.forms['form']['password'];
  
  var email_error = document.getElementById('email_error');
  var pass_error = document.getElementById('pass_error');
  
  function validated(){
	  if (email.value.length < 9){
		  email.style.border = "1px solid red";
		  email_error.style.display = "block";
		  email.focus();
		  return false; 
	  }
	  if (password.value.length < 9){
		  password.style.border = "1px solid red";
		  pass_error.style.display = "block";
		  password.focus();
		  return false;
  }
  }
  </script>
</body>


</html>