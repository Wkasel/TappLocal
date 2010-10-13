package com.tapplocal.admin.service;

import java.util.concurrent.ConcurrentHashMap;

import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Developerreport;
import com.tapplocal.admin.bean.Merchantreport;
import com.tapplocal.admin.business.LoggerBusiness;
import com.tapplocal.admin.dao.DeveloperreportDAO;
import com.tapplocal.admin.vo.LogVO;


public class DeveloperreportService extends GenericService<Merchantreport>{

	public void persistDeveloperReport() {
		
		ConcurrentHashMap<Long, LogVO> developerMap = LoggerBusiness.getInstance().getDeveloperMap();
		
		Object[] keys = developerMap.keySet().toArray();
		
		//iterate the elements
		for (int i=keys.length-1; i>=0; i--)
		{
			//get the id
			Long idDeveloper = (Long)keys[i];

			//get the vo
			LogVO vo = developerMap.get(idDeveloper);
			
			//test if there is a register for the same guy
			Developerreport dr = Next.getObject(DeveloperreportDAO.class).findDeveloperReportByDateAndDeveloper(idDeveloper, vo.date);
			
			if (dr == null)
			{
				dr = new Developerreport();
				dr.setDate(vo.date);
				dr.setIdDeveloper(idDeveloper);
			}
			
			if (dr.getCouponFlag() == null)
				dr.setCouponFlag(vo.flag);
			else
				dr.setCouponFlag(vo.flag + dr.getCouponFlag());			
			
			if (dr.getCouponClose() == null)
				dr.setCouponClose(vo.close);
			else
				dr.setCouponClose(vo.close + dr.getCouponClose());

			if (dr.getCouponDirections() == null)			
				dr.setCouponDirections(vo.directions);
			else
				dr.setCouponDirections(vo.directions + dr.getCouponDirections());
						
			if (dr.getCouponMerchant() == null)			
				dr.setCouponMerchant(vo.merchant);
			else
				dr.setCouponMerchant(vo.merchant + dr.getCouponMerchant());		
			
			if (dr.getCouponMoreDeals() == null)			
				dr.setCouponMoreDeals(vo.moreDeals);
			else
				dr.setCouponMoreDeals(vo.moreDeals + dr.getCouponMoreDeals());	
			
			if (dr.getCouponRefuse() == null)			
				dr.setCouponRefuse(vo.noThanks);
			else
				dr.setCouponRefuse(vo.noThanks + dr.getCouponRefuse());	
			
			if (dr.getCouponUse() == null)			
				dr.setCouponUse(vo.usedOk);
			else
				dr.setCouponUse(vo.usedOk + dr.getCouponUse());			

			if (dr.getCouponUseFar() == null)			
				dr.setCouponUseFar(vo.usedFar);
			else
				dr.setCouponUseFar(vo.usedFar + dr.getCouponUseFar());					
			
			if (dr.getCouponView() == null)			
				dr.setCouponView(vo.views);
			else
				dr.setCouponView(vo.views + dr.getCouponView());	
			
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
				developerMap.remove(idDeveloper);
						
			Next.getObject(DeveloperreportDAO.class).saveOrUpdate(dr);			
		}
	}	
	
}