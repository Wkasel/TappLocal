package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.App;

@Bean
public class AppDAO extends GenericDAO<App>{

	public Long findAppByCode(Long appCode) {

			App app = query()
			.where("app.code = ?",appCode.toString())
			.unique();
			
			if (app != null)
				return app.getId();
			return 
				null;		
	}
}
