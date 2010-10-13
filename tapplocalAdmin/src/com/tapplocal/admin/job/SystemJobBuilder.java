package com.tapplocal.admin.job;

import java.util.Calendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.nextframework.bean.annotation.Bean;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerUtils;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;

/**
 * Cria os Jobs para o Quartz e inicializa
 * @author Rógel Garcia
 *
 */
@Bean
public class SystemJobBuilder implements InitializingBean, DisposableBean {

	private static Log log = LogFactory.getLog("Access Job Builder");
	
	Scheduler scheduler;
	
	public void afterPropertiesSet() throws Exception {
				
		log.info("Creating Quartz Jobs");
		SchedulerFactory schedFact = new org.quartz.impl.StdSchedulerFactory();
		
		scheduler = schedFact.getScheduler();
		Calendar calendar = Calendar.getInstance();
		
		//Each hour
		Trigger triggerRobot = TriggerUtils.makeHourlyTrigger();
		calendar.add(Calendar.SECOND, 20);	
		triggerRobot.setStartTime(calendar.getTime());
		triggerRobot.setName("Coupon Publisher Job");
		JobDetail robotGigSearcherJob = new JobDetail("couponPublisherJob", null, CouponPublisherJob.class, false, false, true);
		scheduler.scheduleJob(robotGigSearcherJob, triggerRobot);	
		
		//Each five minutes
		Trigger triggerLogger = TriggerUtils.makeMinutelyTrigger(5);	
		calendar.add(Calendar.SECOND, 20);	
		triggerLogger.setStartTime(calendar.getTime());
		triggerLogger.setName("Log Persister Job");
		JobDetail logPersisterJob = new JobDetail("logPersisterJob", null, LogPersisterJob.class, false, false, true);
		scheduler.scheduleJob(logPersisterJob, triggerLogger);					
		
		//Each hour
		Trigger triggerOptinLogger = TriggerUtils.makeHourlyTrigger();	
		calendar.add(Calendar.SECOND, 20);	
		triggerOptinLogger.setStartTime(calendar.getTime());
		triggerOptinLogger.setName("Optin Persister Job");
		JobDetail optinPersisterJob = new JobDetail("optinPersisterJob", null, OptInPersisterJob.class, false, false, true);
		scheduler.scheduleJob(optinPersisterJob, triggerOptinLogger);				

		scheduler.start();
	}

	public void destroy() throws Exception {
		if(scheduler != null){
			log.info("Stopping Quartz");
			scheduler.shutdown(true);
			log.info("Quartz Finished");
		}
	}

}
