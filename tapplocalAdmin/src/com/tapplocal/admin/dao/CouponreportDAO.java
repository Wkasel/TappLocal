package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Couponreport;

@Bean
public class CouponreportDAO extends GenericDAO<Couponreport>{

	public Couponreport findCouponReportByDateAndCoupon(Long idCoupon, String date) {

		return query()
		.where("couponreport.idCoupon = ?",idCoupon)
		.where("couponreport.date = ?",date)
		.unique();
		
	}
	
}
