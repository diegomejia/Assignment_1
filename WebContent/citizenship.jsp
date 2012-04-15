<%@page import="support.*, java.util.*" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Country of Citizenship</title>
  </head>
  <body>
    <%
       String first = request.getParameter("first");
       String mi = request.getParameter("mi");
       String last = request.getParameter("last");
       
       support s = new support();
       Vector countries = s.getCountries("C:/Users/Dieg/workspace/Counter/WebContent/countries.txt");
    %>
    <div>
    	<%= "Hello " + first + " " + mi + " " + last %>
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
      			</tr><tr><td><a href="countryOfResidence.jsp?first=<%= first %>&mi=<%=mi %>&last=<%=last %>&country=<%= c %>"><%= c %></a></td>
      		<%	} else {
      		%>
      			<td><a href="countryOfResidence.jsp?first=<%= first %>&mi=<%=mi %>&last=<%=last %>&country=<%= c %>"><%= c %></a></td>
      		 <% }
      		} %>
         </tr>
    </table>
  </body>
</html>
