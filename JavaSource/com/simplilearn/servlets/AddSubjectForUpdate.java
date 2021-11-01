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

import com.simplilearn.entity.Subject;
import com.simplilearn.util.HibernateUtil;

public class AddSubjectForUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddSubjectForUpdate() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<Subject> subjectList = session.createQuery("select _subject from Subject _subject").getResultList();
			PrintWriter out = response.getWriter();
			out.println("subjectList" + subjectList);

			List<HashMap<Object, Object>> subjectsMapList = new ArrayList<>();
			for (Subject subject : subjectList) {
				HashMap<Object, Object> subjectMap = new HashMap<>();
				subjectMap.put("subjectId", subject.getSubjectId());
				subjectMap.put("subjectName", subject.getSubjectName());
				subjectMap.put("subjectShortcut", subject.getSubjectShortcut());
				subjectsMapList.add(subjectMap);
			}
			JSONArray jsonArray = new JSONArray(subjectsMapList);
			request.getRequestDispatcher("dashboard.jsp?addSubjectForUpdate=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
