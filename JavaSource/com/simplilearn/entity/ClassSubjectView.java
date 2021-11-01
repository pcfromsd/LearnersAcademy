package com.simplilearn.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import java.util.List;
import org.immutables.value.Value.Immutable;

//@Entity
//@Table(name = "ClassSubjectView")

@Entity
@Immutable
@Table(name = "ClassSubjectView")
public class ClassSubjectView {

	//@Id
	//@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private int classId;
	private String section;
    private int subjectId;
    private String subjectName; 
    private String subjectShortcut;

	public ClassSubjectView() {
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




}
