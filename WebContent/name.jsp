<html>
<head>
<title>Graduate Application</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="colLeft">
	<h1>Welcome to the Graduate School Application</h1>
	<div class="instructions">
		Please provide your full name.
	</div>
	<div class="formWrapper">
		<form method="GET" action="citizenship.jsp">
			<div class="textInput">
				<label for="first">First Name: </label> 
				<INPUT type="text"
					name="first" value="" />
			</div>
			<div class="textInput">
				<label for="mi">Middle Initial: </label> 
				<INPUT type="text" name="mi"
					value="" size="1" maxlength="1" />
			</div>
			<div class="textInput">
				<label for="last">Last Name: </label> 
				<INPUT type="text" name="last"/>
			</div>
			<input type="submit" value="Next" />
		</form>
	</div>
</div>
</body>
</html>