package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 该实体类用于文章（Article）的排序用
 * 
 */
@Entity
@Table(name = "TB_ARTICLEORDER")
public class ArticleOrderBean {
	@Id
	@Column(name = "SARTICLEID")
	private String sArticleId;
	@Column(name = "ORDERINFO")
	private int orderInfo;

	public String getsArticleId() {
		return sArticleId;
	}

	public void setsArticleId(String sArticleId) {
		this.sArticleId = sArticleId;
	}

	public int getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(int orderInfo) {
		this.orderInfo = orderInfo;
	}

}
