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

import com.simplilearn.entity.StudentView_T;
import com.simplilearn.util.HibernateUtil;

public class ReadStudentMasterList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadStudentMasterList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<StudentView_T> studentView_TList = session.createQuery("select _studentView_T from StudentView_T _studentView_T").getResultList();
			PrintWriter out = response.getWriter();
			out.println("studentView_TList" + studentView_TList);

			List<HashMap<Object, Object>> studentsViewMapList = new ArrayList<>();
			for (StudentView_T studentView_T : studentView_TList) {
				HashMap<Object, Object> stduentMap = new HashMap<>();
				stduentMap.put("Id", studentView_T.getId());
				stduentMap.put("studentId", studentView_T.getStudentId());
				stduentMap.put("studentName", studentView_T.getStudentName());
				studentsViewMapList.add(stduentMap);
			}
			JSONArray jsonArray = new JSONArray(studentsViewMapList);
			request.getRequestDispatcher("dashboard.jsp?studentMasterList=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
