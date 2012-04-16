<%@page import="support.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide Degree - Choose University</title>
</head>
<body>
	<% 
   	support sup = new support();   	
   	String path2 = config.getServletContext().getRealPath("universities.txt");
   	
    //getUniversities returns a vector of vectors where each vector is a tuple of <string, vector>
    //with the string being the name of the country/state and the vector being the list of universities there
    Vector universities = sup.getUniversities(path2);
    String location = (String) session.getAttribute("location");
    
  	//each entry in the universities vector is a tuple with the first entry being the country/state
    //and the second entry being a vector of the universities as String's
    Vector tuple = (Vector)universities.get(0);
    int indexOfState = tuple.indexOf(location);
    out.println("<br>"+indexOfState+"<br>");    
          Vector u = (Vector)tuple.get(1);
          for(int j=0; j<u.size(); j++){ %>
            <%= u.get(j)%>
    <br>
          <% }
          %>
</body>
</html>