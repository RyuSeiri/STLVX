package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tb_student")
public class StudentBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String sStudentId;

	private String sUsername;
	private String sClassId;
	@Column(name = "DEL_FLG")
	private int delFlg = 0;

	public String getsClassId() {
		return sClassId;
	}

	public void setsClassId(String sClassId) {
		this.sClassId = sClassId;
	}

	private String sPassword;

	public int getDelFlg() {
		return delFlg;
	}

	public void setDelFlg(int delFlg) {
		this.delFlg = delFlg;
	}

	public String getSStudentId() {
		return sStudentId;
	}

	public void setSStudentId(String sStudentId) {
		this.sStudentId = sStudentId;
	}

	public String getSUsername() {
		return sUsername;
	}

	public void setSUsername(String sUsername) {
		this.sUsername = sUsername;
	}

	public String getSPassword() {
		return sPassword;
	}

	public void setSPassword(String sPassword) {
		this.sPassword = sPassword;
	}
}
