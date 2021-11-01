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

import com.simplilearn.entity.ClassSubjectView;
import com.simplilearn.util.HibernateUtil;

public class ReadClassSubjectView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadClassSubjectView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<ClassSubjectView> classSubjectViewList = session.createQuery("select _classSubjectView from ClassSubjectView _classSubjectView").getResultList();
			PrintWriter out = response.getWriter();
			out.println("subjectList" + classSubjectViewList);

			List<HashMap<Object, Object>> classSubjectViewsMapList = new ArrayList<>();
			for (ClassSubjectView classSubjectView : classSubjectViewList) {
				HashMap<Object, Object> classSubjectViewMap = new HashMap<>();
				classSubjectViewMap.put("classId", classSubjectView.getClassId());
				classSubjectViewMap.put("section", classSubjectView.getSection());
				classSubjectViewMap.put("subjectId", classSubjectView.getSubjectId());				
				classSubjectViewMap.put("subjectId", classSubjectView.getSubjectId());				
				classSubjectViewMap.put("subjectName", classSubjectView.getSubjectName());				
				classSubjectViewMap.put("subjectShortcut", classSubjectView.getSubjectShortcut());				
				classSubjectViewsMapList.add(classSubjectViewMap);
			}
			JSONArray jsonArray = new JSONArray(classSubjectViewsMapList);
			request.getRequestDispatcher("dashboard.jsp?classSubjectView=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

