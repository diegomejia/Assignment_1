<%@page import="support.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide Degrees - Choose Discipline</title>
</head>
<body>
	<% 
  	String univLocation = (String) request.getParameter("univLocation");
  	session.setAttribute("univLocation", univLocation);
   	support s = new support();   	
	
   	String path4 = config.getServletContext().getRealPath("specializations.txt");

   	
    Vector specializations = s.getSpecializations(path4);%>
     <form action="chooseDiscipline.jsp">
     <div class="radioGroup">
    	<label for="disciplines">Select a Discipline: </label><br /><%
    	for(int j=0; j<specializations.size(); j++){%>
   			<div class="radioInput">
   				<input type="radio" name="specializations" value="<%=specializations.get(j)%>" /> <%=specializations.get(j)%>
   			</div> 
    <%}%>
    </div>
  <div class="textInput">
  <label for="specializationName">Or input a specialization: </label>
  <input type="text" name="specializationName" />
  </div>
  <input type="submit" value="Submit" />
  </form>
</body>
</html>