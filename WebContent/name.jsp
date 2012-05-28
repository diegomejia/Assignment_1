<html>
<head>
<title>Graduate Application</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<script>
function validate() {
	  var fname=document.getElementById("fname").value;
	  var mname=document.getElementById("mname").value;
	  var lname=document.getElementById("lname").value;
	  var submitOK="true";
	  if (fname.match(/[^A-z]/g) != null)
	  { alert("The first name must only contain alphabetic characters");
	    submitOK="false"; }
	  if (mname.match(/[^A-z]/g) != null)
	  { alert("The middle name must only contain alphabetic characters");
	    submitOK="false"; }
	  if (lname.match(/[^A-z]/g) != null)
	  { alert("The last name must only contain alphabetic characters");
	    submitOK="false"; }
	  if (submitOK=="false") { return false; }
	}
</script>
<body>
<div id="colLeft">
	<h1>Welcome to the Graduate School Application</h1>
	<div class="instructions">
		Please provide your full name.
	</div>
	<div class="formWrapper">
		<form method="GET" action="citizenship.jsp" onsubmit="return validate()">
			<div class="textInput">
				<label for="first">First Name: </label> 
				<INPUT type="text"
					name="first" value="" id="fname" />
			</div>
			<div class="textInput">
				<label for="mi">Middle Initial: </label> 
				<INPUT type="text" name="mi"
					value="" size="1" maxlength="1" id="mname"/>
			</div>
			<div class="textInput">
				<label for="last">Last Name: </label> 
				<INPUT type="text" name="last" id="lname"/>
			</div>
			<input type="submit" value="Next" />
		</form>
	</div>
</div>
</body>
</html>
