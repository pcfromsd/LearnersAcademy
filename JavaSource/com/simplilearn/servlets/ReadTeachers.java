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

import com.simplilearn.entity.Teacher;
import com.simplilearn.util.HibernateUtil;

public class ReadTeachers extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadTeachers() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//Teacher teacherI = new Teacher();
		//Transaction transaction = null;
		
		
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			
			/*
			teacherI.setTeacherName("TeacherIFnameX TeacherILnameX");
			teacherI.setTeacherId(3);
	            // start a transaction
	            transaction = session.beginTransaction();
	            // save the student objects
	            //session.save(teacherI);
	            session.update(teacherI);
	            // commit transaction
	            transaction.commit();
			*/
			
			
			
			List<Teacher> teacherList = session.createQuery("select _teacher from Teacher _teacher").getResultList();
			PrintWriter out = response.getWriter();
			out.println("teacherList" + teacherList);

			List<HashMap<Object, Object>> teachersMapList = new ArrayList<>();
			for (Teacher teacher : teacherList) {
				HashMap<Object, Object> teacherMap = new HashMap<>();
				teacherMap.put("teacherName", teacher.getTeacherName());
				teacherMap.put("teacherId", teacher.getTeacherId());
				teachersMapList.add(teacherMap);
			}
			JSONArray jsonArray = new JSONArray(teachersMapList);
			request.getRequestDispatcher("dashboard.jsp?teachers=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {

			/*
            if (transaction != null) {
                transaction.rollback();
            }
			*/
			
			
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

