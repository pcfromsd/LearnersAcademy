package com.simplilearn.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import java.util.List;
import org.immutables.value.Value.Immutable;

@Entity
@Immutable
@Table(name = "StudentClassView")
public class StudentClassView {

	@Id
	private int Id;
	
	private int studentId;
	private String studentName;
	private String studentGrade;
	private Integer classId;
	private String section;
	private Integer subjectId;
	private String subjectName;
	private String subjectShortcut;	
		
	public StudentClassView() {
	}


	public int getId() {
		return Id;
	}

	public void setId(int Id) {
		this.Id = Id;
	}
	
	public int getStudentId() {
		return studentId;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	
	
	public String getStudentGrade() {
		return studentGrade;
	}

	public void setStudentGrade(String studentGrade) {
		this.studentGrade = studentGrade;
	}
	
	public int getClassId() {
		if (classId == null)
			return -1;
		else	
			return classId;
	}

	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	
	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}
	
	public int getSubjectId() {
		if (subjectId == null)
			return -1;
		else	
			return subjectId;
	}

	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	
	public String getSubjectName() {
		try {
			return subjectName;
		}
		catch (Exception e)
		{
			return "<NULL>";
		}
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getSubjectShortcut() {
		try {
			return subjectShortcut;
		}
		catch (Exception e)
		{
			return "<NULL>";
		}
	}

	public void setSubjectShortcut(String subjectShortcut) {
		this.subjectShortcut = subjectShortcut;
	}
	
}
