package com.tapplocal.admin.service;

import java.util.concurrent.ConcurrentHashMap;

import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Merchantreport;
import com.tapplocal.admin.business.LoggerBusiness;
import com.tapplocal.admin.dao.MerchantreportDAO;
import com.tapplocal.admin.vo.LogVO;


public class MerchantreportService extends GenericService<Merchantreport>{

	public void persistMerchantReport() {
		ConcurrentHashMap<Long, LogVO> merchantMap = LoggerBusiness.getInstance().getMerchantMap();
		
		Object[] keys = merchantMap.keySet().toArray();
		
		//iterate the elements
		for (int i=keys.length-1; i>=0; i--)
		{
			//get the id
			Long idMerchant = (Long)keys[i];

			//get the vo
			LogVO vo = merchantMap.get(idMerchant);
			
			//test if there is a register for the same guy
			Merchantreport mr = Next.getObject(MerchantreportDAO.class).findMerchantReportByDateAndMerchant(idMerchant, vo.date);
			
			if (mr == null)
			{
				mr = new Merchantreport();
				mr.setDate(vo.date);
				mr.setIdMerchant(idMerchant);
			}			
			
			if (mr.getCouponFlag() == null)
				mr.setCouponFlag(vo.flag);
			else
				mr.setCouponFlag(vo.flag + mr.getCouponFlag());
									
			if (mr.getCouponClose() == null)
				mr.setCouponClose(vo.close);
			else
				mr.setCouponClose(vo.close + mr.getCouponClose());

			if (mr.getCouponDirections() == null)			
				mr.setCouponDirections(vo.directions);
			else
				mr.setCouponDirections(vo.directions + mr.getCouponDirections());
						
			if (mr.getCouponMerchant() == null)			
				mr.setCouponMerchant(vo.merchant);
			else
				mr.setCouponMerchant(vo.merchant + mr.getCouponMerchant());		
			
			if (mr.getCouponMoreDeals() == null)			
				mr.setCouponMoreDeals(vo.moreDeals);
			else
				mr.setCouponMoreDeals(vo.moreDeals + mr.getCouponMoreDeals());	
			
			if (mr.getCouponRefuse() == null)			
				mr.setCouponRefuse(vo.noThanks);
			else
				mr.setCouponRefuse(vo.noThanks + mr.getCouponRefuse());	
			
			if (mr.getCouponUse() == null)			
				mr.setCouponUse(vo.usedOk);
			else
				mr.setCouponUse(vo.usedOk + mr.getCouponUse());			

			if (mr.getCouponUseFar() == null)			
				mr.setCouponUseFar(vo.usedFar);
			else
				mr.setCouponUseFar(vo.usedFar + mr.getCouponUseFar());					
			
			if (mr.getCouponView() == null)			
				mr.setCouponView(vo.views);
			else
				mr.setCouponView(vo.views + mr.getCouponView());	
			
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
				merchantMap.remove(idMerchant);
						
			Next.getObject(MerchantreportDAO.class).saveOrUpdate(mr);			
		}
	}
}