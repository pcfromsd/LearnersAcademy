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

import com.simplilearn.entity.ClassTeacherView;
import com.simplilearn.util.HibernateUtil;

public class ReadClassTeacherView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadClassTeacherView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

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

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

