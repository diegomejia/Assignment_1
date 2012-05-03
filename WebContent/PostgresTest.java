import java.sql.*;

class PostgresTest {
	
	public static void main(String args[]) throws SQLException {
		// Registering PostgresqlJDBC driver
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Open a connection to the database
		Connection conn = DriverManager
				.getConnection("jdbc:postgresql://localhost/jdbc-examples?"
						+ "user=postgres&password=postgres");
		// Query the student PIDs
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("SELECT pid FROM students");
		// Print out the PID (1st attribute)
		while (rset.next())
			System.out.println(rset.getInt(1));
		// close the result set, statement, and connection
		rset.close();
		stmt.close();
		conn.close();
	}
	
}