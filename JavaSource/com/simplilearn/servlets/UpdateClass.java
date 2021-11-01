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

import com.simplilearn.entity.Classs;
import com.simplilearn.util.HibernateUtil;

public class UpdateClass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateClass() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Classs classU = new Classs();
		Transaction transaction = null;		

		int classId = -1;
		int subjectId = Integer.parseInt(request.getParameter("subjectid"));
		//int subjectId = 2;
		String section = request.getParameter("section");
		String CRUDId = request.getParameter("CRUDId");
		
		if (CRUDId.equalsIgnoreCase("U"))
			classId = Integer.parseInt(request.getParameter("classId"));

		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();
	
			classU.setSubjectId(subjectId);
			classU.setSection(section);
			if (CRUDId.equalsIgnoreCase("U"))
				classU.setClassId(classId);

	        transaction = session.beginTransaction();
			if (CRUDId.equalsIgnoreCase("U"))
		        session.update(classU);
			else
				session.save(classU);

	        transaction.commit();

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

