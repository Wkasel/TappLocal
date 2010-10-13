package com.tapplocal.admin.job;

import org.apache.log4j.Logger;
import org.nextframework.bean.annotation.Bean;
import org.nextframework.core.standard.Next;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.tapplocal.admin.service.AppreportService;
import com.tapplocal.admin.service.CouponreportService;
import com.tapplocal.admin.service.DeveloperreportService;
import com.tapplocal.admin.service.MerchantreportService;
import com.tapplocal.admin.service.RepresentativereportService;
import com.tapplocal.admin.service.StorereportService;

@Bean
public class LogPersisterJob implements Job {

	public void execute(JobExecutionContext context) throws JobExecutionException {

		Logger.getRootLogger().debug("started log persister");
		
		//table merchant_report		
		Next.getObject(MerchantreportService.class).persistMerchantReport();
				
		//table developer_report
		Next.getObject(DeveloperreportService.class).persistDeveloperReport();		
		
		//table representative_report
		Next.getObject(RepresentativereportService.class).persistRepresentativeReport();	
		
		//table coupon_report
		Next.getObject(CouponreportService.class).persistCouponReport();		
		
		//table app_report
		Next.getObject(AppreportService.class).persistAppReport();
		
		//table store_report
		Next.getObject(StorereportService.class).persistStoreReport();		
		
		Logger.getRootLogger().debug("finished log persister");
	}
	
}
