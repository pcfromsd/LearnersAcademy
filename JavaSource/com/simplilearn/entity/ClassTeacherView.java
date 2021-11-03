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
@Table(name = "ClassTeacherView")
public class ClassTeacherView {

	@Id
	private int classId;
	private String section;
    private int subjectId;
    private String subjectName; 
    private String subjectShortcut; 
    private Integer teacherId; 
    private String teacherName;   

    
	public ClassTeacherView() {
	}

	
	public int getClassId() {
		return classId;
	}

	public void setClassId(int classId) {
		this.classId = classId;
	}
	
	public int getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(int subjectId) {
		this.subjectId = subjectId;
	}
	
	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getSubjectShortcut() {
		return subjectShortcut;
	}

	public void setSubjectShortcut(String subjectShortcut) {
		this.subjectShortcut = subjectShortcut;
	}
	
	public int getTeacherId() {
		//if (teacherId.equals(null))
		if (teacherId == null)
			return -1;
		else	
			return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}	
	
	public String getTeacherName() {
		try {
			return teacherName;
		}
		catch (Exception e)
		{
			return "<NULL>";
		}
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
		
}
