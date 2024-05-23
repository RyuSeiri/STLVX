package com.syau.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.syau.dao.FileDao;
import com.syau.po.FileBean;

@Component
public class FileService {
	@Resource
	private FileDao fileDao;

	public FileDao getFileDao() {
		return fileDao;
	}

	public void setFileDao(FileDao fileDao) {
		this.fileDao = fileDao;
	}

	public List<FileBean> selectFile(String fileId) {
		return fileDao.selectFile(fileId);
	}

	public void deleteFile(String fileId) {
		fileDao.deleteFile(fileId);
	}
	/**
	 * 用于直接保存Entity
	 * @param listObject
	 */
	public void addArticleFile(Object... listObject){
		fileDao.addArticleFile(listObject);
	}
	public void addFile(FileBean file) {
		fileDao.addFile(file);
	}
	
	public List<FileBean> selectAllFile() {
		return fileDao.selectAllFile();
	}
	public List<FileBean> selectFilebyType(String fileId,int type){
		return fileDao.selectFilebyType(fileId, type);
	}
}
