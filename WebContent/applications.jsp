<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="support.*, java.util.*, org.postgresql.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Applications</title>
</head>
<body>
<%
	
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

String specialization_id = request.getParameter("specialization_id");
String discipline_id = request.getParameter("discipline_id");

if(specialization_id!=null){
	pstmt = conn.prepareStatement(
			"SELECT a.first_name, a.middle_name, a.last_name, s.specialization FROM applications a, specializations s WHERE a.specialization_id = ? AND s.s_id=a.specialization_id"
			);
	pstmt.setInt(1, Integer.parseInt(specialization_id));
	rs = pstmt.executeQuery();
	boolean first = true;

	while(rs.next()){
   		String first_name = rs.getString("first_name");
   		String middle_name = rs.getString("middle_name");
   		String last_name = rs.getString("last_name");
   		if(first){
   			String specialization = rs.getString("specialization");
   			%>
   				<h1><%= specialization %></h1>
   			<%
   			first = false;
   		}
   		
   		%>
   			<div><%= first_name %> <%= middle_name %> <%= last_name %></div>   		
   		<%
   		
   	}

}
else if(discipline_id!=null){
	pstmt = conn.prepareStatement(
			"SELECT a.first_name, a.middle_name, a.last_name, m.major FROM applications a, majors m, degrees d WHERE m.m_id = ? AND m.m_id=d.major_id AND d.application_id = a.id"
			);
	pstmt.setInt(1, Integer.parseInt(discipline_id));
	rs = pstmt.executeQuery();
	boolean first = true;

	while(rs.next()){
   		String first_name = rs.getString("first_name");
   		String middle_name = rs.getString("middle_name");
   		String last_name = rs.getString("last_name");
   		if(first){
   			String discipline = rs.getString("major");
   			%>
   				<h1><%= discipline %></h1>
   			<%
   			first = false;
   		}
   		
   		%>
   			<div><%= first_name %> <%= middle_name %> <%= last_name %></div>   		
   		<%
   		
   	}

}
else{
	
	pstmt = conn.prepareStatement(
			"SELECT * FROM applications"
			);
	rs = pstmt.executeQuery();
	while(rs.next()){
   		String first_name = rs.getString("first_name");
   		String middle_name = rs.getString("middle_name");
   		String last_name = rs.getString("last_name");   		
   		%>
   			<div><%= first_name %> <%= middle_name %> <%= last_name %></div>   		
   		<%
   		
   	}
	
}

        
pstmt.close();
conn.commit();
conn.setAutoCommit(true);


// Close the Connection
conn.close();
}
catch(SQLException e){
 throw new RuntimeException(e);
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

%>

</body>
</html>