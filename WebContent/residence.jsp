<%@page import="support.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Country of Residence</title>
</head>
<body>
 <%
 	
       String first = (String) session.getAttribute("firstName");
       String mi = (String) session.getAttribute("middleInitial");
       String last = (String) session.getAttribute("lastName");
       String country = request.getParameter("country");
       session.setAttribute("citizenship", country);
       
       support s = new support();
       String countriesPath = config.getServletContext().getRealPath("countries.txt");
       Vector countries = s.getCountries(countriesPath);
    %>
    <div>
    	<%= "Hello " + first + " " + mi + " " + last  %>
    </div>
    <div>
    	WE KNOW WHERE YOU VOTE: <%= country %>.
    </div>
    <table border="1">
    	<a href="address.jsp?first=<%= first %>&mi=<%=mi %>&last=<%=last %>&country=<%= country %>&residence=<%= country %>">Country of Residence the same as citizenship? Click here.</a>
    	Otherwise, select from below:
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
      			</tr><tr><td><a href="address.jsp?first=<%= first %>&mi=<%=mi %>&last=<%=last %>&country=<%= country %>&residence=<%=c %>"><%= c %></a></td>
      		<%	} else {
      		%>
      			<td><a href="address.jsp?first=<%= first %>&mi=<%=mi %>&last=<%=last %>&country=<%= country %>&residence=<%=c %>"><%= c %></a></td>
      		 <% }
      		} %>
         </tr>
    </table>


</body>
</html>