<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="support.*, java.util.*, org.postgresql.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Discipline Analytics</title>
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
    
    pstmt = conn.prepareStatement(
    		"Select m2.m_id, m2.major, r2.count FROM majors m2 LEFT JOIN (Select r.major_id, m.major, r.count from majors m, (select major_id, count(*) from degrees group by major_id) r WHERE m.m_id = r.major_id) r2 ON m2.major=r2.major"
       		);
    rs = pstmt.executeQuery();
        
    while(rs.next()){
   		String major = rs.getString("major");
   		Integer count = rs.getInt("count");
   		Integer major_id = rs.getInt("m_id");
   		if(count == null){
   			count = 0;
   		}
   		%>
   		<div><%= major %> : <a href="applications.jsp?discipline_id=<%= major_id %>"><%= count %></a></div>
   		
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