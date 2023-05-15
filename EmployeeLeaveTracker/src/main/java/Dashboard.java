import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** updated here
 * Servlet implementation class Dashboard
 */
@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Dashboard() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		DatabaseService db = new DatabaseService();

		String tab = req.getParameter("selectedTabName");
		req.setAttribute("managerStatus", "login");

		String requestMode = req.getParameter("requestMode");
		// getting all Emp details
		try {
			req.setAttribute("empsDetails", db.getEmployeNames());

			if (requestMode != null) {

				switch (requestMode) {

					case "ViewLeaves":
						String signum = req.getParameter("selectedEmp");
						Employee e;
						Leave[] emp_leaves = db.getEmployeeLeaves(signum, false);
						e = db.getEmployeDetails(signum);
						req.setAttribute("sname", e.getName());
						req.setAttribute("ssignum", e.getSignum());
						req.setAttribute("empLeaves", emp_leaves);
						req.setAttribute("noLeaves", emp_leaves == null);
						tab = "ViewLeaves";
						break;

					case "AddLeave":
						String signum1 = req.getParameter("selectedEmp");
						Employee e1;
						e1 = db.getEmployeDetails(signum1);
						String from_date = req.getParameter("from_date");
						String to_date = req.getParameter("to_date");
						String type = req.getParameter("type");
						String mode = req.getParameter("mode");
						String reason = req.getParameter("reason");
						DBResponse addResponse = db.addLeave(new Leave(00, signum1, from_date, to_date, type, e1.name, mode, reason, 0));
						req.setAttribute("alertContent", addResponse.getMessage());
						tab = "AddLeave";
						break;

					case "EditLeave":
						tab = "EditLeave";
						int leaveId = Integer.parseInt(req.getParameter("leaveId"));
						Leave leave = db.getLeave(leaveId);
						req.setAttribute("leave", leave);
						break;

					case "UpdateLeave":
						tab = "ViewLeaves";
						leaveId = Integer.parseInt(req.getParameter("leaveId"));
						String fromDate = req.getParameter("from_date");
						String toDate = req.getParameter("to_date");
						Leave leave1 = db.getLeave(leaveId);
						leave1.setFrom_date(fromDate);
						leave1.setTo_date(toDate);

						DBResponse upRespose = db.updateLeave(leave1);
						req.setAttribute("alertContent", upRespose.getMessage());

						break;

					case "DeleteLeave":
						leaveId = Integer.parseInt(req.getParameter("leaveId"));
						DBResponse delResponse = db.deleteLeave(leaveId);
						req.setAttribute("alertContent", delResponse.getMessage());
						break;

					case "Login":
						String username = req.getParameter("loginSignum");
						String password = req.getParameter("loginPassword");
						if (db.login(username, password)) {
							req.setAttribute("managerStatus", "AllEmployeeReport");
							System.out.println("Sucessfully loggged In");
							tab = "Manager";
						} else {
							req.setAttribute("managerStatus", "login");
							System.out.println("Failed log In");
							tab = "Manager";
						}
						break;

					case "EmployeeMonthlyReport":
						System.out.println("gettting all leaves");
						String signum2 = req.getParameter("selectedEmp");
						String monthAndYear = req.getParameter("monthAndYear");
						Date monthYear =  Date.valueOf(monthAndYear+"-01");
						Leave[] emp_allLeaves = db.getLeavesInMonth(signum2, monthYear);
						Employee e2 = db.getEmployeDetails(signum2);
						req.setAttribute("sname", e2.getName());
						req.setAttribute("ssignum", e2.getSignum());
						req.setAttribute("empLeaves", emp_allLeaves);
						req.setAttribute("noLeaves", emp_allLeaves == null);
						
						tab = "EmployeeMonthlyReport";
						break;
					case "AllEmployeeReport":
						System.out.println("gettting all leaves");
						String from = req.getParameter("from");
						String to = req.getParameter("to");
						Leave[] allLeaves = db.getLeavesBetweenDates(from, to);
						
						req.setAttribute("from", from);
						req.setAttribute("to", to);
						req.setAttribute("allLeaves", allLeaves);
						req.setAttribute("managerStatus", "AllEmployeeReport");
						req.setAttribute("noLeaves", allLeaves == null);
						tab = "Manager";
						System.out.println(allLeaves.length);
						break;

				}
			}

		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (tab != null) {
			req.setAttribute("tabName", tab);
			System.out.println(tab);

		} else {
			req.setAttribute("tabName", "Default");
		}

		RequestDispatcher rd = req.getRequestDispatcher("dashboard.jsp");
		rd.forward(req, res);
	}

}
