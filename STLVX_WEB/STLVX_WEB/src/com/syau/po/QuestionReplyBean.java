package com.syau.po;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 提问和解答用到的实体类
 * @author Dell
 */
@Entity
@Table(name="TB_QUESTION_REPLY")
public class QuestionReplyBean {
	@Id
    @Column(name="CONTENT_ID")
	private String contentId;
    @Column(name="CONTENT")
    private String content;
    /*逻辑删除标志（0：未删除 1：删除）*/
    @Column(name="DEL_FLG")
    private int delFlg;
    /*发布时间*/
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="TIME")
    private Date time;
    /*内容的类型（0：学生的提问 1：老师的回答）*/
	@Column(name="CONTENT_TYPE")
    private int contentType;
	public String getContentId() {
		return contentId;
	}
	public void setContentId(String contentId) {
		this.contentId = contentId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getDelFlg() {
		return delFlg;
	}
	public void setDelFlg(int delFlg) {
		this.delFlg = delFlg;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getContentType() {
		return contentType;
	}
	public void setContentType(int contentType) {
		this.contentType = contentType;
	}
    
}
