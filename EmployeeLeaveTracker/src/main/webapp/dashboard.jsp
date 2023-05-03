<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<!Doctype HTML>
			<html>

			<head>
				<title>Employee Dashboard</title>
				<link rel="stylesheet" href="style.css">
				<link rel="stylesheet"
					href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
				<link href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" rel="Stylesheet"
					type="text/css" />
				<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
				<script type="text/javascript" src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

				<style>
					@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
					body {
						margin: 0px;
						padding: 0px;
						background-color: white;
						overflow-x: hidden;
						color: black;
					}
					.main {
						display: flex;
						flex-direction: column;
						justify-content: center;
						align-items: center;
					}
					input[type=submit] {
						padding: 10px 20px;
						margin: 10px 0px;
						background-color: #A9A9A9;
						border-radius: 10px;
						border: none;
					}
					.wrap {
						display: flex;
						justify-content: space-between;
						align-items: center;
						height: 100vh;
						width: 100vw;
					}
					#sideContent {
						display: flex;
						justify-content: center;
						align-items: center;
						color: black;
						height: 100%;
						width: 100%;
					}
					table {
						border-spacing: 15px;
					}
					.sidenav {
						height: 100%;
						width: 270px;
						background-color: #242424;
						transition: 0.5s;
						padding: 30px 15px 0px 0px;
					}
					.sidenav span {
						padding: 15px 8px 15px 32px;
						text-decoration: none;
						font-size: 20px;
						color: #5DADE2;
						display: block;
						transition: 0.3s;
					}
					.sidenav span:hover {
						color: #f1f1f1;
						background-color: #21618c;
					}
					.dashboard {
						margin: 0px;
						margin-left: 28px;
						font-size: 40px;
						color: #F4F6F7;
						margin-bottom: 30px;
					}
					.menu li {
						margin: 0px;
						margin-left: -10px;
						font-size: 20px;
						color: #99A3A4;
						margin-bottom: 30px;
					}
					.sub-menu li {
						margin: 0px;
						margin-left: -50px;
						font-family: 'Aleo light';
						font-size: 20px;
						color: #5DADE2;
					}
					.horizontal-line {
						display: block;
						margin-top: 30px;
						margin-left: auto;
						margin-right: 20px;
						border-style: inset;
						border-width: 1px;
					}
					* {
						list-style: none;
						font-family: 'Poppins', sans-serif;
					}
					.inputContainer {
						display: flex;
						flex-direction: row;
						gap: 20px;
						justify-content: center;
						align-items: center;
						margin-top: 30px;
						font-size: 20px;
					}
					.table-container {
						margin-top: 20px;
						display: flex;
						flex-direction: row;
						gap: 20px;
						justify-content: space-evenly;
						align-items: center;
					}
					.leaves-container {
						padding-top: 30px;
					}
					.container {
						position: relative;
						margin-top: 100px;
						width: 440px;
						height: auto;
						background: #dedede;
						border-radius: 5px;
						margin-left: 100px;
					}
					.label1 {
						padding: 20px 130px;
						font-size: 35px;
						font-weight: bold;
						color: #130f40;
						text-align: center;
					}
					.login_form {
						padding: 20px 40px;
					}
					.login_form .font {
						font-size: 18px;
						color: #130f40;
						margin: 5px 0;
					}
					.login_form input {
						height: 40px;
						width: 350px;
						padding: 0 5px;
						outline: none;
						border: 1px solid silver;
					}
					.login_form .font2 {
						margin-top: 30px;
					}
					.login_form button {
						margin: 45px 0 30px 0;
						height: 45px;
						width: 365px;
						font-size: 20px;
						color: white;
						outline: none;
						cursor: pointer;
						font-weight: bold;
						background: #2471A3;
						border-radius: 3px;
						border: 1px solid #3949AB;
						transition: .5s;
					}
					.login_form button:hover {
						background: #1A5276;
					}
					.login_form #email_error,
					.login_form #pass_error {
						margin-top: 5px;
						width: 345px;
						font-size: 18px;
						color: #C62828;
						background: rgba(255, 0, 0, 0.1);
						text-align: center;
						padding: 5px 8px;
						border-radius: 3px;
						border: 1px solid #EF9A9A;
						display: none;
					}
				</style>
				<script type="text/javascript">
					function validate() {
						let fromDate = document.getElementById("from_date").value;
						let toDate = document.getElementById("to_date").value;
						if (fromDate < Date.now() || toDate < Date.now()) {
							alert("Please enter valid dates");
							return false;
						}
						return true;
					}
					function confirmDelete() {
						return confirm("Confirm to delete leave");
					}
				</script>
			</head>

			<body>
				<div class="wrap">
					<div id="mySidenav" class="sidenav">
						<p class="dashboard">Dashboard</p>
						<ul class="menu">
							<li type=none>Employee</li>
							<ul class="sub-menu">
								<li>
									<form method="post" action="Dashboard">
										<input type="hidden" name="selectedTabName" value="ViewLeaves" id="vl">
										<input type="submit" value="View Leaves" />
									</form>
								</li>
								<li>
									<form method="post" action="Dashboard">
										<input type="hidden" name="selectedTabName" value="AddLeave" id="al">
										<input type="submit" value="Add Leave" />
									</form>
								</li>
							</ul>
							<hr color="#85C1E9" class="horizontal-line">
							</hr>
							<li type=none>Manager</li>
							<ul class="sub-menu">

								<li type=none>
									<form method="post" action="Dashboard">
										<input type="hidden" name="selectedTabName" value="Manager" id="al">
										<input type="submit" value="Employee Details" />
									</form>
								</li>
							</ul>
							<hr color="#85C1E9" class="horizontal-line">
							</hr>
						</ul>

					</div>

					<div id="sideContent">
						<c:choose>
							<c:when test="${tabName=='Default'}">
								<section class="main tabContent" id="banner"
									style="text-align:center; width:100%; visibility:visible;">

									<h1>BSCS LEGACY LEAVE TRACKER</h1>

								</section>
							</c:when>
							<c:when test="${tabName=='ViewLeaves'}">
								<!-- 
												VIEW LEAVES SECTION
											 -->

								<section class="main tabContent" id="ViewLeaves" style="text-align:center; width:100%;">

									<form method="post" action="Dashboard">
										<div class="inputContainer">
											Select Employee: <select name="selectedEmp" id="selectedEmp">
												<option value="" disabled selected>
													select employee
												</option>
												<c:forEach items="${empsDetails}" var="emp">
													<option value="${emp.name}">${emp.signum}</option>
												</c:forEach>
											</select>
											<div class="buttonsContainer">
												<input type="hidden" name="requestMode" value="ViewLeaves" id="vl">

												<input type="submit" value="View Employee Details" />
											</div>
										</div>
									</form>

									<c:if test="${empLeaves!=null || fn:length(empLeaves)>0}">

										<div class="table-container">
											<div class="leaves-container">


												<h3>${sname}(${ssignum})</h3> <br>
												<table>
													<tr>
														<th> <b>From Date</b> </th>
														<th> <b>To Date</b> </th>
														<th><b>Half/Full</b></th>
														<th><b>Actions</b></th>
														<th><b>Number Of Days</b></th>
													</tr>
													<c:forEach items="${empLeaves}" var="leave">
														<tr>
															<td>${leave.from_date}</td>
															<td>${leave.to_date}</td>
															<td>${leave.type}</td>
															<td>

																<c:if test="${leave.canBeEdited==false}">
																	<button disabled>Edit</button>
																</c:if>
																<c:if test="${leave.canBeEdited==true}">
																	<form method="post" action="Dashboard"
																		onsubmit="return confirm('confirm to edit leave')">
																		<input type="hidden" name="requestMode"
																			value="EditLeave" id="vl">
																		<input type="hidden" name="leaveId"
																			value="${leave.leaveId}" id="vl">

																		<button type="submit">Edit</button>
																	</form>
																</c:if>

																<c:if test="${leave.canBeDeleted==false}">
																	<button disabled>Delete</button>
																</c:if>
																<c:if test="${leave.canBeDeleted==true}">
																	<form method="post" action="Dashboard"
																		onsubmit="return confirm('confirm to delete leave')">
																		<input type="hidden" name="requestMode"
																			value="DeleteLeave" id="vl">
																		<input type="hidden" name="leaveId"
																			value="${leave.leaveId}" id="vl">

																		<button type="submit">Delete</button>
																	</form>
																</c:if>

															</td>
															<td>${leave.numberOfDays}</td>
														</tr>
													</c:forEach>


												</table>
											</div>
									</c:if>
									<c:if test="${noLeaves==true}">
										<p>No leaves this month
										</p>
									</c:if>

								</section>
							</c:when>

							<c:when test="${tabName=='AddLeave'}">
								<!-- 
											Add leaves section
											 -->

								<section class="main tabContent" id="AddLeave" style="text-align:center; width:50%;">

									<form method="post" action="Dashboard" onsubmit="return validate();">

										<table>
											<tr>
												<td><label for="">Select Employee:</label></td>
												<td>
													<select name="selectedEmp" id="selectedEmp" required>
														<option value="" disabled selected>
															select employee
														</option>
														<c:forEach items="${empsDetails}" var="emp">
															<option value="${emp.name}">${emp.signum}</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													From Date:
												</td>
												<td>



													<input type="date" name="from_date" id="from_date"
														onchange="setMinDate(event);" required />

													<br><br>
												</td>
											</tr>
											<tr>
												<td>
													To Date:
												</td>
												<td>
													<input type="date" name="to_date" id="to_date" required /> <br><br>
												</td>
											</tr>
											<tr>
												<td>
													Leave Type:
												</td>
												<td>
													<select name="type" id="leaveType" required><br> <br>
														<option value="" disabled selected hidden>Select Leave Type
														</option>

														<option value="FULL">FULL</option>
														<option value="HALF">HALF</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													CL/PL/EL:
												</td>
												<td>
													<select name="mode" id="leaveMode" required><br> <br>
														<option value="" disabled selected hidden>Select Leave Type
														</option>

														<option value="CL">CL</option>
														<option value="PL">PL</option>
														<option value="EL">EL</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													Reason:
												</td>
												<td>
													<textarea name="reason" placeholder="reason" required></textarea>
												</td>
											</tr>
											<tr>
												<td><input type="hidden" name="requestMode" value="AddLeave" id="vl">

													<input type="submit" value="Add Leave" />
												</td>


											</tr>
										</table>
									</form>
								</section>
							</c:when>

							<c:when test="${tabName=='EditLeave'}">
								<!-- 
											Edit leave
											 -->

								<section class="main tabContent" id="AddLeave" style="text-align:center; width:50%;">

									<form method="post" action="Dashboard" onsubmit="return validate();">
										<h1>Edit leave of ${leave.name}</h1>
										<table>

											<tr>
												<td>
													From Date:
												</td>
												<td>
													<input type="date" name="from_date" id="from_date"
														value="${leave.from_date}" required
														onchange="setMinDate(event);" />
													<br><br>
												</td>
											</tr>
											<tr>
												<td>
													To Date:
												</td>
												<td>
													<input type="date" name="to_date" id="to_date"
														value="${leave.to_date}" required />
													<br><br>
												</td>
											</tr>
											<tr>
												<td>
													Leave Type:
												</td>
												<td>
													<select name="type" id="leaveType" required disabled>
														<option value="${leave.type}" selected>${leave.type}</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													CL/PL/EL:
												</td>
												<td>
													<select name="mode" id="leaveMode" required disabled><br> <br>
														<option value="${leave.mode}" selected>${leave.mode}</option>
													</select>
												</td>
											</tr>
											<tr>
												<td>
													Reason:
												</td>
												<td>
													<textarea disabled name="reason" placeholder="reason"
														required>${leave.reason}</textarea>
												</td>
											</tr>
											<tr>
												<td>

													<input type="hidden" name="requestMode" value="UpdateLeave" id="vl">
													<input type="hidden" name="leaveId" value="${leave.leaveId}"
														id="vl">

													<input type="submit" value="Updated Leave" />
												</td>


											</tr>
										</table>
									</form>
								</section>
							</c:when>



							<c:when test="${tabName=='Manager'}">

								<c:choose>

									<c:when test="${managerStatus=='login'}">
										<!-- 
											Login
												 -->
										<section class="main tabContent" id="Manager" style=" width:100%;">

											<div class="container">

												<form class="login_form" method="post" name="form"
													onsubmit="return validated()">
													<div class="font">signum</div>
													<input type="text" name="loginSignum" required>
													<div class="font2">Password</div>
													<input type="password" name="loginPassword" required>
													<input type="hidden" name="requestMode" value="Login" id="al">
													<button type="submit">Login</button>
												</form>
											</div>
										</section>

									</c:when>

									<c:when test="${managerStatus=='viewAllLeaves'}">
										<section class="main tabContent" id="ViewAllLeaves"
											style="text-align:center; width:100%;">
											<form method="post" action="Dashboard">
												<div class="inputContainer">
													Select Employee: <select name="selectedEmp" id="selectedEmp">
														<option value="" disabled selected>
															select employee
														</option>
														<c:forEach items="${empsDetails}" var="emp">
															<option value="${emp.name}">${emp.signum}</option>
														</c:forEach>
													</select>
													<div class="buttonsContainer">
														<input type="hidden" name="requestMode" value="ViewAllLeaves"
															id="vl">
														<input type="submit" value="View Employee Details" />
													</div>
												</div>
											</form>

											<c:if test="${empLeaves!=null || fn:length(empAllLeaves)>0}">

												<div class="table-container">
													<div class="leaves-container">


														<h3>${msname}(${mssignum})</h3> <br>
														<table>
															<tr>
																<td> <b>From Date</b> </td>
																<td><b>To Date</b></td>
																<td> <b>Half/Full</b> </td>
																<td> <b>CL/PL/EL</b> </td>
																<td> <b>Reason</b> </td>
																<td> <b>Number Of Days</b> </td>
															</tr>
															<c:forEach items="${empAllLeaves}" var="leave">
																<tr>
																	<td>${leave.from_date}</td>
																	<td>${leave.to_date}</td>
																	<td>${leave.type}</td>
																	<td>${leave.mode}</td>
																	<td>${leave.reason}</td>
																	<td>${leave.numberOfDays}</td>
																</tr>
															</c:forEach>
														</table>
													</div>
												</div>
											</c:if>
											<c:if test="${noLeaves==true}">
												<p>No leaves this month
												</p>
											</c:if>

										</section>
									</c:when>
								</c:choose>
							</c:when>
						</c:choose>
					</div>
				</div>


				<script language="javascript">
					if (new Date().getHours() <= 11) {
						var today = new Date();
						var dd = String(today.getDate()).padStart(2, '0');
						var mm = String(today.getMonth() + 1).padStart(2, '0');
						var yyyy = today.getFullYear();
						today = yyyy + '-' + mm + '-' + dd;
						$('#to_date').attr('min', today);
						$('#from_date').attr('min', today);
					}
					else {
						var today = new Date(+new Date() + 86400000);
						var dd = String(today.getDate()).padStart(2, '0');
						var mm = String(today.getMonth() + 1).padStart(2, '0');
						var yyyy = today.getFullYear();
						today = yyyy + '-' + mm + '-' + dd;
						$('#to_date').attr('min', today);
						$('#from_date').attr('min', today);
					}
					function setMinDate(e) {
						$("#to_date").attr("min", e.target.value);
						$("#to_date").attr("value", "");
						setMaxDate(e);
					}
					
					function setMaxDate(e) {
						console.log("inside setMaxDate");
						var date = new Date(e.target.value);
						var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
						var dd = String(lastDay.getDate()).padStart(2, '0');
						var mm = String(lastDay.getMonth() + 1).padStart(2, '0');
						var yyyy = lastDay.getFullYear();
						lastDay = yyyy + '-' + mm + '-' + dd;
						$("#to_date").attr("max", lastDay);
						$("#to_date").attr("value", "");
					}
					
					function setLeaveType(e) {
						var fromDate = $("#from_date").val();
						var toDate = $("#to_date").val();
						if (fromDate != toDate) {
							$("select option:contains(HALF)").attr("disabled", "disabled");
						} else {
							$("select option:contains(HALF)").prop("disabled", false);
						}
					}
					$(document).ready(function () {
						$("#to_date").change(function () {
							var fromDate = $("#from_date").val();
							var toDate = $(this).val();
							console.log(fromDate === toDate);
							if (fromDate === toDate) {
								$("select option:contains(HALF)").attr("disabled", false);
							} else {
								$("select option:contains(HALF)").attr("disabled", true);
							}
						})
					});
				</script>
			</body>

			</html>