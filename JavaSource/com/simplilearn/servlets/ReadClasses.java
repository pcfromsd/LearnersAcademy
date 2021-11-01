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

import com.simplilearn.entity.Classs;
import com.simplilearn.util.HibernateUtil;

public class ReadClasses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadClasses() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<Classs> classsList = session.createQuery("select _classs from Classs _classs").getResultList();
			PrintWriter out = response.getWriter();
			out.println("classsList" + classsList);

			List<HashMap<Object, Object>> classesMapList = new ArrayList<>();
			for (Classs classs : classsList) {
				HashMap<Object, Object> classsMap = new HashMap<>();
				classsMap.put("classId", classs.getClassId());
				classsMap.put("subjectId", classs.getSubjectId());
				classsMap.put("section", classs.getSection());				
				classesMapList.add(classsMap);
			}
			JSONArray jsonArray = new JSONArray(classesMapList);
			request.getRequestDispatcher("dashboard.jsp?classes=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

