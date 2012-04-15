<%@page import="support.*,java.util.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Address</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<%
		String first = (String) session.getAttribute("firstName");
		String mi = (String) session.getAttribute("middleInitial");
		String last = (String) session.getAttribute("lastName");
		String citizenship = (String) session.getAttribute("citizenship");
		String residence = request.getParameter("residence");
		session.setAttribute("residence", residence);
		

		support s = new support();
	%>
	<div id="colLeft">
		<div id="currentApplicationState">
			Your application so far
			<div class="applicationField">
				Name:
				<%=first + " " + mi + " " + last%>
			</div>
			<div class="applicationField">
				Citizenship:
				<%= citizenship %>
			</div>
			<div class="applicationField">
				Residence:
				<%= residence %>
			</div>
		</div>
	</div>
    <div id="colRight">
    <div class="instructions">
    	Please enter your address information.
    </div>
    <form method="post" action="chooseLocation.jsp">
    	<div>
    	<label for="address">Street Address</label>
    	<input type="text" name="address" />
    	</div>
    	<div>
    	<label for="city">City</label>
    	<input type="text" name="city" />
    	</div>
    	<%
    		if (residence.equals("United States")) {
    	%>
    	<div>
    	<label for="state">State</label>
    	<input size="2" maxlength="2" type="text" name="state" />
    	</div>
    	<div>
    	<label for="zip">Zip Code</label>
    	<input size="5" maxlength="5" type="text" name="zip" />
    	</div>
    	<%
    		} else {
    	%>
    	<div>
    	<label for="countryCode">Country Code</label>
    	<input size="10" maxlength="10" type="text" name="countryCode" />
    	</div>
    	<%
    		}
    	%>
    	<div>
    	<label for="areacode">Area Code</label>
    	<input size="4" maxlength="4" type="text" name="areacode" />
    	<label for="number">Number</label>
    	<input  size="7" maxlength="7" type="text" name="number" />
    	</div>
    	<input type="hidden" name="first" value="<%=first%>" />
    	<div>
    		<input type="submit" value="Submit" />
    	</div>
    </form>
</div>
</body>
</html>