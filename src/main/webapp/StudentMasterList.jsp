<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard Page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container mt-3">

		<table class="table table-striped">
			<tbody>
				<tr align= "right">
					<td>
					    <a href="ReadSubjects"> <button class="btn btn-primary">Subjects</button></a>
					    <a href="ReadTeachers"> <button class="btn btn-primary">Teachers</button></a>
					    <a href="ReadClasses"> <button class="btn btn-primary">Classes</button></a>
					    <a href="ReadStudents"> <button class="btn btn-primary">Students</button></a>
					    <a href="AssignTeacher"> <button>Assign Teacher to Class</button></a>
					    <a href="AssignClass"> <button>Assign Class to Student</button></a>
					    <a href="StudentMasterList.jsp"> <button>Student Master List</button></a>
					    
					    <!--  
					    ...
					    <a href="AddSubject"> <button>Add a Subject</button></a>
					    <a href="AddTeacher"> <button>Add a Teacher</button></a>
					    <a href="AddClass"> <button>Add a Class</button></a>
					    <a href="AddStudent"> <button>Add a Student</button></a>
					    -->
					</td>
					<td><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></td>
				</tr>
			</tbody>
		</table>

		<h1>Welcome to Learners Academy</h1>







// jdbc:mysql:/localhost:3306/employee

 <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/LearnersAcademy"
     user="LAAdmin"  password="LAAdmin"/>
 
<sql:query dataSource="${snapshot}" var="result">
         SELECT * from StudentView;
      </sql:query>
 
      <table border = "1" width = "100%">
         <tr>
         	<th>StudentId</th>
         	<th>StudentName</th>
			<th>ClassID</th>
			<th>Section</th>
			<th>subjectId</th>
			<th>SubjectName</th>
			<th>SubjectShortcut</th>
			<th>TeacherId</th>
			<th>TeacherName</th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td><c:out value = "${row.tudentId}"/></td>
               <td><c:out value = "${row.StudentName}"/></td>
               <td><c:out value = "${row.ClassID}"/></td>
               <td><c:out value = "${row.Section}"/></td>
               <td><c:out value = "${row.subjectId}"/></td>
               <td><c:out value = "${row.SubjectName}"/></td>
               <td><c:out value = "${row.SubjectShortcut}"/></td>
               <td><c:out value = "${row.TeacherId}"/></td>
               <td><c:out value = "${row.TeacherName}"/></td>
            </tr>
         </c:forEach>
      </table>











	</div>
</body>
</html>










