package com.tapplocal.admin.dao;

import java.util.Date;
import java.util.List;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.core.standard.Next;
import org.nextframework.persistence.GenericDAO;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Coupon;
import com.tapplocal.admin.bean.Couponreport;
import com.tapplocal.admin.constants.TappLocalConstants;

@Bean
public class CouponDAO extends GenericDAO<Coupon>{

	public Coupon loadById(Long id)
	{
		return query()
		.leftOuterJoinFetch("coupon.merchant merchant")
		.leftOuterJoinFetch("coupon.couponstoreList couponstore")
		.leftOuterJoinFetch("couponstore.store store")		
		.where("coupon.id = ?",id)
		.unique();
		
	}
	
	public List<Coupon> findActiveCoupons() {

		List<Coupon> result = query()
		.leftOuterJoinFetch("coupon.merchant merchant")
		.leftOuterJoinFetch("coupon.couponstoreList couponstore")
		.leftOuterJoinFetch("couponstore.store store")
		.where("coupon.couponStart <= ?",new Date())
		.where("coupon.couponEnd >= ?",new Date())
		.where("coupon.maxDailyBudget >= ?", TappLocalConstants.priceInDolars)
		.where("coupon.maxBudget >= ?", TappLocalConstants.priceInDolars)
		.list();
		
		for (int i=result.size()-1; i>=0; i--)
		{
			Coupon c = result.get(i);
			
			Couponreport cr = Next.getObject(CouponreportDAO.class).findCouponReportByDateAndCoupon(c.getId(),DateUtils.now().substring(0,8));
			
			//if there is a report showing that the balance was already hit, remove it from the list
			if ((cr != null) && (cr.getBalance() != null) && (cr.getBalance() >= c.getMaxDailyBudget()))
				result.remove(i);
			
		}
		
		return result;
		
	}
	
}
