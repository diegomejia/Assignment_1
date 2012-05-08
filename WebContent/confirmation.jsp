<%@ page import="support.*, java.util.*, org.postgresql.*"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
		Boolean domestic = (Boolean) session.getAttribute("domestic");
		String streetAddress = (String) session.getAttribute("address");
		String city = (String) session.getAttribute("city");
		String state = (String) session.getAttribute("state");
		String zipCode = (String) session.getAttribute("zip");
		String countryCode = (String) session.getAttribute("countryCode");
		String areaCode = (String) session.getAttribute("areaCode");
		String phoneNumber = (String) session.getAttribute("number");
		String specialization = (String) session.getAttribute("specialization");
		
		//Insert new university name into database
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    Vector<String> majors = new Vector<String>();
	    Integer application_id = null;
	    try{
	        // Registering Postgresql JDBC driver with the DriverManager
	        Class.forName("org.postgresql.Driver");

	        // Open a connection to the database using DriverManager
	        conn = DriverManager.getConnection(
	            "jdbc:postgresql://localhost:5432/postgres?" +
	            "user=postgres&password=dev");
	        
	        conn.setAutoCommit(false);
	        
	        Integer citizenship_id = null;
	        Integer residence_id = null;
	        Integer specialization_id = null;
	        
	        pstmt = conn.prepareStatement(
	        		"SELECT c_id "+
	        		"FROM countries "+
	        		"WHERE country=?"
	        		);
	        pstmt.setString(1, citizenship);
	        rs = pstmt.executeQuery();
	        rs.next();
	        citizenship_id = rs.getInt("c_id");
	        
	        pstmt = conn.prepareStatement(
	        		"SELECT c_id "+
	        		"FROM countries "+
	        		"WHERE country=?"
	        		);
	        pstmt.setString(1, residence);
	        rs = pstmt.executeQuery();
	        rs.next();
	        residence_id = rs.getInt("c_id");
	        
	        pstmt = conn.prepareStatement(
	        		"SELECT s_id "+
	        		"FROM specializations "+
	        		"WHERE specialization=?"
	        		);
	        pstmt.setString(1, specialization);
	        rs = pstmt.executeQuery();
	        rs.next();
	        specialization_id = rs.getInt("s_id");
	        
	       	pstmt = conn.prepareStatement(
	           		"INSERT INTO applications "+
	       			"(first_name, middle_name, last_name, domestic, address, city, us_state, zipcode, country_code, area_code, phone_number, citizenship_id, residence_id, specialization_id) "+
	           		"VALUES "+
	       			"(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
	           		);
	        pstmt.setString(1, first);
	        pstmt.setString(2, mi);
	        pstmt.setString(3, last);
	        pstmt.setBoolean(4, domestic);
	        pstmt.setString(5, streetAddress);
	        pstmt.setString(6, city);
	        pstmt.setString(7, state);
	        pstmt.setString(8, zipCode);
	        pstmt.setString(9, countryCode);
	        pstmt.setString(10, areaCode);
	        pstmt.setString(11, phoneNumber);
	        pstmt.setInt(12, citizenship_id);
	        pstmt.setInt(13, residence_id);
	        pstmt.setInt(14, specialization_id);
	        
	        pstmt.executeUpdate();
	        
	        pstmt = conn.prepareStatement(
	        		"SELECT currval('applications_id_seq')"        		
   	       			);
	        rs = pstmt.executeQuery();
	        rs.next();
	        application_id = rs.getInt("currval");
	        
	        int university_id; 
	        int major_id;
	        
	        for(int i = 0; i<degrees.size(); i++){
	        	HashMap<String, String> degree = degrees.get(i);
	        	
	        	pstmt = conn.prepareStatement(
	        			"SELECT u_id "+
       	        		"FROM universities "+
       	        		"WHERE university=?"+
       	        		"AND country_state=?"
	        	        );
	        	pstmt.setString(1, degree.get("universityName"));
	        	pstmt.setString(2, degree.get("universityLocation"));
	        	rs = pstmt.executeQuery();
		        rs.next();
		       	university_id = rs.getInt("u_id");
		        
		        pstmt = conn.prepareStatement(
	        			"SELECT m_id "+
       	        		"FROM majors "+
       	        		"WHERE major=?"
	        	        );
	        	pstmt.setString(1, degree.get("disciplineName"));
	        	rs = pstmt.executeQuery();
		        rs.next();
		        major_id = rs.getInt("m_id");
	        	
	        	pstmt = conn.prepareStatement(
	        			"INSERT INTO degrees "+
       	       			"(application_id, university_id, major_id, degree_type, gpa, grad_month, grad_year) "+
       	           		"VALUES "+
       	       			"(?, ?, ?, ?, ?, ?, ?)"
	        			);
	        	pstmt.setInt(1, application_id);
		        pstmt.setInt(2, university_id);
		        pstmt.setInt(3, major_id);
		        pstmt.setString(4, degree.get("degreeType"));
		        pstmt.setString(5, degree.get("degreeGPA"));
		        pstmt.setString(6, degree.get("degreeMonth"));
		        pstmt.setString(7, degree.get("degreeYear"));
		        pstmt.executeUpdate();
	        	
	        }
	        
	        conn.commit();
	        conn.setAutoCommit(true);
	        
	        rs.close();
	        
	        pstmt.close();
	        
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
	<h1>Congratulations!</h1>
	<h2>Your application id is: <%= application_id %></h2>

</body>
</html>