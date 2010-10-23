package com.tapplocal.admin.dao;

import java.util.List;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Betasignup;

@Bean
public class BetasignupDAO extends GenericDAO<Betasignup>{

	public List<Betasignup> findAllByType(String type) {

			return query()
			.where("betasignup.type = ?",type)
			.list();			
	}		
}
