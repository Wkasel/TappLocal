package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Developerreport;

@Bean
public class DeveloperreportDAO extends GenericDAO<Developerreport>{

	public Developerreport findDeveloperReportByDateAndDeveloper(Long idDeveloper, String date) {

		return query()
		.where("developerreport.idDeveloper = ?",idDeveloper)
		.where("developerreport.date = ?",date)
		.unique();
		
	}
	
}
