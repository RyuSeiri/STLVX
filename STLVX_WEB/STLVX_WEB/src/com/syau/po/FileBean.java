package com.syau.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "TB_FILE")
public class FileBean {
	@Id
	@Column(name = "FILE_ID")
	private String fileId;
	@Column(name = "FILE_NAME",updatable=false)
	private String fileName;
	@Column(name = "FILE_PATH")
	private String filePath;
	@Column(name = "FILE_TYPE",updatable=false)
	private int fileType;
	@Column(name = "DEL_FLG")
	private int delflg;
	public int getFileType() {
		return fileType;
	}

	public void setFileType(int fileType) {
		this.fileType = fileType;
	}
	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getDelflg() {
		return delflg;
	}

	public void setDelflg(int delflg) {
		this.delflg = delflg;
	}

}
