<%@page import="support.*,java.util.*"%>
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
		Boolean loopFlag = (Boolean) session.getAttribute("loopFlag");
		if (loopFlag == null) {
			loopFlag = false;
		}
		session.setAttribute("loopFlag", loopFlag);

		String first = (String) session.getAttribute("firstName");
		String mi = (String) session.getAttribute("middleInitial");
		String last = (String) session.getAttribute("lastName");
		String citizenship = (String) session.getAttribute("citizenship");
		String residence = (String) session.getAttribute("residence");
		String streetAddress;
		String city;
		String state;
		String zipCode;
		String countryCode;
		String areaCode;
		String phoneNumber;

		if (!loopFlag) {
			streetAddress = request.getParameter("address");
			session.setAttribute("streetAddress", streetAddress);
			city = request.getParameter("city");
			session.setAttribute("city", city);
			state = request.getParameter("state");
			session.setAttribute("state", state);
			zipCode = request.getParameter("zip");
			session.setAttribute("zipCode", zipCode);
			countryCode = request.getParameter("countryCode");
			session.setAttribute("countryCode", countryCode);
			areaCode = request.getParameter("areaCode");
			session.setAttribute("areaCode", areaCode);
			phoneNumber = request.getParameter("number");
			session.setAttribute("phoneNumber", phoneNumber);
		} else {
			streetAddress = (String) session.getAttribute("address");
			city = (String) session.getAttribute("city");
			state = (String) session.getAttribute("state");
			zipCode = (String) session.getAttribute("zip");
			countryCode = (String) session.getAttribute("countryCode");
			areaCode = (String) session.getAttribute("areaCode");
			phoneNumber = (String) session.getAttribute("number");
			
		}

		Vector<HashMap<String, String>> degrees = (Vector<HashMap<String, String>>) session
				.getAttribute("degrees");
		if (degrees == null) {
			degrees = new Vector<HashMap<String, String>>();
		}

		Integer degreeIndex = (Integer) session.getAttribute("degreeIndex");
		if (degreeIndex == null) {
			degreeIndex = 0;
		} else {
			degreeIndex++;
		}

		degrees.addElement(new HashMap<String, String>());

		session.setAttribute("degrees", degrees);
		session.setAttribute("degreeIndex", degreeIndex);

		support sup = new support();

		String path1 = config.getServletContext().getRealPath(
				"countries.txt");
		String path2 = config.getServletContext().getRealPath(
				"universities.txt");

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
				<%=citizenship%>
			</div>
			<div class="applicationField">
				Residence:
				<%=residence%>
			</div>
			<%
				if (((Boolean) session.getAttribute("domestic"))) {
			%>
				<div class="applicationField">
					Domestic Applicant
				</div>
			<%
				}
			%>
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
			
			<%
							for (int i = 0; i < degrees.size() - 1; i++) {

								String univLocation = degrees.get(i).get("universityLocation");
								String univName = degrees.get(i).get("universityName");
								String disciplineName = degrees.get(i).get("disciplineName");
								String degreeMonth = degrees.get(i).get("month");
								String degreeYear = degrees.get(i).get("year");
								String degreeGPA = degrees.get(i).get("gpa");
								String degreeType = degrees.get(i).get("degreeType");
						%>
			<div class="degree">
				<div class="applicationField">
					University Location:
					<%=univLocation%>
				</div>
				<div class="applicationField">
					University Name:
					<%=univName%>
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
	<div class="instructions" style="margin-bottom: 20px">
		Please select the <a href="#countries">country</a> or <a href="#states">state within the United States</a> in which you have earned a degree.
	</div>
	<table border="1" id="countries" style="display: inline-block">
		<tr>
			<th>Countries</th>
		</tr>
		<tr>
			<%
				//Prints all the countries.
				for (int i = 51; i < universities.size(); i++) {
					//each entry in the universities vector is a tuple with the first entry being the country/state
					//and the second entry being a vector of the universities as String's
					Vector tuple = (Vector) universities.get(i);
					String s = (String) tuple.get(0);
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
	<table border="1" id="states" style="display: inline-block">
		<tr>
			<th>States</th>
		</tr>
		<tr>
			<%
				//Prints all the countries.
				for (int i = 0; i < 51; i++) {
					//each entry in the universities vector is a tuple with the first entry being the country/state
					//and the second entry being a vector of the universities as String's
					Vector tuple = (Vector) universities.get(i);
					String s = (String) tuple.get(0);
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