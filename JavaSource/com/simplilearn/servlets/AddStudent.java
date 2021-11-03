package com.simplilearn.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.json.JSONArray;
import org.json.JSONObject;

import com.simplilearn.entity.Student;
import com.simplilearn.util.HibernateUtil;

public class AddStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddStudent() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<Student> studentList = session.createQuery("select _student from Student _student").getResultList();
			PrintWriter out = response.getWriter();
			out.println("studentList" + studentList);

			List<HashMap<Object, Object>> studentsMapList = new ArrayList<>();
			for (Student student : studentList) {
				HashMap<Object, Object> studentMap = new HashMap<>();
				studentMap.put("studentId", student.getStudentId());
				studentMap.put("studentName", student.getStudentName());
				studentMap.put("studentGrade", student.getStudentGrade());
				studentsMapList.add(studentMap);
			}
			JSONArray jsonArray = new JSONArray(studentsMapList);
			request.getRequestDispatcher("dashboard.jsp?addStudent=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

