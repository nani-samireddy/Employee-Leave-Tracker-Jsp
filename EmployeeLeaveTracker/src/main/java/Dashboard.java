import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
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
						Leave[] emp_leaves= db.getEmployeeLeaves(signum, false);
						e = db.getEmployeDetails(signum);
						req.setAttribute("sname", e.getName());
						req.setAttribute("ssignum", e.getSignum());
						req.setAttribute("empLeaves",emp_leaves);
						req.setAttribute("noLeaves", emp_leaves==null);
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
						db.addLeave(new Leave(00,signum1, from_date,to_date, type, e1.name, mode, reason));
						tab = "AddLeave";
						break;
					case "Login":
						String username = req.getParameter("loginSignum");
						String password = req.getParameter("loginPassword");
						if (db.login(username, password)) {
							req.setAttribute("managerStatus", "viewAllLeaves");
							System.out.println("Sucessfully loggged In");
							tab = "Manager";
						} else {
							req.setAttribute("managerStatus", "login");
							System.out.println("Failed log In");
							tab = "Manager";
						}
						break;
					case "ViewAllLeaves":
						System.out.println("gettting all leaves");
						String signum2 = req.getParameter("selectedEmp");
						Employee e2;
						Leave[] emp_allLeaves= db.getEmployeeLeaves(signum2, true);
						e2 = db.getEmployeDetails(signum2);
						req.setAttribute("msname", e2.getName());
						req.setAttribute("mssignum", e2.getSignum());
						req.setAttribute("empAllLeaves", emp_allLeaves);
						req.setAttribute("managerStatus", "viewAllLeaves");
						req.setAttribute("noLeaves", emp_allLeaves==null);
						tab = "Manager";
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

