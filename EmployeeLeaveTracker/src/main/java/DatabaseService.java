import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.concurrent.TimeUnit;

public class DatabaseService {

	String url = "jdbc:mysql://localhost:3306/leaves";
	String user = "root";
	String pass = "Root@123";

	public void load() throws ClassNotFoundException, SQLException {
		String driver = "com.mysql.cj.jdbc.Driver";
		Class.forName(driver);
	}

	public Employee[] getEmployeNames() throws SQLException, ClassNotFoundException {
		// Connection to Db
		load();
		Connection con = DriverManager.getConnection(url, user, pass);

		// Creating statement
		Statement stmt = con.createStatement();

		// getting the number of Rows
		String query = "select count(*) from employee";
		ResultSet rs = stmt.executeQuery(query);
		rs.next();
		int numberOfRows = rs.getInt(1);
		Employee[] employees = new Employee[numberOfRows];

		// getting full employees details
		query = "select * from employee order by name ASC";
		rs = stmt.executeQuery(query);
		

		// mapping employee table to employee class
		int index = 0;
		while (rs.next()) {

			String name = rs.getString(1);
			String signum = rs.getString(2);
			Employee e = new Employee(name, signum);
			employees[index] = e;
			index++;
		}

		con.close();
		return employees;

	}

	public Leave[] getEmployeeLeaves(String signum, boolean allLeaves) throws ClassNotFoundException, SQLException {
		// Connection to Db
		load();
		Connection con = DriverManager.getConnection(url, user, pass);

		// getting the number of Rows
		String query = "select count(*) from emp_leaves where signum in (?) and (MONTH(from_date)=MONTH(now()) or MONTH(to_date)=MONTH(now())) and (YEAR(from_date)=YEAR(now()) or YEAR(to_date)=YEAR(now()))";

		if (allLeaves) {
			query = "select count(*) from emp_leaves where signum in (?)";
		}
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, signum);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int numberOfRows = rs.getInt(1);

		// getting the empName
		query = String.format("select name from employee where signumid in (%s)", signum);
		rs = ps.executeQuery();
		rs.next();
		String name = rs.getString(1);

		// getting the emp leaves list
		query = "select * from emp_leaves where signum in (?) and (MONTH(from_date)=MONTH(now()) or MONTH(to_date)=MONTH(now())) and (YEAR(from_date)=YEAR(now()) or YEAR(to_date)=YEAR(now()))";
		if (allLeaves) {
			query = "select * from emp_leaves where signum in (?)";
		}

		PreparedStatement ps1 = con.prepareStatement(query);
		ps1.setString(1, signum);

		rs = ps1.executeQuery();

		// creating the leaveslist
		Leave[] empLeaves = new Leave[numberOfRows];
		int index = 0;
		while (rs.next()) {
			empLeaves[index] = new Leave(rs.getInt("leaveid"), rs.getString("signum"),
					rs.getDate("from_date").toString(), rs.getDate("to_date").toString(), rs.getString("type"), name,
					rs.getString("mode"), rs.getString("reason"), rs.getInt("number_of_days"));
			index++;
		}
		con.close();
		return empLeaves;

	}
	

	public Leave[] getLeavesInMonth(String signum, Date date) throws ClassNotFoundException, SQLException {
		// Connection to Db
		load();
		Connection con = DriverManager.getConnection(url, user, pass);

		int month = getMonthNumber(date);
		int year = getYearNumber(date);
		// getting the number of Rows
		String query = "select count(*) from emp_leaves where signum in (?) and (MONTH(from_date)=(?) or MONTH(to_date)=(?)) and (YEAR(from_date)=(?) or YEAR(to_date)=(?))";

		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, signum);
		ps.setInt(2, month);
		ps.setInt(3, month);
		ps.setInt(4, year);
		ps.setInt(5, year);
		

		ResultSet rs = ps.executeQuery();
		rs.next();
		int numberOfRows = rs.getInt(1);

		// getting the empName
		query = String.format("select name from employee where signumid in (%s)", signum);
		rs = ps.executeQuery();
		rs.next();
		String name = rs.getString(1);

		// getting the emp leaves list
		 query = "select * from emp_leaves where signum in (?) and (MONTH(from_date)=(?) or MONTH(to_date)=(?)) and (YEAR(from_date)=(?) or YEAR(to_date)=(?))";
		

		PreparedStatement ps1 = con.prepareStatement(query);
		ps1.setString(1, signum);
		ps1.setInt(2, month);
		ps1.setInt(3, month);
		ps1.setInt(4, year);
		ps1.setInt(5, year);
		
		rs = ps1.executeQuery();

		// creating the leaveslist
		Leave[] empLeaves = new Leave[numberOfRows];
		int index = 0;
		while (rs.next()) {
			empLeaves[index] = new Leave(rs.getInt("leaveid"), rs.getString("signum"),
					rs.getDate("from_date").toString(), rs.getDate("to_date").toString(), rs.getString("type"), name,
					rs.getString("mode"), rs.getString("reason"), rs.getInt("number_of_days"));
			index++;
		}
		con.close();
		return empLeaves;

	}
	
	

	public Employee getEmployeDetails(String signum) throws ClassNotFoundException, SQLException {
		load();
		System.out.println(signum);
		Connection con = DriverManager.getConnection(url, user, pass);
		// Creating statement
		Statement stmt = con.createStatement();

		// getting the number of Rows
		String query = "select * from employee where signumid in (\"" + signum + "\")";
		ResultSet rs = stmt.executeQuery(query);
		rs.next();
		return new Employee(rs.getString("name"), rs.getString("signumid"));
	}

	public DBResponse addLeave(Leave leave) throws ClassNotFoundException, SQLException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);
		
		Date fromDate = Date.valueOf(leave.from_date);
		Date toDate = Date.valueOf(leave.to_date);
		if(this.isOverlapping(leave)) {
			return new DBResponse("Leave dates are overlapping with existing leaves","dates-overlap");
		}

		// Creating statement
		String query = "insert into emp_leaves (signum,from_date,type,mode,reason,to_date,number_of_days) values(?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, leave.signum);
		ps.setDate(2, fromDate);
		ps.setString(3, leave.type);
		ps.setString(4, leave.mode);
		ps.setString(5, leave.reason);
		ps.setDate(6, toDate);
		if(leave.type.toUpperCase().equals("HALF")) {
			System.out.print("YEAAAA");
			ps.setDouble(7, 0.5);
		}else {
		 ps.setDouble(7, calculateActualLeaveDays(fromDate, toDate));
		}
		ps.executeUpdate();
		EmailService.sendLeaveEmail(leave, false);
		return new DBResponse("Leave added successfully","leave-added");

	}

	public boolean login(String signum, String password) throws ClassNotFoundException, SQLException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);
		String role = "MGR";
		// Creating statement
		String query = "select * from employee where signumid in (?) and password in (?) and role in (?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, signum);
		ps.setString(2, password);
		ps.setString(3, role);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			return true;
		}
		return false;
	}

	public Leave getLeave(int leaveId) throws SQLException, ClassNotFoundException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);

		String query = "select * from emp_leaves el inner join employee e on e.signumid = el.signum and el.leaveid in (?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setInt(1, leaveId);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return new Leave(rs.getInt("leaveid"), rs.getString("signum"), rs.getString("from_date"),
				rs.getString("to_date"), rs.getString("type"), rs.getString("name"), rs.getString("mode"),
				rs.getString("reason"), rs.getInt("number_of_days"));

	}

	public void deleteLeave(int leaveId) throws ClassNotFoundException, SQLException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);
		String query = "delete from emp_leaves where leaveid in (?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setInt(1, leaveId);
		ps.executeUpdate();

	}

	public void updateLeave(Leave leave) throws ClassNotFoundException, SQLException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);
		String query = "update emp_leaves set from_date=(?), to_date=(?), number_of_days=(?) where leaveid in (?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setDate(1, Date.valueOf(leave.from_date));
		ps.setDate(2, Date.valueOf(leave.to_date));
		ps.setInt(3, calculateActualLeaveDays(Date.valueOf(leave.from_date), Date.valueOf(leave.to_date)));
		ps.setInt(4, leave.leaveId);
		ps.executeUpdate();
		EmailService.sendLeaveEmail(leave, true);
	}

	public static long getDifferenceDays(Date d1, Date d2) {
		long diff = d2.getTime() - d1.getTime();
		return TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
	}
	
	public static int getMonthNumber(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		// get the month number (0-11) from the Calendar object
		return calendar.get(Calendar.MONTH) + 1;
	}
	
	public static int getYearNumber(Date date) {
		LocalDate localDate = date.toLocalDate();
        // get the year number from the java.time.LocalDate object
        return localDate.getYear();

	}

	public  int calculateActualLeaveDays(Date from, Date to) throws ClassNotFoundException, SQLException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);
		int days = (int) getDifferenceDays(from, to);
		String query = "select count(*) from holiday_calendar where date>=(?) and date<=(?)";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setDate(1, from);
		ps.setDate(2, to);
		ResultSet rs = ps.executeQuery();
		rs.next();
		return days - rs.getInt(1) + 1 - countWeekEnds(from,to);
	}
	
	public int countWeekEnds(Date startDate,Date endDate) {
		// create a Calendar object and set its time to the start date
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        
        // initialize counters for Saturdays and Sundays
        int saturdayCount = 0;
        int sundayCount = 0;
        
        // loop through each day in the time period
        while (calendar.getTime().before(endDate)) {
            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            if (dayOfWeek == Calendar.SATURDAY) {
                saturdayCount++;
            } else if (dayOfWeek == Calendar.SUNDAY) {
                sundayCount++;
            }
            calendar.add(Calendar.DATE, 1);
        }
        return saturdayCount+sundayCount;
	}
	
	public boolean isOverlapping(Leave leave) throws SQLException, ClassNotFoundException {
		load();
		Connection con = DriverManager.getConnection(url, user, pass);
		String query = "SELECT COUNT(*) FROM emp_leaves WHERE signum = ? AND from_date <= ? AND to_date >= ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, leave.signum);
		ps.setDate(2, Date.valueOf(leave.from_date));
		ps.setDate(3,  Date.valueOf(leave.to_date));
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		if (count > 0) {
		    return true;
		} else {
		    return false;
		}

	}
	
	

}