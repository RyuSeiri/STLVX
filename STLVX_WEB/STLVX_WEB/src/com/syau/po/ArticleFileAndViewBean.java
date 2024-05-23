package com.syau.po;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 文章及其文章的文件路径（ps：包括文件的类型）的实体类（不包括章节的信息）
 * @author Dell
 *
 */
@Entity
@Table(name="TB_ARTICLE")
public class ArticleFileAndViewBean {
	@Id
	@Column(updatable=false)
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
	@Column(name="FILE_TYPE",updatable=false)
	private int filetype;
	@Column(name = "ARTICLE_OVERVIEWS")
	private int  articleOverViews;
	public int getArticleOverViews() {
		return articleOverViews;
	}
	public void setArticleOverViews(int articleOverViews) {
		this.articleOverViews = articleOverViews;
	}
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
	public int getFiletype() {
		return filetype;
	}
	public void setFiletype(int filetype) {
		this.filetype = filetype;
	}
	
}
