package com.tapplocal.admin.service;

import java.util.concurrent.ConcurrentHashMap;

import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Storereport;
import com.tapplocal.admin.business.LoggerBusiness;
import com.tapplocal.admin.dao.StorereportDAO;
import com.tapplocal.admin.vo.LogVO;


public class StorereportService extends GenericService<Storereport>{
	
	public void persistStoreReport() {
		ConcurrentHashMap<Long, LogVO> storeMap = LoggerBusiness.getInstance().getStoreMap();
		
		Object[] keys = storeMap.keySet().toArray();
		
		//iterate the elements
		for (int i=keys.length-1; i>=0; i--)
		{
			//get the id
			Long idStore = (Long)keys[i];

			//get the vo
			LogVO vo = storeMap.get(idStore);
			
			//test if there is a register for the same guy
			Storereport sr = Next.getObject(StorereportDAO.class).findStoreReportByDateAndStore(idStore, vo.date);
			
			if (sr == null)
			{
				sr = new Storereport();
				sr.setDate(vo.date);
				sr.setIdStore(idStore);
			}
			
			if (sr.getCouponFlag() == null)
				sr.setCouponFlag(vo.flag);
			else
				sr.setCouponFlag(vo.flag + sr.getCouponFlag());			
			
			if (sr.getCouponClose() == null)
				sr.setCouponClose(vo.close);
			else
				sr.setCouponClose(vo.close + sr.getCouponClose());

			if (sr.getCouponDirections() == null)			
				sr.setCouponDirections(vo.directions);
			else
				sr.setCouponDirections(vo.directions + sr.getCouponDirections());
						
			if (sr.getCouponMerchant() == null)			
				sr.setCouponMerchant(vo.merchant);
			else
				sr.setCouponMerchant(vo.merchant + sr.getCouponMerchant());		
			
			if (sr.getCouponMoreDeals() == null)			
				sr.setCouponMoreDeals(vo.moreDeals);
			else
				sr.setCouponMoreDeals(vo.moreDeals + sr.getCouponMoreDeals());	
			
			if (sr.getCouponRefuse() == null)			
				sr.setCouponRefuse(vo.noThanks);
			else
				sr.setCouponRefuse(vo.noThanks + sr.getCouponRefuse());	
			
			if (sr.getCouponUse() == null)			
				sr.setCouponUse(vo.usedOk);
			else
				sr.setCouponUse(vo.usedOk + sr.getCouponUse());			

			if (sr.getCouponUseFar() == null)			
				sr.setCouponUseFar(vo.usedFar);
			else
				sr.setCouponUseFar(vo.usedFar + sr.getCouponUseFar());					
			
			if (sr.getCouponView() == null)			
				sr.setCouponView(vo.views);
			else
				sr.setCouponView(vo.views + sr.getCouponView());	
			
			if (sr.getBalance() == null)
				sr.setBalance((vo.centsSpent*1.0D)/100.0D);
			else
				sr.setBalance(((vo.centsSpent*1.0D)/100.0D) + sr.getBalance());			
			
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
			vo.centsSpent = 0;
			
			//when the day finishes, remove it
			if (!vo.date.equals(DateUtils.now().substring(0,8)))
				storeMap.remove(idStore);
						
			Next.getObject(StorereportDAO.class).saveOrUpdate(sr);			
		}
	}	
}