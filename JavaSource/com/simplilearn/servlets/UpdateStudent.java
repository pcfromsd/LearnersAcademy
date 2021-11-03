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
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONObject;

import com.simplilearn.entity.Student;
import com.simplilearn.util.HibernateUtil;

public class UpdateStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateStudent() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Student studentU = new Student();
		Transaction transaction = null;		

		int studentId = -1;
		String studentName = request.getParameter("studentname");
		String studentGrade = request.getParameter("studentgrade");
		String CRUDId = request.getParameter("CRUDId");
		
		if (CRUDId.equalsIgnoreCase("U"))
			studentId = Integer.parseInt(request.getParameter("studentid"));

		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();
	
			studentU.setStudentName(studentName);
			studentU.setStudentGrade(studentGrade);

			if (CRUDId.equalsIgnoreCase("U"))
				studentU.setStudentId(studentId);

	        transaction = session.beginTransaction();
			if (CRUDId.equalsIgnoreCase("U"))
		        session.update(studentU);
			else
				session.save(studentU);

	        transaction.commit();

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
			request.getRequestDispatcher("dashboard.jsp?students=" + jsonArray.toString()).forward(request, response);

		} 
		catch (Exception ex) {

            if (transaction != null) {
                transaction.rollback();
            }
			
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

