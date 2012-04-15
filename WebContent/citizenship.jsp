<%@page import="support.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Country of Citizenship</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%
		String first = request.getParameter("first");
		session.setAttribute("firstName", first);
		String mi = request.getParameter("mi");
		session.setAttribute("middleInitial", mi);
		String last = request.getParameter("last");
		session.setAttribute("lastName", last);

		support s = new support();
		String countriesPath = config.getServletContext().getRealPath(
				"countries.txt");
		Vector countries = s.getCountries(countriesPath);
	%>
	<div id="colLeft">
		<div id="currentApplicationState">
			Your application so far
			<div class="applicationField">
				Name:
				<%=first + " " + mi + " " + last%>
			</div>
		</div>
	</div>
	<div id="colRight">
		<div class="instructions">Please select your country of
			citizenship. If you have dual or multiple citizenships, please select
			the country with which you most identify.</div>
		<table border="1">
			<tr>
				<th>Country</th>
			</tr>
			<tr>
				<%
					for (int i = 0; i < countries.size(); i++) {
						//each entry in the universities vector is a tuple with the first entry being the country/state
						//and the second entry being a vector of the universities as String's
						String c = (String) countries.get(i);
						if (i % 3 == 0) {
				%>
			</tr>
			<tr>
				<td><a href="residence.jsp?country=<%=c%>"><%=c%></a></td>
				<%
					} else {
				%>
				<td><a href="residence.jsp?country=<%=c%>"><%=c%></a></td>
				<%
					}
					}
				%>
			</tr>
		</table>
	</div>
</body>
</html>
