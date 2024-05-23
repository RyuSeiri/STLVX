package com.syau.po;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 习题和答案的实体类（ps：包含文章的信息但是没有文件的信息）
 */
@Entity
@Table(name="TB_PRAXIS")
public class PraxisAnserBean {
    @Id
	private String sArticleId;
	private String sTitle;
	private int iArticleKind;
	private String sAuthorId;
	@Temporal(TemporalType.DATE)
	private Date dMakeTime;
	private String sContent;
	@Column(name="PRAXIS_INFO")
	private String praxisInfo;
	@Column(name="ANSWER_INFO")
	private String answerInfo;
	public String getsArticleId() {
		return sArticleId;
	}
	public void setsArticleId(String sArticleId) {
		this.sArticleId = sArticleId;
	}
	public String getsTitle() {
		return sTitle;
	}
	public void setsTitle(String sTitle) {
		this.sTitle = sTitle;
	}
	public int getiArticleKind() {
		return iArticleKind;
	}
	public void setiArticleKind(int iArticleKind) {
		this.iArticleKind = iArticleKind;
	}
	public String getsAuthorId() {
		return sAuthorId;
	}
	public void setsAuthorId(String sAuthorId) {
		this.sAuthorId = sAuthorId;
	}
	public Date getdMakeTime() {
		return dMakeTime;
	}
	public void setdMakeTime(Date dMakeTime) {
		this.dMakeTime = dMakeTime;
	}
	public String getsContent() {
		return sContent;
	}
	public void setsContent(String sContent) {
		this.sContent = sContent;
	}
	public String getPraxisInfo() {
		return praxisInfo;
	}
	public void setPraxisInfo(String praxisInfo) {
		this.praxisInfo = praxisInfo;
	}
	public String getAnswerInfo() {
		return answerInfo;
	}
	public void setAnswerInfo(String answerInfo) {
		this.answerInfo = answerInfo;
	}

	
}
