package com.syau.po;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 文章与章节的关系实体类
 */

@Entity
@Table(name="tb_courseoverview")
public class ArticleOverViewBean {
	@Id
	@Column(name="SARTICLEID")
	private String sArticleId;
	@Column(name="ARTICLE_OVERVIEWS")
	private int articleOverViews;
	public String getsArticleId() {
		return sArticleId;
	}
	public void setsArticleId(String sArticleId) {
		this.sArticleId = sArticleId;
	}
	public int getArticleOverViews() {
		return articleOverViews;
	}
	public void setArticleOverViews(int articleOverViews) {
		this.articleOverViews = articleOverViews;
	}
	
	
}