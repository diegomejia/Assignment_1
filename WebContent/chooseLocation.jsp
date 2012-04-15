<%@page import="support.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide Degrees - Choose Location</title>
</head>
<body>
	<% 
   	support sup = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("countries.txt");
   	String path2 = config.getServletContext().getRealPath("universities.txt");
	
    //getCountries returns a vector of the countries to be used for choosing citizenship
    Vector countries = sup.getCountries(path1);    
    //getUniversities returns a vector of vectors where each vector is a tuple of <string, vector>
    //with the string being the name of the country/state and the vector being the list of universities there
    Vector universities = sup.getUniversities(path2);
	%>
	<table border="1">
		<tr>
			<th>Country</th>
		</tr>
		<tr>
			<%
				//Prints all the countries.
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

	<br>Number of states/countries with universities:
	<%=universities.size()%><br>
	
	<table border="1">
		<tr>
			<th>States</th>
		</tr>
		<tr>
			<%
				//Prints all the countries.
				for (int i = 0; i < universities.size(); i++) {
					//each entry in the universities vector is a tuple with the first entry being the country/state
					//and the second entry being a vector of the universities as String's
				      Vector tuple = (Vector)universities.get(i);
				      String state = (String)tuple.get(0);
					if (i % 3 == 0) {
			%>
		</tr>
		<tr>
			<td><a href="chooseUni.jsp?state=<%=state%>"><%=state%></a></td>
			<%
				} else {
			%>
			<td><a href="chooseUni.jsp?state=<%=state%>"><%=state%></a></td>
			<%
				}
				}
			%>
		</tr>
	</table>
<%	
  	//print all the universities by state/country
    /*
      for (int i=0; i<universities.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's
      Vector tuple = (Vector)universities.get(i);
      String state = (String)tuple.get(0);
      out.println("<br>"+state+"<br>");    
    } 
    */
%>
</body>
</html>