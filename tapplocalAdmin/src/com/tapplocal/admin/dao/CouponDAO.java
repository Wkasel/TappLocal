package com.tapplocal.admin.dao;

import java.util.Date;
import java.util.List;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Coupon;

@Bean
public class CouponDAO extends GenericDAO<Coupon>{

	public List<Coupon> findActiveCoupons() {

		return query()
		.leftOuterJoinFetch("coupon.merchant merchant")
		.leftOuterJoinFetch("coupon.couponstoreList couponstore")
		.leftOuterJoinFetch("couponstore.store store")
		.where("coupon.couponStart <= ?",new Date())
		.where("coupon.couponEnd >= ?",new Date())
		.list();
		
	}

	
}
