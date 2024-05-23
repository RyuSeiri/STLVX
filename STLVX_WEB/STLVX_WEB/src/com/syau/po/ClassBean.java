package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "TB_CLASS")
public class ClassBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "CLASS_ID")
	private String classId;

	@Column(name = "CLASS_NAME")
	private String className;
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getDelFlg() {
		return delFlg;
	}
	public void setDelFlg(int delFlg) {
		this.delFlg = delFlg;
	}
	@Column(name = "DEL_FLG")
	private int delFlg = 0;

}
