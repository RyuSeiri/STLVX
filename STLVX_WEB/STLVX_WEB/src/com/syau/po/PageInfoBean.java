package com.syau.po;

public class PageInfoBean {
	/**
	 * 标题.
	 */
	private String title;

	/**
	 * 作者.
	 */
	private String author;

	/**
	 * 时间.
	 */
	private String time;

	/**
	 * 取得文章ID.
	 * 
	 * @return 文章ID.
	 */
	public String getArticleId() {
		return articleId;
	}

	/**
	 * 设定文章ID.
	 * 
	 * @param img
	 *            文章ID.
	 */
	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	/**
	 * 简介.
	 */
	private String brief;

	/**
	 * 图片.
	 */
	private String img;

	/**
	 * 文章ID.
	 */
	private String articleId;

	/**
	 * 取得图片.
	 * 
	 * @return 图片.
	 */
	public String getImg() {
		return img;
	}

	/**
	 * 设定图片.
	 * 
	 * @param img
	 *            图片.
	 */
	public void setImg(String img) {
		this.img = img;
	}

	/**
	 * 取得简介.
	 * 
	 * @return 简介
	 */
	public String getBrief() {
		return brief;
	}

	/**
	 * 设定简介.
	 * 
	 * @param brief
	 *            简介
	 */
	public void setBrief(String brief) {
		this.brief = brief;
	}

	/**
	 * 取得标题.
	 * 
	 * @return 标题
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * 设定标题.
	 * 
	 * @param title
	 *            标题
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * 取得作者.
	 * 
	 * @return 作者
	 */
	public String getAuthor() {
		return author;
	}

	/**
	 * 设定作者.
	 * 
	 * @param author
	 *            作者
	 */
	public void setAuthor(String author) {
		this.author = author;
	}

	/**
	 * 取得时间.
	 * 
	 * @return 时间
	 */
	public String getTime() {
		return time;
	}

	/**
	 * 设定时间.
	 * 
	 * @param time
	 *            时间
	 */
	public void setTime(String time) {
		this.time = time;
	}
}
