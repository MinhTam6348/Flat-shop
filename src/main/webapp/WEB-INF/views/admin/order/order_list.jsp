<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard | Klorofil - Free Bootstrap Dashboard Template</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<!-- VENDOR CSS -->
<link rel="stylesheet"
	href="<c:url value='../resource/admin/assets/vendor/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet"
	href="<c:url value='../resource/admin/assets/vendor/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet"
	href="<c:url value='../resource/admin/assets/vendor/linearicons/style.css'/>">
<link rel="stylesheet"
	href="<c:url value='../resource/admin/assets/vendor/chartist/css/chartist-custom.css'/>">
<!-- MAIN CSS -->
<link rel="stylesheet"
	href="<c:url value='../resource/admin/assets/css/main.css'/>">
<link rel="stylesheet"
	href="<c:url value='../resource/admin/assets/css/demo.css'/>">
<!-- GOOGLE FONTS -->
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700"
	rel="stylesheet">

<!-- ICONS -->
<link rel="apple-touch-icon" sizes="76x76"
	href="<c:url value='../resource/admin/assets/img/apple-icon.png'/>">
<link rel="icon" type="image/png" sizes="96x96"
	href="<c:url value='../resource/admin/assets/img/favicon.png'/>">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
</head>
<body>
	<!-- WRAPPER -->
	<div id="wrapper">

		<jsp:include page="../common/header.jsp" />

		<jsp:include page="../common/category.jsp" />

		<!-- MAIN -->
		<!-- MAIN CONTENT -->
		<div class="main">
			<div class="main-content">
				<div class="container-fluid">
					<!-- OVERVIEW -->
					<div class="panel panel-headline">
						<div class="panel-body">
							<form>
								<div class="row">
									<div class="col-md-12">
										<div class="panel">
											<div class="panel-heading">
												<h3 class="panel-title">ORDER LIST</h3>
												<div class="right">
													<button type="submit">
														<span class="label label-danger"
															style="font-size: 15px; margin-right: 15px;">Delete</span>
													</button>
													<a href="#"><span class="label label-success"
														style="font-size: 15px;">Create new order</span></a>
												</div>
											</div>
											<div class="panel-body no-padding">
												<table class="table table-striped" style="margin: auto;">
													<thead>
														<tr>
															<th><input type="checkbox" name="all" id="checkAll"
																style="cursor: pointer;" /></th>
															<th>Order No.</th>
															<th style="width: 20%;'">Name</th>
															<th>Amount</th>
															<th>Date &amp; Time</th>
															<th>Status</th>
															<th>Details</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach items="${orders}" var="order" varStatus="loop">
															<tr>
																<td style="vertical-align: middle;"><input
																	class="checkbox" type="checkbox" name="orderId"
																	value="${order.orderId}" id="${loop.count}"
																	style="cursor: pointer;" /></td>
																<td style="vertical-align: middle;">No.
																	${order.orderId}</td>
																	<td>${order.userDTO.email.split("@")[0]}</td>
															<td>${Math.round(order.priceTotal)} đ</td>
															<td>${order.buyDate}</td>
															<c:if test="${order.status eq 'PENDING'}">
																<td><a href="order-update?orderId=${order.orderId}&pageIndex=${pageIndex}
																"><span class="label label-warning">PENDING</span></a></td>
															</c:if>
															<c:if test="${order.status eq 'SUCCESS'}">
																<td><span class="label label-success">SUCCESS</span></td>
															</c:if>
															<td><a href="order-details?orderId=${order.orderId}" style="text-decoration: underline;">Details</a></td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
										<nav aria-label="Page navigation example"
											style="margin-top: -30px;">
											<ul class="pagination">
												<c:forEach begin="0" end="${totalPage - 1}" var="i">
													<li class="page-item"><a class="page-link"
														<c:if test="${i == pageIndex}">
															style="background-color: #F0AD4E; color: white;"
														</c:if>
														href="order-list?pageIndex=${i}">${i + 1}</a></li>
												</c:forEach>
											</ul>
										</nav>
									</div>
									<div id="headline-chart" class="ct-chart"></div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- END OVERVIEW -->
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			<div class="container-fluid">
				<p class="copyright">
					&copy; 2017 <a href="https://www.themeineed.com" target="_blank">Theme
						I Need</a>. All Rights Reserved.
				</p>
			</div>
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script>
            let userSelection = document.getElementsByClassName('checkbox');
            let checkAll = document.getElementById('checkAll')


            checkAll.addEventListener('click', () => {
                if (checkAll.checked == true) {
                    for (let i = 1; i <= userSelection.length; i++) {
                        document.getElementById(i).checked = true
                    }
                } else {
                    for (let i = 1; i <= userSelection.length; i++) {
                        document.getElementById(i).checked = false
                    }
                }

            })
   </script>
</body>
</body>
</html>