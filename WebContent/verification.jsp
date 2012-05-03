<%@page import="support.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<%
	Vector<HashMap<String,String>> degrees = (Vector<HashMap<String, String>>) session.getAttribute("degrees");
	Integer degreeIndex = (Integer) session.getAttribute("degreeIndex");
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
	
	String specialization = request.getParameter("specialization");
	session.setAttribute("specialization", specialization);

	session.setAttribute("degrees", degrees);
	
	support sup = new support();   	
   	String path1 = config.getServletContext().getRealPath("specializations.txt");
   	Vector specs = sup.getSpecializations(path1); 
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
				Specialization:
				<%=specialization%>
			</div>
			
			<%
				for(int i =0; i<degrees.size();i++){
					String oldUnivLocation = degrees.get(i).get("universityLocation");
				  	String oldUnivName = degrees.get(i).get("universityName");
				  	String oldDisciplineName = degrees.get(i).get("disciplineName");
					String oldDegreeMonth = degrees.get(i).get("month");
					String oldDegreeYear = degrees.get(i).get("year");
					String oldDegreeGPA = degrees.get(i).get("gpa");
					String oldDegreeType = degrees.get(i).get("degreeType");
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
					<%=oldDisciplineName%>
				</div>
				<div class="applicationField">
					Degree Month:
					<%=oldDegreeMonth%>
				</div>
				<div class="applicationField">
					Degree Year:
					<%=oldDegreeYear%>
				</div>
				<div class="applicationField">
					Degree GPA:
					<%=oldDegreeGPA%>
				</div>
				<div class="applicationField">
					Degree Type:
					<%=oldDegreeType%>
				</div>
			</div>
					<%					
				}
			%>
		</div>
	</div>
	<div class="colRight">
		<!-- form onSubmit="submitted">
			<input type="submit" value="Really Submit Application" />
		</form -->
		<button onclick="submitted()">Really Submit Application</button>
		<button id="doom">Cancel Application</button>
	</div>
	<script type="text/javascript">
		var doom = document.getElementById("doom");
		var infinitePopUps = function(){
			alert("You have cancelled your application.");
			//infinitePopUps();
		}
		var submitted = function(){
			alert("You have submitted your application.");
		}
		doom.onclick = infinitePopUps;
	</script>
</body>
</html>