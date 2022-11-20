<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link href="styles/style.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<title>학생 정보</title>
<script>
	var del = function(id){
		location.href = '/ch09/studentControl?action=delete&id='+id;
	}
</script>

<%  
	boolean flag = request.getAttribute("deleted") != null ? (boolean)request.getAttribute("deleted") : false;	
	if(flag){
%>
		<script>
			alert("삭제되었습니다!");
		</script>
<%
	}
%>
</head>
<body>
	<div class="body">
		<div class="student-list">
			<h2 class="title">학생 정보</h2>			
			<table class="table table-striped">
				<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">이름</th>
						<th scope="col">대학</th>
						<th scope="col">생일</th>
						<th scope="col">이메일</th>
						<th></th>
					</tr>					
				</thead>
				<tbody>
				<c:forEach items="${students}" var="s">
					<tr>
						<th scope="row">${s.id}</th>
						<td>${s.username}</td>
						<td>${s.univ}</td>
						<td>${s.birth}</td>
						<td>${s.email}</td>
						<td><button class="btn btn-danger" onclick="del(${s.id})">삭제</button></td>
					</tr>
				</c:forEach>
				</tbody>				
			</table>
		</div>			
		<div class="add-student">
			<h2 class="title">학생 추가</h2>			
			<div class="insert-student form-group">
				<form method="post" action="/ch09/studentControl?action=insert">										
					<input type="text" name="username" class="form-control" placeholder="이름">										
					<input type="text" name="univ" class="form-control" placeholder="대학">										
					<input type="text" name="birth" class="form-control" placeholder="생일">										
					<input type="text" name="email" class="form-control" placeholder="이메일">					
					<button type="submit">등록</button>
				</form>
			</div>		
		</div>
	</div>	
</body>
</html>