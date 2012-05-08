<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="support.*, java.util.*, org.postgresql.*"%>
<%@ page import="java.sql.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Specialization Analytics</title>
</head>
<body>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Vector<HashMap<String, Integer>> specializations = new Vector<HashMap<String, Integer>>();
	
try{
    // Registering Postgresql JDBC driver with the DriverManager
    Class.forName("org.postgresql.Driver");

    // Open a connection to the database using DriverManager
    conn = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/postgres?" +
        "user=postgres&password=dev");
    
    conn.setAutoCommit(false);
    
    pstmt = conn.prepareStatement(
    		"Select s2.s_id, s2.specialization, r2.count FROM specializations s2 LEFT JOIN (Select r.specialization_id, s.specialization, r.count from specializations s, (select specialization_id, count(*) from applications group by specialization_id) r WHERE s.s_id = r.specialization_id) r2 ON s2.specialization=r2.specialization"
       		);
    rs = pstmt.executeQuery();
        
    while(rs.next()){
   		String specialization = rs.getString("specialization");
   		Integer count = rs.getInt("count");
   		Integer specialization_id = rs.getInt("s_id");
   		if(count == null){
   			count = 0;
   		}
   		%>
   		<div><%= specialization %> : <a href="applications.jsp?specialization_id=<%= specialization_id %>"><%= count %></a></div>
   		
   		<%
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
%>



</body>
</html>