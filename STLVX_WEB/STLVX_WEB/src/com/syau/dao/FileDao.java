package com.syau.dao;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.syau.po.FileBean;

@Component
@SuppressWarnings("all")
public class FileDao {
	@Resource
	private HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public List<FileBean> selectFile(String fileId) {
		final String sql = "select * from TB_FILE where DEL_FLG = 0 AND FILE_ID = '" + fileId + "'";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		return result;
	}

	public void deleteFile(String fileId) {
		Session session = hibernateTemplate.getSessionFactory().openSession();
		session.beginTransaction();
		session.createQuery("update TB_FILE s set s.delFlg = '1' where FILE_ID = " + fileId + "").executeUpdate();
		session.getTransaction().commit();
	}

	public void addFile(FileBean file) {
		hibernateTemplate.save(file);
	}

 
	public List<FileBean> selectAllFile() {
		final String sql = "select * from TB_FILE where DEL_FLG = 0 ";
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		return result;
	}
	/**
	 * 
	 * @param fileId 文件的ID
	 * @param type 文件的类型 0：图片  1：文件  2：首页动态图片
	 * @return fileBen的集合
	 */
	public List<FileBean> selectFilebyType(String fileId,int type) {
		final String sql = "select * from TB_FILE where DEL_FLG = 0 AND FILE_ID = '" + fileId + "'"+" AND FILE_TYPE="+type;
		List result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(FileBean.class).list();
			}
		});
		return result;
	}
    /**
     * 用于上传文件
     * @param listObject 用于保存对象的pojo
     */
	public void addArticleFile(Object... listObject) {
		if(null!=listObject){
			for (Object object : listObject) {
				hibernateTemplate.save(object);
			}
		}
	}
}
