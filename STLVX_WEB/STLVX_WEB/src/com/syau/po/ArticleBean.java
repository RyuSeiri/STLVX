package com.syau.po;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 文章及其文章的路径的实体类
 * @author Dell
 *
 */
@Entity
@Table(name = "TB_ARTICLE")
public  class ArticleBean {
	
	@Id
	private String sArticleId;
	private String sTitle;
	@Column(updatable=false)
	private int iArticleKind;
	@Column(updatable=false)
	private String sAuthorId;
	@Temporal(TemporalType.DATE)
	@Column(updatable=false)
	private Date dMakeTime;
	private String sContent;
	@Column(updatable=false)
	private String filepath;
	@Column(name = "DEL_FLG")
	private int delFlg;
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
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public int getDelFlg() {
		return delFlg;
	}
	public void setDelFlg(int delFlg) {
		this.delFlg = delFlg;
	}
	/*手机版的文章详情页标题用*/
	public static final String Title[] = { "课程简介", "课程大纲", "教学日历", "考试形式", "知识导学", "讲稿", "教案 ",
			"课件", "授课视频", "习题", "产品设计要求", "产品设计过程 ", "产品设计结果", "课程案例",
			"环境教育大纲", "环境教育效果", "图片信息", "扩展学习" };

	public static String getTitle(int kind) {
		return Title[kind];
	}
}
