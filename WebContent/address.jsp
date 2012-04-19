<%@page import="support.*,java.util.*"%>

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
		if(residence=="United States"){
	    	session.setAttribute("domestic", true);
	    }
		

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
			Please enter your address and telephone information.
		</div>
		<form method="post" action="chooseLocation.jsp">
			<div>
				<label for="address">Street Address</label> <input type="text"
					name="address" />
			</div>
			<div>
				<label for="city">City</label> <input type="text" name="city" />
			</div>
			<%
    		if (residence.equals("United States")) {
    	%>
			<div>
				<label for="state">State</label> <input size="2" maxlength="2"
					type="text" name="state" />
			</div>
			<div>
				<label for="zip">Zip Code</label> <input size="5" maxlength="5"
					type="text" name="zip" />
			</div>
			<div>
				<label>Phone Number</label>
			</div>
			<%
    		} else {
    	%>
			<div>
				<label>Phone Number</label>
			</div>
			<span>
				<label for="countryCode">Country Code</label> <input size="5"
					maxlength="5" type="text" name="countryCode" />
			</span>
			<%
    		}
    	%>
			<span>
				<label for="areacode">Area Code</label> <input size="4"
					maxlength="4" type="text" name="areaCode" /> <label for="number">Number</label>
				<input size="7" maxlength="7" type="text" name="number" />
			</span>
			<div>
				<input type="submit" value="Submit" />
			</div>
		</form>
	</div>
</body>
</html>