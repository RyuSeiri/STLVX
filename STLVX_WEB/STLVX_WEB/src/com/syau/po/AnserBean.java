package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 答案的实体类（ps：文章的ID左外连答案的ID）
 *
 */
@Entity
@Table(name ="TB_ANSWER")
public class AnserBean {
	/*答案的ID和文章的*/
	@Id
	@Column(name = "ANSWER_ID")
	private String answerId;
	@Column(name = "ANSWER_INFO")
	private String answerInfo;
	@Column(name = "DEL_FLG")
	private int del_flg;
	public String getAnswerId() {
		return answerId;
	}
	public void setAnswerId(String answerId) {
		this.answerId = answerId;
	}
	public String getAnswerInfo() {
		return answerInfo;
	}
	public void setAnswerInfo(String answerInfo) {
		this.answerInfo = answerInfo;
	}
	public int getDel_flg() {
		return del_flg;
	}
	public void setDel_flg(int del_flg) {
		this.del_flg = del_flg;
	}
	

}
