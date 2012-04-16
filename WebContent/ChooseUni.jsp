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
  	String location = (String) request.getParameter("location");
  	session.setAttribute("univLocation", location);
   	support s = new support();   	
   	
   	String path2 = config.getServletContext().getRealPath("universities.txt");
 
    //getUniversities returns a vector of vectors where each vector is a tuple of <string, vector>
    //with the string being the name of the country-state and the vector being the list of universities there
    Vector universities = s.getUniversities(path2);
    Vector u = null;
    for (int i=0; i<universities.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's
      Vector tuple = (Vector)universities.get(i);
      String state = (String)tuple.get(0);
      //out.println("<br>"+tuple.get(1)+"<br>");    
            if(state.equals(location)){
            	u = (Vector)tuple.get(1);
            	break;
            }
     }%>
     <form action="chooseDiscipline.jsp">
     <%
    if(u!=null){
    	%><div class="radioGroup">
    	<label for="universities">Select a University: </label><br /><%
    	for(int j=0; j<u.size(); j++){%>
   			<div class="radioInput">
   				<input type="radio" name="universities" value="<%=u.get(j)%>" /> <%=u.get(j)%>
   			</div> 
    <%}%>
    </div>
  <%}%>
  <div class="textInput">
  <% if(u!=null){ %>
  <label for="universityName">Or specify another University: </label>
  <% }else{ %>
    <label for="universityName">Please specify the University Name: </label>
  <% } %>
  <input type="text" name="universityName" />
  </div>
  <input type="submit" value="Submit" />
  </form>
</body>
</html>