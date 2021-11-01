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

public class AddClass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddClass() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<Classs> classList = session.createQuery("select _classs from Classs _classs").getResultList();
			PrintWriter out = response.getWriter();
			out.println("classList" + classList);

			List<HashMap<Object, Object>> classessMapList = new ArrayList<>();
			for (Classs classs : classList) {
				HashMap<Object, Object> classMap = new HashMap<>();
				classMap.put("classId", classs.getClassId());
				classMap.put("section", classs.getSection());
				classMap.put("subjectId", classs.getSubjectId());
				classessMapList.add(classMap);
			}
			JSONArray jsonArray = new JSONArray(classessMapList);
			request.getRequestDispatcher("dashboard.jsp?addClass=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

