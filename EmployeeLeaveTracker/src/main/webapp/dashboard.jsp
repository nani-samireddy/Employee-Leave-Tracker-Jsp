<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<!Doctype HTML>
			<html>

			<head>
				<title>Employee Dashboard</title>
				<link rel="stylesheet" href="./style.css">
				<link rel="stylesheet"
					href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
				<link href="https://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" rel="Stylesheet"
					type="text/css" />
				<script type="text/javascript" src="https://code.jquery.com/jquery-1.7.2.min.js"></script>
				<script type="text/javascript" src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

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
				
				<c:if test="${alertContent!=null}">
					<input id="alertbox" value="${alertContent}" type="hidden"/>
				</c:if>
<nav>
	<h1>BSCS LEGACY LEAVE TRACKER</h1>
	
</nav>
			
				<div class="wrap">
					<div id="mySidenav" class="sidenav">
						<ul class="menu">
							<li type=none>Employee</li>
							<ul class="sub-menu">
								<li>
									<form method="post" action="Dashboard">
										<input type="hidden" name="selectedTabName" value="EmployeeMonthlyReport" id="vl">
										<input type="submit" value="Employee Monthly Report" />
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
										<input type="submit" value="All Employees Report" />
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
							<c:when test="${tabName=='EmployeeMonthlyReport'}">
								<!-- 
												EmployeeMonthlyReport
											 -->

								<section class="main tabContent" id="EmployeeMonthlyReport" style="text-align:center; width:100%;">

									<form method="post" action="Dashboard">
												<div class="inputContainer">
													<select name="selectedEmp" id="selectedEmp">
														<option value="" disabled selected>
															select employee
														</option>
														<c:forEach items="${empsDetails}" var="emp">
															<option value="${emp.name}">${emp.signum}</option>
														</c:forEach>
													</select>
													<input name="monthAndYear" type="month" required />
													<div class="buttonsContainer">
														<input type="hidden" name="requestMode" value="EmployeeMonthlyReport" id="vl">
														<input type="submit" value="View Employee Details" />
														</div>
														</div>
														</form>

									<c:if test="${empLeaves!=null || fn:length(empLeaves)>0}">

										<div class="table-container">
											<div class="leaves-container">


												<h3>${sname}(${ssignum})</h3> <br>
													<table class="output">
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

									<c:when test="${managerStatus=='AllEmployeeReport'}">
										<!-- All Employees report -->
										<section class="main tabContent" id="AllEmployeeReport"
											style="text-align:center; width:100%;">
											<form method="post" action="Dashboard">
												<div class="inputContainer">
												From
												<input name="from" type="date" placeholder="From date" required />
												To:
												<input name="to" type="date" placeholder="To date" required />
													<div class="buttonsContainer">
														<input type="hidden" name="requestMode" value="AllEmployeeReport"
															id="vl">
														<input type="submit" value="Get Report" />
													</div>
												</div>
											</form>

											<c:if test="${allLeaves!=null || fn:length(allLeaves)>0}">

												<div class="table-container">
													<div class="leaves-container">
														<table class="output">
															<tr>
																<th> <b>SIGNUM</b> </th>
																<th> <b>NAME</b> </th>
																<th> <b>FROM</b> </th>
																<th><b>TO</b></th>
																<th> <b>HALF/FULL</b> </th>
																<th> <b>CL/PL/EL</b> </th>
																<th> <b>REASON</b> </th>
																<th> <b>NUMBER OF DAYS</b> </th>
															</tr>
															<c:forEach items="${allLeaves}" var="leave">
																<tr>
																<td>${leave.signum}</td>
																<td>${leave.name}</td>
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


				<script>
				$(document).ready(function() {
					  if ($("#alertbox").length) {
					    var inputValue = $("#alertbox").val();
					    alert(inputValue);
					  }
					});
					
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
					
					
				</script>
			</body>

			</html>