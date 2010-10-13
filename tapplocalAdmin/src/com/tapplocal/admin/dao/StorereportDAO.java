package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Storereport;

@Bean
public class StorereportDAO extends GenericDAO<Storereport>{

	public Storereport findStoreReportByDateAndStore(Long idStore, String date) {

		return query()
		.where("storereport.idStore = ?",idStore)
		.where("storereport.date = ?",date)
		.unique();
		
	}
	
}
