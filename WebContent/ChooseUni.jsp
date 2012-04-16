<%@page import="support.*,java.util.*, java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide Degree - Choose University</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<%
		String first = (String) session.getAttribute("firstName");
		String mi = (String) session.getAttribute("middleInitial");
		String last = (String) session.getAttribute("lastName");
		String citizenship = (String) session.getAttribute("citizenship");
		String residence = (String) session.getAttribute("residence");
		String streetAddress = (String) session.getAttribute("address");
		String city = (String) session.getAttribute("city");
		String state = (String) session.getAttribute("state");
		String zipCode = (String) session.getAttribute("zip");
		String countryCode = (String) session.getAttribute("countryCode");
		String areaCode = (String) session.getAttribute("areaCode");
		String phoneNumber = (String) session.getAttribute("number");

		String location = (String) request.getParameter("location");
		session.setAttribute("universityLocation", location);

		support s = new support();
		String path2 = config.getServletContext().getRealPath(
				"universities.txt");

		//getUniversities returns a vector of vectors where each vector is a tuple of <string, vector>
		//with the string being the name of the country-state and the vector being the list of universities there
		Vector universities = s.getUniversities(path2);
		Vector u = null;
		for (int i = 0; i < universities.size(); i++) {
			//each entry in the universities vector is a tuple with the first entry being the country/state
			//and the second entry being a vector of the universities as String's
			Vector tuple = (Vector) universities.get(i);
			String univState = (String) tuple.get(0);
			//out.println("<br>"+tuple.get(1)+"<br>");    
			if (univState.equals(location)) {
				u = (Vector) tuple.get(1);
				break;
			}
		}
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
				<%=citizenship%>
			</div>
			<div class="applicationField">
				Residence:
				<%=residence%>
			</div>
			<div class="applicationField">
				Street Address:
				<%=streetAddress%>
			</div>
			<div class="applicationField">
				City:
				<%=city%>
			</div>
			<div class="applicationField">
				State:
				<%=state%>
			</div>
			<div class="applicationField">
				Zip Code:
				<%=zipCode%>
			</div>
			<div class="applicationField">
				Phone Number:
				<%="+" + countryCode + "-" + areaCode + "-" + phoneNumber%>
			</div>
			<div class="applicationField">
				University Location:
				<%=location%>
			</div>
		</div>
	</div>
	<div id="colRight">
	<div class="instructions">
		Please specify the university where you earned this degree.
	</div>
		<form action="chooseDiscipline.jsp">
			<%
				if (u != null) {
			%>
			<table border="1" id="countries">
				<tr>
					<th>Country</th>
				</tr>
				<tr>
					<%
						for (int j = 0; j < u.size(); j++) {
							String university = (String) u.get(j);
							String universityEncoded = URLEncoder.encode(university);
								if (j % 3 == 0) {
					%>
				</tr>
				<tr>
					<td><a href="chooseDiscipline.jsp?universityName=<%= universityEncoded %>"> <%= university %> </a></td>
					<%
						} else {
					%>
					<td><a href="chooseDiscipline.jsp?universityName=<%= universityEncoded %>"><%= university %></a></td>
					<%
							}
						}
					%>
				</tr>
			</table>
	<%
		}
	%>
	<div class="textInput">
		<%
			if (u != null) {
		%>
		<label for="universityName">Or specify another University: </label>
		<%
			} else {
		%>
		<label for="universityName">University
			Name: </label>
		<%
			}
		%>
		<input type="text" name="universityName" />
	</div>
	<input type="submit" value="Submit" />
	</form>
	</div>
</body>
</html>