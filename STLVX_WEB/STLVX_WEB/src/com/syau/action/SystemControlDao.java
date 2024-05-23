package com.syau.action;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.syau.po.ArticleBean;
import com.syau.po.SystemControlBean;

@Component
@SuppressWarnings("all")
public class SystemControlDao {
	@Resource
	private HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public List<SystemControlBean> select(String key) {
		final String sql = "select * from TB_SYSTEM_CONTROL where SKEY = '" + key + "'";
		List<SystemControlBean> result=new ArrayList<SystemControlBean>();
		result = hibernateTemplate.executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				return query.addEntity(SystemControlBean.class).list();
			}
		});
		if (result != null && result.size() > 0) {
			return result;
		} else {
			return null;
		}
	}
}
