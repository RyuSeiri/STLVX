package com.syau.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.syau.action.SystemControlDao;
import com.syau.po.SystemControlBean;

@Component
public class SystemControlService {
	@Resource
	private SystemControlDao systemControlDao;
	
	public SystemControlDao getSystemControlDao() {
		return systemControlDao;
	}

	public void setUserDao(SystemControlDao systemControlDao) {
		this.systemControlDao = systemControlDao;
	}
	public List<SystemControlBean> select(String skey){
		/*System.out.println("SystemControlService.select()");*/
		return systemControlDao.select(skey);
	}
	
}
