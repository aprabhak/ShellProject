import java.sql.*;
import java.util.Scanner;
import java.text.SimpleDateFormat;  //compile by running javac b4_aprabhak.java
public class b4_aprabhak {          //run by java -cp .:/p/oracle12c/ojdbc7.jar b4_aprabhak
	Connection con;                 //enter the movieid
	
	public b4_aprabhak() {
		try {
			Class.forName( "oracle.jdbc.driver.OracleDriver" );
		}
		catch ( ClassNotFoundException e ) {
			e.printStackTrace();
		}
		try {
			con =
					DriverManager.getConnection( "jdbc:oracle:thin:@claros.cs.purdue.edu:1524:strep","aprabhak", "HALO3ODST" );
		}
		catch ( SQLException e ){
			e.printStackTrace();
		}
	}
		public void getshowtimeinfo ( int mid) {
		String stmt = "Select showid,name,starttime,endtime,hall,max_occupancy from Showtimes natural join Theaters where movieID=?";
		try {
		PreparedStatement ps = con.prepareStatement( stmt );
		ps.setInt( 1, mid );
		ResultSet rs = ps.executeQuery();
		System.out.println( "showid theater starttime endtime hall max_occupancy" );
		while ( rs.next() ) {
			int showid = rs.getInt( "showid" );
			String name = rs.getString("name");
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			Date starttime = rs.getDate("starttime");
			Date endtime = rs.getDate("endtime");
			int hall = rs.getInt("hall");
			int max_occupancy = rs.getInt("max_occupancy");
			System.out.println( showid + " " + name +" "+sdf.format(starttime)+" "+sdf.format(endtime)+" "+hall+" "+max_occupancy);
		}

		rs.close();
		ps.close();
		}
		catch (SQLException e){}
	}
		public void getuserageinfo ( int mid) {
		String stmt = "select age,count(userid) as numuser from showtimes natural join tickets natural join users where movieid = ? group by age";
		try {
		PreparedStatement ps = con.prepareStatement( stmt );
		ps.setInt( 1, mid );
		ResultSet rs = ps.executeQuery();
		System.out.println( "agegroup numberofusers" );
		while ( rs.next() ) {
			String age = rs.getString( "age" );
			int numuser  = rs.getInt("numuser");
			System.out.println(age + " "+numuser);
		}
		rs.close();
		ps.close();
		}
		catch (SQLException e){}
	}
	public static void main( String [] args ) {
		StudentDB sdb = new StudentDB();
		System.out.println("Enter movieID");
		Scanner in = new Scanner(System.in);
		int num = in.nextInt();
		//sdb.getStudentsInDepartment(11,"SO");
		//sdb.getStudentsInDepartmentPrepared(11,"SO");
		sdb.getshowtimeinfo(num);
		System.out.println();
		sdb.getuserageinfo(num);
		//sdb.enroll( 1234, "John",11,"JR",18);
        //sdb.getStudentsInClass("ENG40000");
	}
}

//select table_name from user_tables;
