<%@ page import="support.*, java.util.*, org.postgresql.*"%>
<%@ page import="java.sql.*"%>
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
	String univLocation = degrees.get(degreeIndex).get("universityLocation");
  	String univName = degrees.get(degreeIndex).get("universityName");
  	
  	
  	String disciplineName = request.getParameter("disciplineName");
	degrees.get(degreeIndex).put("disciplineName", disciplineName);
	String degreeMonth = request.getParameter("month");
	degrees.get(degreeIndex).put("degreeMonth", degreeMonth);
	String degreeYear = request.getParameter("year");
	degrees.get(degreeIndex).put("degreeYear", degreeYear);
	String degreeGPA = request.getParameter("gpa");
	degrees.get(degreeIndex).put("degreeGPA", degreeGPA);
	String degreeType = request.getParameter("degreeType");
	degrees.get(degreeIndex).put("degreeType", degreeType);
	
	
	//Insert new major name into database
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try{
	        // Registering Postgresql JDBC driver with the DriverManager
	        Class.forName("org.postgresql.Driver");

	        // Open a connection to the database using DriverManager
	        conn = DriverManager.getConnection(
	            "jdbc:postgresql://localhost:5432/postgres?" +
	            "user=postgres&password=dev");
	        
	        conn.setAutoCommit(false);
	        
	       	pstmt = conn.prepareStatement(
	           		"INSERT INTO majors "+
	           		"(major) "+
	           		"values (?)"
	           		);
	       	pstmt.setString(1, disciplineName);
	        int rowsEffected = pstmt.executeUpdate();
	        if(rowsEffected < 1){
	        	throw new RuntimeException("No rows effected by insert");
	        }
	                
	        pstmt.close();
	        conn.commit();
	        conn.setAutoCommit(true);
	        
	        // Close the Connection
	        conn.close();
	    }
	    catch(SQLException e){
	    	//throw new RuntimeException(e);
	    }
	    finally {
	        // Release resources in a finally block in reverse-order of
	        // their creation

	        if (rs != null) {
	            try {
	                rs.close();
	            } catch (SQLException e) { } // Ignore
	            rs = null;
	        }
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) { } // Ignore
	            pstmt = null;
	        }
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (SQLException e) { } // Ignore
	            conn = null;
	        }
	    }
	  	

	session.setAttribute("degrees", degrees);
  	session.setAttribute("loopFlag", true);  	
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
			<%
				for(int i =0; i<degrees.size()-1;i++){
					String oldUnivLocation = degrees.get(i).get("universityLocation");
				  	String oldUnivName = degrees.get(i).get("universityName");
				  	String oldDisciplineName = degrees.get(i).get("disciplineName");
					String oldDegreeMonth = degrees.get(i).get("degreeMonth");
					String oldDegreeYear = degrees.get(i).get("degreeYear");
					String oldDegreeGPA = degrees.get(i).get("degreeGPA");
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
	<form action="chooseLocation.jsp">
		<input type="submit" value="Add Another Degree" />
	</form>
	<form action="specialization.jsp">
		<input type="submit" value="Done" />
	</form>
	</div>
	

</body>
</html>