package com.syau.po;

import java.io.Serializable;

import javax.persistence.Column;


@SuppressWarnings("serial")
public class ArticleFileRelation implements Serializable{
	/**
	 *  主键类  * 作为嵌入式主键类，要满足以下几点要求：  * 1. 主键需要传递，必须实现 Serializable 接口
	 *  2. 必须有默认的 public 无参数的构造方法  * 3. 必须覆盖 equals 和 hashCode 方法
	 *  以上，这些要求与使用复合主键的要求相同  * 4. 将嵌入式主键类使用 @Embeddable标注，表示这个是一个嵌入式类
	 *  5. 聚合的 getId() 上写 @EmbeddedId  
	 */
	public ArticleFileRelation() {
		// TODO Auto-generated constructor stub
	}
	private String sArticleId;
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fileId == null) ? 0 : fileId.hashCode());
		result = prime * result
				+ ((sArticleId == null) ? 0 : sArticleId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ArticleFileRelation other = (ArticleFileRelation) obj;
		if (fileId == null) {
			if (other.fileId != null)
				return false;
		} else if (!fileId.equals(other.fileId))
			return false;
		if (sArticleId == null) {
			if (other.sArticleId != null)
				return false;
		} else if (!sArticleId.equals(other.sArticleId))
			return false;
		return true;
	}
}
