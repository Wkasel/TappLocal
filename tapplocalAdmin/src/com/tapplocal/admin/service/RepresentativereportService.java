package com.tapplocal.admin.service;

import java.util.concurrent.ConcurrentHashMap;

import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Representativereport;
import com.tapplocal.admin.business.LoggerBusiness;
import com.tapplocal.admin.dao.RepresentativereportDAO;
import com.tapplocal.admin.vo.LogVO;


public class RepresentativereportService extends GenericService<Representativereport>{
	
	public void persistRepresentativeReport() {
		ConcurrentHashMap<Long, LogVO> representativeMap = LoggerBusiness.getInstance().getRepresentativeMap();
		
		Object[] keys = representativeMap.keySet().toArray();
		
		//iterate the elements
		for (int i=keys.length-1; i>=0; i--)
		{
			//get the id
			Long idRepresentative = (Long)keys[i];

			//get the vo
			LogVO vo = representativeMap.get(idRepresentative);
			
			//test if there is a register for the same guy
			Representativereport rr = Next.getObject(RepresentativereportDAO.class).findRepresentativeReportByDateAndRepresentative(idRepresentative, vo.date);
									
			if (rr == null)
			{
				rr = new Representativereport();
				rr.setDate(vo.date);
				rr.setIdRepresentative(idRepresentative);
			}
			
			if (rr.getCouponFlag() == null)
				rr.setCouponFlag(vo.flag);
			else
				rr.setCouponFlag(vo.flag + rr.getCouponFlag());			
			
			if (rr.getCouponClose() == null)
				rr.setCouponClose(vo.close);
			else
				rr.setCouponClose(vo.close + rr.getCouponClose());

			if (rr.getCouponDirections() == null)			
				rr.setCouponDirections(vo.directions);
			else
				rr.setCouponDirections(vo.directions + rr.getCouponDirections());
						
			if (rr.getCouponMerchant() == null)			
				rr.setCouponMerchant(vo.merchant);
			else
				rr.setCouponMerchant(vo.merchant + rr.getCouponMerchant());		
			
			if (rr.getCouponMoreDeals() == null)			
				rr.setCouponMoreDeals(vo.moreDeals);
			else
				rr.setCouponMoreDeals(vo.moreDeals + rr.getCouponMoreDeals());	
			
			if (rr.getCouponRefuse() == null)			
				rr.setCouponRefuse(vo.noThanks);
			else
				rr.setCouponRefuse(vo.noThanks + rr.getCouponRefuse());	
			
			if (rr.getCouponUse() == null)			
				rr.setCouponUse(vo.usedOk);
			else
				rr.setCouponUse(vo.usedOk + rr.getCouponUse());			

			if (rr.getCouponUseFar() == null)			
				rr.setCouponUseFar(vo.usedFar);
			else
				rr.setCouponUseFar(vo.usedFar + rr.getCouponUseFar());					
			
			if (rr.getCouponView() == null)			
				rr.setCouponView(vo.views);
			else
				rr.setCouponView(vo.views + rr.getCouponView());	
			
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
				representativeMap.remove(idRepresentative);
						
			Next.getObject(RepresentativereportDAO.class).saveOrUpdate(rr);			
		}
	}	
}