package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Merchantreport;

@Bean
public class MerchantreportDAO extends GenericDAO<Merchantreport>{

	public Merchantreport findMerchantReportByDateAndMerchant(Long idMerchant, String date) {

		return query()
		.where("merchantreport.idMerchant = ?",idMerchant)
		.where("merchantreport.date = ?",date)
		.unique();
		
	}
	
}
