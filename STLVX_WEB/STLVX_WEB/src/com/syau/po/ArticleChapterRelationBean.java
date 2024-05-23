package com.syau.po;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 文章与浏览量实体类
 */

@Entity
@Table(name="TB_ARTICLE_CHAPTER")
public class ArticleChapterRelationBean {
	@Id
	@Column(name="SARTICLEID")
	private String sArticleId;
	@Column(name="CHAPTER_ID")
	private String chapterId;
	public String getsArticleId() {
		return sArticleId;
	}
	public void setsArticleId(String sArticleId) {
		this.sArticleId = sArticleId;
	}
	public String getChapterId() {
		return chapterId;
	}
	public void setChapterId(String chapterId) {
		this.chapterId = chapterId;
	}
	
}