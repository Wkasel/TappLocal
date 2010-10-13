package com.tapplocal.admin.service;

import java.util.concurrent.ConcurrentHashMap;

import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Appreport;
import com.tapplocal.admin.business.LoggerBusiness;
import com.tapplocal.admin.dao.AppDAO;
import com.tapplocal.admin.dao.AppreportDAO;
import com.tapplocal.admin.vo.LogVO;


public class AppreportService extends GenericService<Appreport>{
	
	public void persistAppReport() {
		
		ConcurrentHashMap<Long, LogVO> appMap = LoggerBusiness.getInstance().getAppMap();
		
		Object[] keys = appMap.keySet().toArray();
		
		//iterate the elements
		for (int i=keys.length-1; i>=0; i--)
		{
			//get the id
			Long appCode = (Long)keys[i];

			//get the vo			
			LogVO vo = appMap.get(appCode);			
			
			//get the real id
			Long idApp = Next.getObject(AppDAO.class).findAppByCode(appCode);
			
			//test if there is a register for the same guy
			Appreport ar = Next.getObject(AppreportDAO.class).findAppReportByDateAndApp(idApp, vo.date);
			
			if (ar == null)
			{
				ar = new Appreport();
				ar.setDate(vo.date);
				ar.setIdApp(idApp);
			}
			
			if (ar.getCouponFlag() == null)
				ar.setCouponFlag(vo.flag);
			else
				ar.setCouponFlag(vo.flag + ar.getCouponFlag());			
			
			if (ar.getCouponClose() == null)
				ar.setCouponClose(vo.close);
			else
				ar.setCouponClose(vo.close + ar.getCouponClose());

			if (ar.getCouponDirections() == null)			
				ar.setCouponDirections(vo.directions);
			else
				ar.setCouponDirections(vo.directions + ar.getCouponDirections());
						
			if (ar.getCouponMerchant() == null)			
				ar.setCouponMerchant(vo.merchant);
			else
				ar.setCouponMerchant(vo.merchant + ar.getCouponMerchant());		
			
			if (ar.getCouponMoreDeals() == null)			
				ar.setCouponMoreDeals(vo.moreDeals);
			else
				ar.setCouponMoreDeals(vo.moreDeals + ar.getCouponMoreDeals());	
			
			if (ar.getCouponRefuse() == null)			
				ar.setCouponRefuse(vo.noThanks);
			else
				ar.setCouponRefuse(vo.noThanks + ar.getCouponRefuse());	
			
			if (ar.getCouponUse() == null)			
				ar.setCouponUse(vo.usedOk);
			else
				ar.setCouponUse(vo.usedOk + ar.getCouponUse());			

			if (ar.getCouponUseFar() == null)			
				ar.setCouponUseFar(vo.usedFar);
			else
				ar.setCouponUseFar(vo.usedFar + ar.getCouponUseFar());					
			
			if (ar.getCouponView() == null)			
				ar.setCouponView(vo.views);
			else
				ar.setCouponView(vo.views + ar.getCouponView());	
			
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
				appMap.remove(appCode);
						
			Next.getObject(AppreportDAO.class).saveOrUpdate(ar);			
		}
	}	
}