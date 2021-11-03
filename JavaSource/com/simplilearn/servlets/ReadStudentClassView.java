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

import com.simplilearn.entity.StudentClassView;
import com.simplilearn.util.HibernateUtil;

public class ReadStudentClassView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadStudentClassView() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			SessionFactory factory = HibernateUtil.getSessionFactory();
			Session session = factory.openSession();

			List<StudentClassView> studentClassViewList = session.createQuery("select _scv from StudentClassView _scv").getResultList();
			PrintWriter out = response.getWriter();
			out.println("studentClassViewList" + studentClassViewList);

			List<HashMap<Object, Object>> studentClassViewMapList = new ArrayList<>();
			for (StudentClassView studentClassView : studentClassViewList) {
				HashMap<Object, Object> studentClassViewMap = new HashMap<>();
				studentClassViewMap.put("Id", studentClassView.getId());
				studentClassViewMap.put("studentId", studentClassView.getStudentId());
				studentClassViewMap.put("studentName", studentClassView.getStudentName());
				studentClassViewMap.put("studentGrade", studentClassView.getStudentGrade());
				studentClassViewMap.put("classId", studentClassView.getClassId());
				studentClassViewMap.put("section", studentClassView.getSection());
				studentClassViewMap.put("subjectId", studentClassView.getSubjectId());
				studentClassViewMap.put("subjectName", studentClassView.getSubjectName());	
				studentClassViewMap.put("subjectShortcut", studentClassView.getSubjectShortcut());
				studentClassViewMapList.add(studentClassViewMap);
			}
			JSONArray jsonArray = new JSONArray(studentClassViewMapList);
			request.getRequestDispatcher("dashboard.jsp?studentClassView=" + jsonArray.toString()).forward(request, response);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

