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

import com.simplilearn.entity.Studentv;
import com.simplilearn.util.HibernateUtil;

public class ReadStudentvs extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadStudentvs() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<Studentv> studentvsList = session.createQuery("select _studentv from Studentv _studentv").getResultList();
			PrintWriter out = response.getWriter();
			out.println("studentvsList" + studentvsList);

			List<HashMap<Object, Object>> studentvsMapList = new ArrayList<>();
			for (Studentv studentv : studentvsList) {
				HashMap<Object, Object> stduentvMap = new HashMap<>();
				stduentvMap.put("id", studentv.getId());
				stduentvMap.put("studentId", studentv.getStudentId());
				stduentvMap.put("studentName", studentv.getStudentName());				
				stduentvMap.put("studentGrade", studentv.getStudentGrade());				
				stduentvMap.put("classId", studentv.getClassId());
				stduentvMap.put("section", studentv.getSection());
				stduentvMap.put("subjectId", studentv.getSubjectId());
				stduentvMap.put("subjectName", studentv.getSubjectName());
				stduentvMap.put("subjectShortcut", studentv.getSubjectShortcut());
				stduentvMap.put("teacherId", studentv.getTeacherId());
				stduentvMap.put("teacherName", studentv.getTeacherName());				
				studentvsMapList.add(stduentvMap);
			}
			JSONArray jsonArray = new JSONArray(studentvsMapList);
			request.getRequestDispatcher("dashboard.jsp?studentvs=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
