<%@page import="support.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide Degrees - Choose Location</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<% 
	
	String first = (String) session.getAttribute("firstName");
	String mi = (String) session.getAttribute("middleInitial");
	String last = (String) session.getAttribute("lastName");
	String citizenship = (String) session.getAttribute("citizenship");
	String residence = (String) session.getAttribute("residence");
	
	String streetAddress = request.getParameter("address");
	session.setAttribute("streetAddress", streetAddress);
	String city =  request.getParameter("city");
	session.setAttribute("city", city);
	String state =  request.getParameter("state");
	session.setAttribute("state", state);
	String zipCode =  request.getParameter("zip");
	session.setAttribute("zipCode", zipCode);
	String countryCode =  request.getParameter("countryCode");
	session.setAttribute("countryCode", countryCode);
	String areaCode =  request.getParameter("areaCode");
	session.setAttribute("areaCode", areaCode);
	String phoneNumber =  request.getParameter("number");
	session.setAttribute("phoneNumber", phoneNumber);
	
   	support sup = new support();   	
   	
   	String path1 = config.getServletContext().getRealPath("countries.txt");
   	String path2 = config.getServletContext().getRealPath("universities.txt");
	
    //getCountries returns a vector of the countries to be used for choosing citizenship
    Vector countries = sup.getCountries(path1);    
    //getUniversities returns a vector of vectors where each vector is a tuple of <string, vector>
    //with the string being the name of the country/state and the vector being the list of universities there
    Vector universities = sup.getUniversities(path2);
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
			<div class="applicationField">
				Street Address:
				<%= streetAddress %>
			</div>
			<div class="applicationField">
				City:
				<%= city %>
			</div>
			<div class="applicationField">
				State:
				<%= state %>
			</div>
			<div class="applicationField">
				Zip Code:
				<%= zipCode %>
			</div>
			<div class="applicationField">
				Phone Number:
				<%= "+" + countryCode + "-" + areaCode + "-" + phoneNumber %>
			</div>
		</div>
	</div>
	<div id="colRight">
	<div class="instructions">
		Please select the <a href="#countries">country</a> or <a href="#states">state within the United States</a> in which you have earned a degree.
	</div>
	<table border="1" id="countries">
		<tr>
			<th>Country</th>
		</tr>
		<tr>
			<%
				//Prints all the countries.
				int p = 0;
				for (int i = 0; i < countries.size(); i++) {
					//each entry in the universities vector is a tuple with the first entry being the country/state
					//and the second entry being a vector of the universities as String's
					String c = (String) countries.get(i);
					p++;
					if (countries.get(i).toString().equals("United States")){
						p--;
						continue;
					}
					if (p % 3 == 0) {
			%>
		</tr>
		<tr>
			<td><a href="chooseUni.jsp?location=<%=c%>"><%=c%></a></td>
			<%
				} else {
			%>
			<td><a href="chooseUni.jsp?location=<%=c%>"><%=c%></a></td>
			<%
				}
				}
			%>
		</tr>
	</table>

	
	<table border="1" id="states">
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
				      String s = (String)tuple.get(0);
					if (i % 3 == 0) {
			%>
		</tr>
		<tr>
			<td><a href="chooseUni.jsp?location=<%=s%>"><%=s%></a></td>
			<%
				} else {
			%>
			<td><a href="chooseUni.jsp?location=<%=s%>"><%=s%></a></td>
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
</div>
</body>
</html>