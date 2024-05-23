package com.syau.po;


/**
 * 用于问题页面显示的信息用
 * @author Dell
 *
 */
public class QuestionReplyPageInfoBean {
	private String contentId;
    private String content;
    /*发布时间*/
    private String time;
    /*内容的类型（0：学生的提问 1：老师的回答）*/
    private int contentType;
    private int curentPage;
    private int totlePage;
    
	public int getCurentPage() {
		return curentPage;
	}
	public void setCurentPage(int curentPage) {
		this.curentPage = curentPage;
	}
	public int getTotlePage() {
		return totlePage;
	}
	public void setTotlePage(int totlePage) {
		this.totlePage = totlePage;
	}
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
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getContentType() {
		return contentType;
	}
	public void setContentType(int contentType) {
		this.contentType = contentType;
	}
    
}
