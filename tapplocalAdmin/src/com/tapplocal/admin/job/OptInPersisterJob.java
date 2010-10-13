package com.tapplocal.admin.job;

import java.io.File;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;
import org.nextframework.bean.annotation.Bean;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.meritia.util.FileUtils;
import com.tapplocal.admin.business.LoggerBusiness;

@Bean
public class OptInPersisterJob implements Job {

	private static String linux_path = "/var/www/vhosts/new.tapplocal.com/optin/";
	private static String windows_path = "C:\\temp\\optin\\";

	public void execute(JobExecutionContext context) throws JobExecutionException {

		Logger.getRootLogger().debug("started optin persister");

		//get the maps
		ConcurrentHashMap<Long, HashSet<String>> optInMap = LoggerBusiness.getInstance().getOptInMap();
		ConcurrentHashMap<Long, HashSet<String>> optOutMap = LoggerBusiness.getInstance().getOptOutMap();		

		//merge the merchant list
		HashSet<Long> merchantSet = new HashSet<Long>();
		merchantSet.addAll(	optInMap.keySet());
		merchantSet.addAll(	optOutMap.keySet());

		Iterator<Long> iteMerchant = merchantSet.iterator();

		//get the correct file system path
		String location = windows_path;			

		if (File.separator.equals("/"))
			location = linux_path;				

		//for each merchant in the lists
		while (iteMerchant.hasNext())
		{
			Long idMerchant = iteMerchant.next();

			//open  the file
			File file = new File(location + idMerchant + ".out");

			List<String> emails = new ArrayList<String>();

			try
			{
				if (file.exists())
				{
					String content = FileUtils.readFile(file);
					String[] arr = content.split("\n");

					for (int i=0; i<arr.length;i++)
						emails.add(arr[i]);
				}
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}

			//remove all opt-outs
			HashSet<String> tempOut = optOutMap.get(idMerchant);		
			if (tempOut != null)
			{
				emails.removeAll(tempOut);
				optOutMap.remove(idMerchant);
			}

			//add all the opt-ins
			HashSet<String> tempIn = optInMap.get(idMerchant);
			if (tempIn != null)
			{			
				Iterator<String> tempIte = tempIn.iterator();

				while (tempIte.hasNext()) {
					String current = tempIte.next();

					boolean found = false;

					for (int i=0; i<emails.size();i++)
					{
						if (emails.get(i).equalsIgnoreCase(current))
							found = true;
					}

					if (!found)
						emails.add(current);				
				}

				optInMap.remove(idMerchant);
			}

			//persist the file
			StringBuffer sb = new StringBuffer();

			for (int i=0; i<emails.size();i++)
				sb.append(emails.get(i)+"\n");

			try
			{
				FileUtils.createFile(file,sb.toString());
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}	
		}
			

		Logger.getRootLogger().debug("finished  optin persister");
	}
}
