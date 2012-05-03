<%@page import="support.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide Degrees - Choose Discipline</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<% 
	Integer degreeIndex = (Integer) session.getAttribute("degreeIndex");
	Vector<HashMap<String,String>> degrees = (Vector<HashMap<String, String>>) session.getAttribute("degrees");

	String first = (String) session.getAttribute("firstName");
	String mi = (String) session.getAttribute("middleInitial");
	String last = (String) session.getAttribute("lastName");
	String citizenship = (String) session.getAttribute("citizenship");
	String residence = (String) session.getAttribute("residence");
	if(residence.equals("United States") || citizenship.equals("United States")){
		
	}
	String streetAddress = (String) session.getAttribute("address");
	String city = (String) session.getAttribute("city");
	String state = (String) session.getAttribute("state");
	String zipCode = (String) session.getAttribute("zip");
	String countryCode = (String) session.getAttribute("countryCode");
	if(countryCode == null){
		countryCode = "1";
	}
	String areaCode = (String) session.getAttribute("areaCode");
	String phoneNumber = (String) session.getAttribute("number");
	String univLocation = degrees.get(degreeIndex).get("universityLocation");
	
	String univName = (String) request.getParameter("universityName");
	degrees.get(degreeIndex).put("universityName", univName);
	session.setAttribute("degrees", degrees);
  	
   	support s = new support();   	
	
   	String path3 = config.getServletContext().getRealPath("majors.txt");

   	
  	//getMajors and getSpecializations return vectors
    Vector majors = s.getMajors(path3);%>
    
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
			<%if(((Boolean) session.getAttribute("domestic"))){%>
				<div class="applicationField">
					Domestic Applicant
				</div>
			<% } %>
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
				<%=univLocation%>
			</div>
			<div class="applicationField">
				University Name:
				<%=univName%>
			</div>
			
			<%
				for(int i =0; i<degrees.size()-1;i++){
					
					String oldUnivLocation = degrees.get(i).get("universityLocation");
				  	String oldUnivName = degrees.get(i).get("universityName");
				  	String disciplineName = degrees.get(i).get("disciplineName");
					String degreeMonth = degrees.get(i).get("month");
					String degreeYear = degrees.get(i).get("year");
					String degreeGPA = degrees.get(i).get("gpa");
					String degreeType = degrees.get(i).get("degreeType");
					%>
			<div class="degree">
				<div class="applicationField">
					University Location:
					<%=oldUnivLocation%>
				</div>
				<div class="applicationField">
					University Name:
					<%=oldUnivName%>
				</div>
				<div class="applicationField">
					Discipline Name:
					<%=disciplineName%>
				</div>
				<div class="applicationField">
					Degree Month:
					<%=degreeMonth%>
				</div>
				<div class="applicationField">
					Degree Year:
					<%=degreeYear%>
				</div>
				<div class="applicationField">
					Degree GPA:
					<%=degreeGPA%>
				</div>
				<div class="applicationField">
					Degree Type:
					<%=degreeType%>
				</div>
			</div>
					<%					
				}
			%>
		</div>
	</div>
	<div id="colRight">
     <form action="moreDegrees.jsp">
     <div class="radioGroup">
    	<label for="disciplines">Select a Discipline: </label><br /><%
    	for(int j=0; j<majors.size(); j++){%>
   			<div class="radioInput">
   				<input type="radio" name="disciplineName" value="<%=majors.get(j)%>" /> <%=majors.get(j)%>
   			</div> 
    <%}%>
    </div>
  <div class="textInput">
  <label for="disciplineName">Or input a discipline: </label>
  <input type="text" name="disciplineName" />
  </div>
  <div class="textInput">
				<label for="month">Month: </label> 
				<INPUT type="text"
					name="month" value="" />
			</div>
			<div class="textInput">
				<label for="year">Year: </label> 
				<INPUT type="text" name="year"
					value="" size="4" maxlength="4" />
			</div>
			<div class="textInput">
				<label for="gpa">GPA: </label> 
				<INPUT type="text" name="gpa"
					value="" size="5" maxlength="5" />
			</div>
			<div>
			<select name="degreeType">
				<option value="ba">B.A.</option>
				<option value="bs">B.S.</option>
				<option value="ma">M.A.</option>
				<option value="ms">M.S.</option>
				<option value="phd">PhD</option>
			</select>
			</div>
  <input type="submit" value="Submit" />
  </form>
  </div>
</body>
</html>