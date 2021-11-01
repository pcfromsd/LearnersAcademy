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

import com.simplilearn.entity.Subject;
import com.simplilearn.util.HibernateUtil;

public class UpdateSubject extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateSubject() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Subject subjectU = new Subject();
		Transaction transaction = null;		

		String subjectname = request.getParameter("subjectname");
		String subjectshortcut = request.getParameter("subjectshortcut");
		String CRUDId = request.getParameter("CRUDId");
		int subjectId = -1;
		
		if (CRUDId.equalsIgnoreCase("U"))
			subjectId = Integer.parseInt(request.getParameter("subjectid"));

		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();
	
			subjectU.setSubjectName(subjectname);
			subjectU.setSubjectShortcut(subjectshortcut);
			if (CRUDId.equalsIgnoreCase("U"))
				subjectU.setSubjectId(subjectId);

	        transaction = session.beginTransaction();
			if (CRUDId.equalsIgnoreCase("U"))
		        session.update(subjectU);
			else
				session.save(subjectU);

	        transaction.commit();
			
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
			request.getRequestDispatcher("dashboard.jsp?subjects=" + jsonArray.toString()).forward(request, response);

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

