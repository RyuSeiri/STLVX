package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
@Entity
@Table(name="TB_ARTICLE_FILE")
@IdClass(com.syau.po.ArticleFileRelation.class)
public class ArticleFileRelationBean {
@Id
@Column(name="SARTICLEID")
private String sArticleId;
@Id
@Column(name="FILE_ID")
private String fileId;
public String getsArticleId() {
	return sArticleId;
}
public void setsArticleId(String sArticleId) {
	this.sArticleId = sArticleId;
}
public String getFileId() {
	return fileId;
}
public void setFileId(String fileId) {
	this.fileId = fileId;
}
 
}
