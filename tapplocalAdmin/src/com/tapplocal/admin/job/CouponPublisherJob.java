package com.tapplocal.admin.job;

import java.io.File;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.core.standard.Next;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.meritia.util.FileUtils;
import com.tapplocal.admin.bean.Coupon;
import com.tapplocal.admin.bean.Store;
import com.tapplocal.admin.dao.CouponDAO;

@Bean
public class CouponPublisherJob implements Job {

	private static String linux_path = "/var/www/vhosts/new.tapplocal.com/httpdocs/xml/";
	private static String windows_path = "C:\\temp\\tapplocal\\";

	public void execute(JobExecutionContext context) throws JobExecutionException {

		long time = System.currentTimeMillis();
		
		try
		{
			//get all active coupons
			List<Coupon> couponList = Next.getObject(CouponDAO.class).findActiveCoupons();
			
			//create a hashmap to handle the cells
			HashMap<String,HashSet<Coupon>> cellMap = new HashMap<String, HashSet<Coupon>>();
			
			//for each coupon
			for (Coupon c:couponList)
			{
				//for each store
				for (int i=0; i<c.getCouponstoreList().size(); i++)
				{
				    //get the store location and the radius
					Store s = c.getCouponstoreList().get(i).getStore();
				
					Long radius = c.getRadius();
					
					//calculate the number of cells to be added in each direction
					int cellsAround = 0;
					
					if (radius.intValue() == 100)
						cellsAround = 1;
					else if (radius.intValue() == 200)
						cellsAround = 2;
					else if (radius.intValue() == 300)
						cellsAround = 3;					
					else if (radius.intValue() == 400)
						cellsAround = 4;
					else 
						System.out.println("unknown radius:" + c.getId());
					
					int baseLat = Math.round(s.getLatitude().floatValue() * 1000);
					int baseLon = Math.round(s.getLongitude().floatValue() * 1000);
					
					//for each latitude to be used			
					for (int j=baseLat-cellsAround; j<=baseLat+cellsAround; j++)
					{					
						//for each longitude to be used
						for (int k=baseLon-cellsAround; k<=baseLon+cellsAround; k++)
						{						
							//mount the name
							String name = (j/1000)+"_"+Math.abs(j%1000)+"i"+(k/1000)+"_"+Math.abs(k%1000)+".xml";
							
			        		//recover the cell from hashmap
							HashSet<Coupon> cell = cellMap.get(name);
							
			        		//if it doesn't exist,
							if (cell == null)
							{
								//create
								cell = new HashSet<Coupon>();
								cellMap.put(name, cell);
							}						
							
							//if not in the cell, add
							if (!cell.contains(c))
								cell.add(c);														
						}
					}
				}
			}
			   
			//get the correct file system path
			String location = windows_path;			
			
			if (File.separator.equals("/"))
				location = linux_path;		
						
			Iterator<String> ite = cellMap.keySet().iterator();
			
			//for each cell in hash
			while (ite.hasNext())
			{
				String filename = ite.next();
												
				//serialize the xml
				String xml = convertXml(cellMap.get(filename));
				
				//write the file
				FileUtils.createFile(location + filename, xml);
			}			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		System.out.println(System.currentTimeMillis() - time);
	}

	private String convertXml(HashSet<Coupon> set) {

		StringBuffer sb = new StringBuffer();
		sb.append("<coupons>\n");
		
		Iterator<Coupon> ite = set.iterator();
		
		//for each coupon in set
		while (ite.hasNext())
		{
			Coupon c = ite.next();
			
			//coupon
			sb.append(" <coupon>\n");
			
			sb.append("  <id>");
			sb.append(c.getId());
			sb.append("</id>\n");	
			
			if (c.getLogoUrl() != null)
			{
				sb.append("  <logo>");
				sb.append(c.getLogoUrl());
				sb.append("</logo>\n");		
			}
			
			sb.append("  <title>");
			sb.append(c.getName());
			sb.append("</title>\n");
			
			sb.append("  <text>");
			sb.append(c.getCouponText());
			sb.append("</text>\n");			
			
			sb.append("  <dates>");
			sb.append(c.getDates());
			sb.append("</dates>\n");
			
			sb.append("  <location>");
			sb.append(c.getLocation());
			sb.append("</location>\n");		
			
			if (c.getTargetAgeStart() != null)
			{
				sb.append("  <agefrom>");
				sb.append(c.getTargetAgeStart());
				sb.append("</agefrom>\n");		
			}	
			
			if (c.getTargetAgeEnd() != null)
			{
				sb.append("  <ageto>");
				sb.append(c.getTargetAgeEnd());
				sb.append("</ageto>\n");		
			}	
			
			if (c.getTargetSex() != null)
			{
				sb.append("  <sex>");
				
				if (c.getTargetSex().equalsIgnoreCase("b"))
					sb.append("Both");
				else if (c.getTargetSex().equalsIgnoreCase("m"))
					sb.append("Male");
				else if (c.getTargetSex().equalsIgnoreCase("f"))
					sb.append("Female");
				
				sb.append("</sex>\n");		
			}			
			
			//merchant
			sb.append("  <merchant>\n");
			
			sb.append("   <id>");
			sb.append(c.getMerchant().getId());
			sb.append("</id>\n");
			
			if (c.getMerchant().getLogoUrl() != null)
			{
				sb.append("   <logo>");
				sb.append(c.getMerchant().getLogoUrl());
				sb.append("</logo>\n");		
			}		
			
			if (c.getMerchant().getRepresentative() != null)
			{
				sb.append("   <representative>");
				sb.append(c.getMerchant().getRepresentative().getId());
				sb.append("</representative>\n");		
			}				
			
			sb.append("   <name>");
			sb.append(c.getMerchant().getName());
			sb.append("</name>\n");
			
			sb.append("   <description>");
			sb.append(c.getMerchant().getDescription());
			sb.append("</description>\n");
			
			sb.append("   <phone>");
			sb.append(c.getMerchant().getPhone());
			sb.append("</phone>\n");
			
			sb.append("   <site>");
			sb.append(c.getMerchant().getSite());
			sb.append("</site>\n");			
			
			sb.append("  </merchant>\n");
						
			//stores
			sb.append("  <stores>\n");
			
			//for each store
			for (int i=0; i<c.getCouponstoreList().size(); i++)
			{
			    //get the store location and the radius
				Store s = c.getCouponstoreList().get(i).getStore();
				
				sb.append("   <store>\n");
				
				sb.append("    <id>");
				sb.append(s.getId());
				sb.append("</id>\n");
				
				sb.append("    <name>");
				sb.append(s.getNickname());
				sb.append("</name>\n");		
				
				sb.append("    <address>");
				sb.append(s.getAddress());
				sb.append("</address>\n");
				
				sb.append("    <phone>");
				sb.append(s.getPhone());
				sb.append("</phone>\n");
				
				sb.append("    <latitude>");
				sb.append(s.getLatitude());
				sb.append("</latitude>\n");
				
				sb.append("    <longitude>");
				sb.append(s.getLongitude());
				sb.append("</longitude>\n");				
				
				sb.append("   </store>\n");
			}
			
			sb.append("  </stores>\n");
			
			sb.append(" </coupon>\n");			
		}

		sb.append("</coupons>");
		return sb.toString();
	}
}
