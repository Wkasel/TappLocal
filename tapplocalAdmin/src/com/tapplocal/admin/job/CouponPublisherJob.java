package com.tapplocal.admin.job;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.core.standard.Next;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.tapplocal.admin.service.CouponService;

@Bean
public class CouponPublisherJob implements Job {

	public void execute(JobExecutionContext context) throws JobExecutionException {

		long time = System.currentTimeMillis();
		
		try
		{
			//remove old coupons
			Next.getObject(CouponService.class).cleanXml();
			
			//add new coupons
			Next.getObject(CouponService.class).updateActive();			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		System.out.println(System.currentTimeMillis() - time);
	}


}
