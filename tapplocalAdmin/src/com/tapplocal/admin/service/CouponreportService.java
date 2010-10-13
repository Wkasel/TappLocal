package com.tapplocal.admin.service;

import java.util.concurrent.ConcurrentHashMap;

import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Couponreport;
import com.tapplocal.admin.business.LoggerBusiness;
import com.tapplocal.admin.dao.CouponreportDAO;
import com.tapplocal.admin.vo.LogVO;

public class CouponreportService extends GenericService<Couponreport>{

	public void persistCouponReport() {

		ConcurrentHashMap<Long, LogVO> couponMap = LoggerBusiness.getInstance().getCouponMap();
		
		Object[] keys = couponMap.keySet().toArray();
		
		//iterate the elements
		for (int i=keys.length-1; i>=0; i--)
		{
			//get the id
			Long idCoupon = (Long)keys[i];

			//get the vo
			LogVO vo = couponMap.get(idCoupon);
			
			//test if there is a register for the same guy
			Couponreport cr =  Next.getObject(CouponreportDAO.class).findCouponReportByDateAndCoupon(idCoupon, vo.date);
			
			if (cr == null)
			{
				cr = new Couponreport();
				cr.setDate(vo.date);
				cr.setIdCoupon(idCoupon);
			}
			
			if (cr.getCouponFlag() == null)
				cr.setCouponFlag(vo.flag);
			else
				cr.setCouponFlag(vo.flag + cr.getCouponFlag());			
			
			if (cr.getCouponClose() == null)
				cr.setCouponClose(vo.close);
			else
				cr.setCouponClose(vo.close + cr.getCouponClose());

			if (cr.getCouponDirections() == null)			
				cr.setCouponDirections(vo.directions);
			else
				cr.setCouponDirections(vo.directions + cr.getCouponDirections());
						
			if (cr.getCouponMerchant() == null)			
				cr.setCouponMerchant(vo.merchant);
			else
				cr.setCouponMerchant(vo.merchant + cr.getCouponMerchant());		
			
			if (cr.getCouponMoreDeals() == null)			
				cr.setCouponMoreDeals(vo.moreDeals);
			else
				cr.setCouponMoreDeals(vo.moreDeals + cr.getCouponMoreDeals());	
			
			if (cr.getCouponRefuse() == null)			
				cr.setCouponRefuse(vo.noThanks);
			else
				cr.setCouponRefuse(vo.noThanks + cr.getCouponRefuse());	
			
			if (cr.getCouponUse() == null)			
				cr.setCouponUse(vo.usedOk);
			else
				cr.setCouponUse(vo.usedOk + cr.getCouponUse());			

			if (cr.getCouponUseFar() == null)			
				cr.setCouponUseFar(vo.usedFar);
			else
				cr.setCouponUseFar(vo.usedFar + cr.getCouponUseFar());					
			
			if (cr.getCouponView() == null)			
				cr.setCouponView(vo.views);
			else
				cr.setCouponView(vo.views + cr.getCouponView());	
			
			//the values are already persisted, delete them
			vo.flag = 0;			
			vo.close = 0;
			vo.directions = 0;
			vo.merchant = 0;
			vo.moreDeals = 0;
			vo.noThanks = 0;
			vo.usedOk = 0;
			vo.usedFar = 0;
			vo.views = 0;
			
			//when the day finishes, remove it
			if (!vo.date.equals(DateUtils.now().substring(0,8)))
				couponMap.remove(idCoupon);
						
			Next.getObject(CouponreportDAO.class).saveOrUpdate(cr);			
		}
		
	}
}