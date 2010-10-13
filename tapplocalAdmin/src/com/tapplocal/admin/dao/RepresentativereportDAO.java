package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Representativereport;

@Bean
public class RepresentativereportDAO extends GenericDAO<Representativereport>{

	public Representativereport findRepresentativeReportByDateAndRepresentative(Long idRepresentative, String date) {

		return query()
		.where("representativereport.idRepresentative = ?",idRepresentative)
		.where("representativereport.date = ?",date)
		.unique();
		
	}
	
}
