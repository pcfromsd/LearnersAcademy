<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
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
	<%
		String usernameSession = (String) session.getAttribute("username");
		if (session.getAttribute("username") == null) {
			response.sendRedirect("invalid.jsp?error=1");
		}
	%>
	<div class="container mt-3">

		<table class="table table-striped">
			<tbody>
				<tr align= "right">
					<td>
					    <a href="ReadSubjects"> <button class="btn btn-primary">Subjects</button></a>
					    <a href="ReadTeachers"> <button class="btn btn-primary">Teachers</button></a>
					    <a href="ReadClasses"> <button class="btn btn-primary">Classes</button></a>
					    <a href="ReadStudents"> <button class="btn btn-primary">Students</button></a>
					    <!-- <a href="AssignClass"> <button>Assign Class to Student</button></a>  -->
					    <a href="ReadStudentClassView"> <button>Assign Class to Student</button></a>
					    <!-- <a href="AssignTeacher"> <button>Assign Teacher to Class</button></a>  -->
					    <a href="ReadClassTeacherView"> <button>Assign Teacher to Class</button></a>
					    <a href="ReadStudentvs"> <button class="btn btn-primary">Student Details</button></a>
					    					    
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
			<!--
		  	<a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a>
		  	<a href="ReadSubjects"> <button class="btn btn-primary">View Subjects</button></a>
		  	<a href="ReadTeachers"> <button class="btn btn-primary">View Teachers</button></a>
		  	<a href="classes"> <button class="btn btn-primary">View Classes</button></a>
		  	<a href="ReadStudents"> <button class="btn btn-primary">View Students</button></a>
		  	-->
		    <%
			String students = request.getParameter("students");
			String teachers = request.getParameter("teachers");
			String subjects = request.getParameter("subjects");
			String classes  = request.getParameter("classes");
			String addClass = request.getParameter("addClass");
			String addStudent = request.getParameter("addStudent");
			String addSubject = request.getParameter("addSubject");
			String addSubjectForUpdate = request.getParameter("addSubjectForUpdate");
			String addTeacher = request.getParameter("addTeacher");
			String addTeacherForUpdate = request.getParameter("addTeacherForUpdate");			
			String classSubjectView = request.getParameter("classSubjectView");
			String studentvs = request.getParameter("studentvs");
			String classTeacherView = request.getParameter("classTeacherView");		
			String studentClassView = request.getParameter("studentClassView");
			
			if (Objects.nonNull(students)) {
			%>
				<br/>
				<p><b><h4>List of Students</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Student Id</th>
							<th>Student Name</th>
							<th>Student Grade</th>
						</tr>
					</thead>
					<tbody>
						    <%
							List<HashMap<Object, Object>> studentsList = new ObjectMapper().readValue(students, List.class);
		
								for (HashMap<Object, Object> eachMap : studentsList) {
									int studentId = (Integer) eachMap.get("studentId");
									String studentName = (String) eachMap.get("studentName");
									String studentGrade = (String) eachMap.get("studentGrade");
							%>
									<tr>
										<td><%=studentId%></td>
										<td><%=studentName%></td>
										<td><%=studentGrade%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>

				</br></br></br>
				<table>
					<tbody>
						<tr align= "right">
							<td>
					    		<a href="AddStudent"> <button class="btn btn-primary">Add a Student</button></a>
							</td>
						</tr>
					</tbody>
				</table>				
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(addStudent)) {
			%>
				<br/>
				<p><b><h4>List of Existing Students</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Student Id</th>
							<th>Student Name</th>
							<th>Student Grade</th>
						</tr>
					</thead>
					
					<tbody>
						    <%
							List<HashMap<Object, Object>> studentsList = new ObjectMapper().readValue(addStudent, List.class);
		
								for (HashMap<Object, Object> eachMap : studentsList) {
									int studentId = (Integer) eachMap.get("studentId");
									String studentName = (String) eachMap.get("studentName");
									String studentGrade = (String) eachMap.get("studentGrade");
							%>
									<tr>
										<td><%=studentId%></td>
										<td><%=studentName%></td>
										<td><%=studentGrade%></td>
									</tr>
								<%
								}
						        %>
					</tbody>					
				</table>

				</br></br>
				<p><b><h4>Add a New Student</h4></b></p>
				<form action="UpdateStudent" method="post">
					<div class="form-group">
						<label for="studentName">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Student Name:</label> 
						<input type="text" id="studentname" name="studentname" size="50">
					</div>

					<div class="form-group">
						<label for="studentGrade">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Student Grade:</label> 
						<input type="text" id="studentname" name="studentgrade" size="50">
					</div>


					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="I">
				</form>
			<%				
			}
		    %>


			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(classSubjectView)) {
			%>
				<br/>
				<p><b><h4>List of Classes</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>ClassId</th>
							<th>Section</th>
							<th>SubjectId</th>
							<th>SubjectName</th>
							<th>SubjectShortcut</th>
						</tr>
					</thead>
				</table>
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(subjects)) {
			%>
				<br/>
				<p><b><h4>List of Subjects</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
							<th>Shortcut</th>
						</tr>
					</thead>
					<tbody>
						    <%
							List<HashMap<Object, Object>> subjectsList = new ObjectMapper().readValue(subjects, List.class);
		
								for (HashMap<Object, Object> eachMap : subjectsList) {
									int subjectId = (Integer) eachMap.get("subjectId");
									String subjectName = (String) eachMap.get("subjectName");
									String subjectShortcut = (String) eachMap.get("subjectShortcut");
							%>
									<tr>
										<td><%=subjectId%></td>
										<td><%=subjectName%></td>
										<td><%=subjectShortcut%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>
								
				</br></br></br>
				<table>
					<tbody>
						<tr align= "right">
							<td>
					    		<a href="AddSubject"> <button class="btn btn-primary">Add a Subject</button></a>
					    		<a href="AddSubjectForUpdate"> <button class="btn btn-primary">Update a Subject</button></a>
							</td>
						</tr>
					</tbody>
				</table>				
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(addSubject)) {
			%>
				<br/>
				<p><b><h4>List of Existing Subjects</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
							<th>Shortcut</th>
						</tr>
					</thead>


					<tbody>
						    <%
							List<HashMap<Object, Object>> subjectsList = new ObjectMapper().readValue(addSubject, List.class);
		
								for (HashMap<Object, Object> eachMap : subjectsList) {
									int subjectId = (Integer) eachMap.get("subjectId");
									String subjectName = (String) eachMap.get("subjectName");
									String subjectShortcut = (String) eachMap.get("subjectShortcut");
							%>
									<tr>
										<td><%=subjectId%></td>
										<td><%=subjectName%></td>
										<td><%=subjectShortcut%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>

				</br></br>
				<p><b><h4>Add a New Subject</h4></b></p>
				<form action="UpdateSubject" method="post">
					<div class="form-group">
						<label for="subjectname">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject Name:</label> 
						<input type="text" id="subjectname" name="subjectname" size="50">
					</div>
					<div class="form-group">
						<label for="subjectshortcut">Subject Shortcut:</label> 
						<input type="text" id="subjectshortcut" name="subjectshortcut" size="50">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="I">
				</form>
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(addSubjectForUpdate)) {
			%>
				<br/>
				<p><b><h4>List of Existing Subjects</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
							<th>Shortcut</th>
						</tr>
					</thead>


					<tbody>
						    <%
							List<HashMap<Object, Object>> subjectsList = new ObjectMapper().readValue(addSubjectForUpdate, List.class);
		
								for (HashMap<Object, Object> eachMap : subjectsList) {
									int subjectId = (Integer) eachMap.get("subjectId");
									String subjectName = (String) eachMap.get("subjectName");
									String subjectShortcut = (String) eachMap.get("subjectShortcut");
							%>
									<tr>
										<td><%=subjectId%></td>
										<td><%=subjectName%></td>
										<td><%=subjectShortcut%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>

				</br></br>
				<p><b><h4>Update a Subject</h4></b></p>
				<form action="UpdateSubject" method="post">
					<div class="form-group">
						<label for="subjectid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject ID:</label> 
						<input type="text" id="subjectid" name="subjectid" size="50">
					</div>
					<div class="form-group">
						<label for="subjectname">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject Name:</label> 
						<input type="text" id="subjectname" name="subjectname" size="50">
					</div>
					<div class="form-group">
						<label for="subjectshortcut">Subject Shortcut:</label> 
						<input type="text" id="subjectshortcut" name="subjectshortcut" size="50">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="U">
				</form>
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(teachers)) {
			%>
				<br/>
				<p><b><h4>List of Teachers</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
						</tr>
					</thead>
					<tbody>
						    <%
							List<HashMap<Object, Object>> teachersList = new ObjectMapper().readValue(teachers, List.class);
		
								for (HashMap<Object, Object> eachMap : teachersList) {
									int teacherId = (Integer) eachMap.get("teacherId");
									String teacherName = (String) eachMap.get("teacherName");
							%>
									<tr>
										<td><%=teacherId%></td>
										<td><%=teacherName%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>

				</br></br></br>
				<table>
					<tbody>
						<tr align= "right">
							<td>
					    		<a href="AddTeacher"> <button class="btn btn-primary">Add a Teacher</button></a>
					    		<a href="AddTeacherForUpdate"> <button class="btn btn-primary">Update a Teacher</button></a>
							</td>
						</tr>
					</tbody>
				</table>				
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(addTeacher)) {
			%>
				<br/>
				<p><b><h4>List of Existing Teachers</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
						</tr>
					</thead>


					<tbody>
						    <%
							List<HashMap<Object, Object>> teachersList = new ObjectMapper().readValue(addTeacher, List.class);
		
								for (HashMap<Object, Object> eachMap : teachersList) {
									int teacherId = (Integer) eachMap.get("teacherId");
									String teacherName = (String) eachMap.get("teacherName");
							%>
									<tr>
										<td><%=teacherId%></td>
										<td><%=teacherName%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>

				</br></br>
				<p><b><h4>Add a New Teacher</h4></b></p>
				<form action="UpdateTeacher" method="post">
					<div class="form-group">
						<label for="teachername">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Teacher Name:</label> 
						<input type="text" id="teachername" name="teachername" size="50">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="I">
				</form>
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(addTeacherForUpdate)) {
			%>
				<br/>
				<p><b><h4>List of Existing Teachers</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
						</tr>
					</thead>
					<tbody>
						    <%
							List<HashMap<Object, Object>> teachersList = new ObjectMapper().readValue(addTeacherForUpdate, List.class);
		
								for (HashMap<Object, Object> eachMap : teachersList) {
									int teacherId = (Integer) eachMap.get("teacherId");
									String teacherName = (String) eachMap.get("teacherName");
							%>
									<tr>
										<td><%=teacherId%></td>
										<td><%=teacherName%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>

				</br></br>
				<p><b><h4>Update a Teacher</h4></b></p>
				<form action="UpdateTeacher" method="post">
					<div class="form-group">
						<label for="teacherid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Teacher ID:</label> 
						<input type="text" id="teacherid" name="teacherid" size="50">
					</div>
					<div class="form-group">
						<label for="teachername">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Teacher Name:</label> 
						<input type="text" id="teachername" name="teachername" size="50">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="U">
				</form>
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(classes)) {
			%>
				<br/>
				<p><b><h4>List of Classes</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Class Id</th>
							<th>Section</th>
							<th>Subject Id</th>
						</tr>
					</thead>
					
					<tbody>
						    <%
							List<HashMap<Object, Object>> classesList = new ObjectMapper().readValue(classes, List.class);
		
								for (HashMap<Object, Object> eachMap : classesList) {
									int classtId = (Integer) eachMap.get("classId");
									String section = (String) eachMap.get("section");
									int subjectId = (Integer) eachMap.get("subjectId");
							%>
									<tr>
										<td><%=classtId%></td>
										<td><%=section%></td>
										<td><%=subjectId%></td>
									</tr>
								<%
								}
						        %>
					</tbody>					
				</table>

				</br></br></br>
				<table>
					<tbody>
						<tr align= "right">
							<td>
					    		<a href="AddClass"> <button class="btn btn-primary">Add a New Class</button></a>
					    		<!--
					    		<a href="AddClassForUpdate"> <button class="btn btn-primary">Update a class</button></a>
					    		-->
							</td>
						</tr>
					</tbody>
				</table>								
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(addClass)) {
			%>
				<br/>
				<p><b><h4>List of Existing Classes</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Class Id</th>
							<th>Section</th>
							<th>Subject Id</th>
						</tr>
					</thead>
					
					<tbody>
						    <%
							List<HashMap<Object, Object>> classesList = new ObjectMapper().readValue(addClass, List.class);
		
								for (HashMap<Object, Object> eachMap : classesList) {
									int classtId = (Integer) eachMap.get("classId");
									String section = (String) eachMap.get("section");
									int subjectId = (Integer) eachMap.get("subjectId");
							%>
									<tr>
										<td><%=classtId%></td>
										<td><%=section%></td>
										<td><%=subjectId%></td>
									</tr>
								<%
								}
						        %>
					</tbody>					
				</table>

				</br></br>
				<p><b><h4>Add a New Class</h4></b></p>
				<form action="UpdateClass" method="post">
					<div class="form-group">
						<label for="section">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section:</label> 
						<input type="text" id="section" name="section" size="50">
					</div>
					<div class="form-group">
						<label for="subjectid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject ID:</label> 
						<input type="text" id="subjectid" name="subjectid" size="50">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="I">
				</form>
			<%				
			}
		    %>

			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(studentvs)) {
			%>
				<br/>
				<p><b><h4>Students Master List</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Student Id</th>
							<th>Student Name</th>
							<th>Student Grade</th>
  							<th>Class Id</th>
  							<th>Section</th>
  							<th>Subject Id</th>
  							<th>Subject Name</th>
  							<th>Subject Shortcut</th>
  							<th>Teacher Id</th>
  							<th>Teacher Name</th>
						</tr>
					</thead>
					<tbody>
						    <%
							List<HashMap<Object, Object>> studentvsList = new ObjectMapper().readValue(studentvs, List.class);
		
								for (HashMap<Object, Object> eachMap : studentvsList) {
									int id = (Integer) eachMap.get("id");
									int studentId = (Integer) eachMap.get("studentId");
									String studentName = (String) eachMap.get("studentName");									
									String studentGrade = (String) eachMap.get("studentGrade");									
									int classId = (Integer) eachMap.get("classId");
									String section = (String) eachMap.get("section");
									int subjectId = (Integer) eachMap.get("subjectId");
									String subjectName = (String) eachMap.get("subjectName");
									String subjectShortcut = (String) eachMap.get("subjectShortcut");
									int teacherId = (Integer) eachMap.get("teacherId");
									String teacherName = (String) eachMap.get("teacherName");
							%>
									<tr>
										<td><%=studentId%></td>
										<td><%=studentName%></td>
										<td><%=studentGrade%></td>
										<td><%=classId%></td>
										<td><%=section%></td>
										<td><%=subjectId%></td>
										<td><%=subjectName%></td>
										<td><%=subjectShortcut%></td>
										<td><%=teacherId%></td>
										<td><%=teacherName%></td>
									</tr>
								<%
								}
						        %>
					</tbody>
				</table>
								
			<%				
			}
		    %>





			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(classTeacherView)) {
			%>
				<br/>
				<p><b><h4>Classes with Teacher Assigned</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Class Id</th>
							<th>Section</th>
							<th>Subject Id</th>
							<th>Subject Name</th>
							<th>Subject Shortcut</th>
							<th>Teacher Id</th>
							<th>Teacher Name</th>
						</tr>
					</thead>

					<tbody>
						    <%
							List<HashMap<Object, Object>> ctViewList = new ObjectMapper().readValue(classTeacherView, List.class);
		
								for (HashMap<Object, Object> eachMap : ctViewList) {
									int classId = (Integer) eachMap.get("classId");
									String section = (String) eachMap.get("section");
									int subjectId = (Integer) eachMap.get("subjectId");
									String subjectName = (String) eachMap.get("subjectName");
									String subjectShortcut = (String) eachMap.get("subjectShortcut");
									int teacherId = (Integer) eachMap.get("teacherId");
									String teacherIdS = Integer.toString(teacherId);
									String ns = "null";
									String teacherName = (String) eachMap.get("teacherName");																		
						            if (teacherId == -1) 
						            	teacherIdS = ns;									
							%>
									<tr>
										<td><%=classId%></td>
										<td><%=section%></td>
										<td><%=subjectId%></td>
										<td><%=subjectName%></td>
										<td><%=subjectShortcut%></td>
										<td><%=teacherIdS%></td>
										<td><%=teacherName%></td>
									</tr>
								<%
								}
						        %>
					</tbody>								
				</table>								


					
				</br></br>
				<p><b><h4>Assign a Teacher to a Class (where no assignment exists)</h4></b></p>
				<form action="AssignTeacherToClass" method="post">
					<div class="form-group">
						<label for="classid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Class ID:</label> 
						<input type="text" id="classid" name="classid" size="10">
					</div>
					<div class="form-group">
						<label for="teacherid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Teacher ID:</label> 
						<input type="text" id="teacherid" name="teacherid" size="50">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="I">
				</form>
					
					
							

			<%				
			}
		    %>




			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->
			<!-- --------------------------------------------------------------------------------------------------------------------- -->

            <%
            if (Objects.nonNull(studentClassView)) {
			%>
				<br/>
				<p><b><h4>Students with Class/Grade Assigned</h4></b></p>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>Student Id</th>
							<th>Student Name</th>
							<th>Student Grade</th>
							<th>Class Id</th>
							<th>Section</th>
							<th>Subject Id</th>
							<th>Subject Name</th>
							<th>Subject Shortcut</th>
						</tr>
					</thead>
					<tbody>
						    <%
							List<HashMap<Object, Object>> scViewList = new ObjectMapper().readValue(studentClassView, List.class);
		
								for (HashMap<Object, Object> eachMap : scViewList) {
									int studentId = (Integer) eachMap.get("studentId");
									String studentName = (String) eachMap.get("studentName");
									String studentGrade = (String) eachMap.get("studentGrade");
									int classId = (Integer) eachMap.get("classId");
									String section = (String) eachMap.get("section");
									int subjectId = (Integer) eachMap.get("subjectId");
									String subjectName = (String) eachMap.get("subjectName");
									String subjectShortcut = (String) eachMap.get("subjectShortcut");


									String classIdS = Integer.toString(classId);
									String subjectIdS = Integer.toString(subjectId);
									String ns = "null";									
						            if (classId == -1) 
						            	classIdS = ns;	
						            if (subjectId == -1) 
						            	subjectIdS = ns;	
						            
							%>
									<tr>
										<td><%=studentId%></td>
										<td><%=studentName%></td>
										<td><%=studentGrade%></td>
										<td><%=classIdS%></td>
										<td><%=section%></td>
										<td><%=subjectIdS%></td>
										<td><%=subjectName%></td>
										<td><%=subjectShortcut%></td>
									</tr>
								<%
								}
						        %>
					</tbody>								
				</table>								

				</br></br>
				<p><b><h4>Assign a Class to a Student (where no assignment exists)</h4></b></p>
				<form action="AssignClassToStudent" method="post">
					<div class="form-group">
						<label for="studentid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Student ID:</label> 
						<input type="text" id="studentid" name="studentid" size="50">
					</div>
					<div class="form-group">
						<label for="classid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Class ID:</label> 
						<input type="text" id="classid" name="classid" size="10">
					</div>
					<button type="submit" class="btn btn-primary">Update Database</button>
					<input type="hidden" id="CRUDId" name="CRUDId" value="I">
				</form>

			<%				
			}
		    %>

	</div>	
</body>
</html>
