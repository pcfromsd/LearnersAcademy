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

import com.simplilearn.entity.Teacher;
import com.simplilearn.util.HibernateUtil;

public class AddTeacherForUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddTeacherForUpdate() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<Teacher> teacherList = session.createQuery("select _teacher from Teacher _teacher").getResultList();
			PrintWriter out = response.getWriter();
			out.println("teacherList" + teacherList);

			List<HashMap<Object, Object>> teachersMapList = new ArrayList<>();
			for (Teacher teacher : teacherList) {
				HashMap<Object, Object> teacherMap = new HashMap<>();
				teacherMap.put("teacherId", teacher.getTeacherId());
				teacherMap.put("teacherName", teacher.getTeacherName());
				teachersMapList.add(teacherMap);
			}
			JSONArray jsonArray = new JSONArray(teachersMapList);
			request.getRequestDispatcher("dashboard.jsp?addTeacherForUpdate=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
