<%@page import="support.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Country of Residence</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <%
 	
       String first = (String) session.getAttribute("firstName");
       String mi = (String) session.getAttribute("middleInitial");
       String last = (String) session.getAttribute("lastName");
       String country = request.getParameter("country");
       session.setAttribute("citizenship", country);
       if(country.equals("United States")){
    	   session.setAttribute("domestic", true);
       }
       else{
    	   session.setAttribute("domestic", false);
       }
       
       support s = new support();
       String countriesPath = config.getServletContext().getRealPath("countries.txt");
       Vector countries = s.getCountries(countriesPath);
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
				<%= country %>
			</div>
		</div>
	</div>
	<div id="colRight">
	<div class="instructions">
		Please select your current country of residence.<br />
		If your country of residence is the same as your country of citizenship, <a href="address.jsp?residence=<%= country %>">click here.</a>
	</div>
    <table border="1">
    	<tr>
    		<th>Country</th>
    	</tr>
    	<tr>
    	<%
    		for (int i=0; i<countries.size(); i++){
      		//each entry in the universities vector is a tuple with the first entry being the country/state
      		//and the second entry being a vector of the universities as String's
      			String c = (String)countries.get(i);
      			if(i%3 == 0){
      			%>
      			</tr><tr><td><a href="address.jsp?residence=<%=c %>"><%= c %></a></td>
      		<%	} else {
      		%>
      			<td><a href="address.jsp?residence=<%=c %>"><%= c %></a></td>
      		 <% }
      		} %>
         </tr>
    </table>
</div>

</body>
</html>