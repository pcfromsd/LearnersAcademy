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

import com.simplilearn.entity.ClassTeacherView;
import com.simplilearn.entity.ClassTeacher;
import com.simplilearn.util.HibernateUtil;

public class AssignTeacherToClass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AssignTeacherToClass() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ClassTeacher ctU = new ClassTeacher();
		Transaction transaction = null;		

		int Id = -1;
		int classId = Integer.parseInt(request.getParameter("classid"));
		int teacherId = Integer.parseInt(request.getParameter("teacherid"));
		String CRUDId = request.getParameter("CRUDId");
		
		if (CRUDId.equalsIgnoreCase("U"))
			Id = Integer.parseInt(request.getParameter("Id"));

		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();
	
			ctU.setClassId(classId);
			ctU.setTeacherId(teacherId);
			if (CRUDId.equalsIgnoreCase("U"))
				ctU.setId(Id);

	        transaction = session.beginTransaction();
	        /*
	        if (CRUDId.equalsIgnoreCase("U"))
		        session.update(ctU);
			else
				session.save(ctU);
			*/
			session.save(ctU);
	        transaction.commit();

			List<ClassTeacherView> classTeacherViewList = session.createQuery("select _ctv from ClassTeacherView _ctv").getResultList();
			PrintWriter out = response.getWriter();
			out.println("classTeacherViewList" + classTeacherViewList);

			List<HashMap<Object, Object>> classTeacherViewMapList = new ArrayList<>();
			for (ClassTeacherView classTeacherView : classTeacherViewList) {
				HashMap<Object, Object> classTeacherViewMap = new HashMap<>();
				classTeacherViewMap.put("classId", classTeacherView.getClassId());
				classTeacherViewMap.put("section", classTeacherView.getSection());
				classTeacherViewMap.put("subjectId", classTeacherView.getSubjectId());
				classTeacherViewMap.put("subjectName", classTeacherView.getSubjectName());	
				classTeacherViewMap.put("subjectShortcut", classTeacherView.getSubjectShortcut());
				classTeacherViewMap.put("teacherId", classTeacherView.getTeacherId());
				classTeacherViewMap.put("teacherName", classTeacherView.getTeacherName());				
				classTeacherViewMapList.add(classTeacherViewMap);
			}
			JSONArray jsonArray = new JSONArray(classTeacherViewMapList);
			request.getRequestDispatcher("dashboard.jsp?classTeacherView=" + jsonArray.toString()).forward(request, response);
	        
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

