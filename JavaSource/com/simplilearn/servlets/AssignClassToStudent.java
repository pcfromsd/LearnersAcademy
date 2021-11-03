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

import com.simplilearn.entity.StudentClassView;
import com.simplilearn.entity.Student_Class;
import com.simplilearn.util.HibernateUtil;

public class AssignClassToStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AssignClassToStudent() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Student_Class scU = new Student_Class();
		Transaction transaction = null;		

		int Id = -1;
		int studentId = Integer.parseInt(request.getParameter("studentid"));
		int classId = Integer.parseInt(request.getParameter("classid"));
		String CRUDId = request.getParameter("CRUDId");
		
		if (CRUDId.equalsIgnoreCase("U"))
			Id = Integer.parseInt(request.getParameter("Id"));

		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();
	
			scU.setStudentId(studentId);
			scU.setClassId(classId);
			if (CRUDId.equalsIgnoreCase("U"))
				scU.setId(Id);

	        transaction = session.beginTransaction();
	        if (CRUDId.equalsIgnoreCase("U"))
		        session.update(scU);
			else
				session.save(scU);
			//session.save(scU);
	        transaction.commit();

			List<StudentClassView> studentClassViewList = session.createQuery("select _scv from StudentClassView _scv").getResultList();
			PrintWriter out = response.getWriter();
			out.println("studentClassViewList" + studentClassViewList);

			List<HashMap<Object, Object>> studentClassViewMapList = new ArrayList<>();
			for (StudentClassView studentClassView : studentClassViewList) {
				HashMap<Object, Object> studentClassViewMap = new HashMap<>();
				studentClassViewMap.put("Id", studentClassView.getId());
				studentClassViewMap.put("studentId", studentClassView.getStudentId());
				studentClassViewMap.put("studentName", studentClassView.getStudentName());
				studentClassViewMap.put("studentGrade", studentClassView.getStudentGrade());
				studentClassViewMap.put("classId", studentClassView.getClassId());
				studentClassViewMap.put("section", studentClassView.getSection());
				studentClassViewMap.put("subjectId", studentClassView.getSubjectId());
				studentClassViewMap.put("subjectName", studentClassView.getSubjectName());	
				studentClassViewMap.put("subjectShortcut", studentClassView.getSubjectShortcut());
				studentClassViewMapList.add(studentClassViewMap);
			}
			JSONArray jsonArray = new JSONArray(studentClassViewMapList);
			request.getRequestDispatcher("dashboard.jsp?studentClassView=" + jsonArray.toString()).forward(request, response);
	        
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

