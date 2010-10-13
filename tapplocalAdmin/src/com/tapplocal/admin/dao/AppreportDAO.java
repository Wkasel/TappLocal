package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Appreport;

@Bean
public class AppreportDAO extends GenericDAO<Appreport>{

	public Appreport findAppReportByDateAndApp(Long idApp, String date) {

		return query()
		.where("appreport.idApp = ?",idApp)
		.where("appreport.date = ?",date)
		.unique();
		
	}
	
}
