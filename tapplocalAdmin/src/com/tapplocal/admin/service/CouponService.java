package com.tapplocal.admin.service;

import java.io.File;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.nextframework.core.standard.Next;
import org.nextframework.service.GenericService;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.meritia.util.FileUtils;
import com.tapplocal.admin.bean.Coupon;
import com.tapplocal.admin.bean.Store;
import com.tapplocal.admin.bean.User;
import com.tapplocal.admin.constants.TappLocalConstants;
import com.tapplocal.admin.dao.CouponDAO;
import com.tapplocal.admin.dao.UserDAO;


public class CouponService extends GenericService<Coupon>{

	private static String linux_path = "/var/www/vhosts/new.tapplocal.com/httpdocs/xml/";
	private static String windows_path = "C:\\temp\\tapplocal\\";	

	public void publishNewXml(HashMap<String, HashSet<Coupon>> cellMap)throws Exception {

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

	public void processCoupon(HashMap<String, HashSet<Coupon>> cellMap, Coupon c) {
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
				Logger.getRootLogger().error("unknown radius:" + c.getId());

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

	public String convertXml(HashSet<Coupon> set) {

		StringBuffer sb = new StringBuffer();
		sb.append("<coupons>\n");

		Iterator<Coupon> ite = set.iterator();

		//for each coupon in set
		while (ite.hasNext())
		{
			Coupon c = ite.next();

			//coupon
			sb.append(" <coupon>");

			sb.append("<id>");
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


	public void cleanXml()
	{
		//get the correct file system path
		String location = windows_path;			

		if (File.separator.equals("/"))
			location = linux_path;								

		File dir = new File(location);

		File[] files = dir.listFiles();

		for (int i=0; i<files.length; i++)
		{
			//delete the file
			if (files[i].getName().indexOf("simulation") < 0)
				files[i].delete();
		}		
	}


	public void updateActive() throws Exception
	{
		//get all active coupons
		List<Coupon> couponList = Next.getObject(CouponDAO.class).findActiveCoupons();

		//create a hashmap to the current active cells
		HashMap<String,HashSet<Coupon>> cellMap = new HashMap<String, HashSet<Coupon>>();

		//for each coupon
		for (Coupon c:couponList)
		{			
			//process the coupon and add cells
			processCoupon(cellMap, c);
		}				

		//publish new XML
		publishNewXml(cellMap);	
	}

	public void removeCoupon(Long id_coupon) {

		Coupon c = Next.getObject(CouponDAO.class).loadById(id_coupon);

		removeCoupon(c);
	}


	public void removeCoupon(Coupon c) {

		//send email only if the total budget is pent
		if (c.getMaxBudget() < TappLocalConstants.priceInDolars)
			sendEmailRemoveCoupon(c);

		//get the correct file system path
		String location = windows_path;			

		if (File.separator.equals("/"))
			location = linux_path;			

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
				Logger.getRootLogger().error("unknown radius:" + c.getId());

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

					File file = new File(location+name);

					if (file.exists())
					{
						try
						{												
							//read the file
							String fileText = FileUtils.readFile(location+name);

							int init = fileText.indexOf("<coupon><id>"+c.getId());

							//if it was found
							if (init >= 0)
							{
								int end = fileText.indexOf("</coupon>",init);

								//remove the coupon fron the xml
								String newFile = fileText.substring(0,init) + fileText.substring(end+"</coupon>".length());

								//if there is other coupons
								if (newFile.indexOf("<coupon>") > 0)
								{
									//write the new file 
									FileUtils.createFile(location+name, newFile);
								}
								else
								{
									//delete the file
									File dead = new File(location+name);								
									dead.delete();
								}
							}		

						}
						catch (Exception e)
						{
							e.printStackTrace();
						}
					}
				}
			}
		}
	}

	private void sendEmailRemoveCoupon(Coupon c) {

		try
		{
			JavaMailSenderImpl sender = (JavaMailSenderImpl)Next.getApplicationContext().getBean("mailSender");

			MimeMessage message = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setFrom("TappLocal Service<noreply@tapplocal.com>");
			message.setSubject("Coupon's budget spent");

			User user = Next.getObject(UserDAO.class).userByMerchant(c.getMerchant());

			helper.setTo(user.getEmail());

			message.setText("Hello "+user.getName() +"! \nWe are sending this email to inform that your coupon \""+ c.getName() +"\" reserved budget was spent.\nIf you want to continue with your campaign, please access your account on http://new.tapplocal.com and add more funds.\n\n Best Regards,\nTapplocal Team");
			message.setContent("<html>Hello "+user.getName() +"! <br/>We are sending you this email to inform that your coupon \""+ c.getName() +"\" reserved budget was spent.<br/>If you want to continue with your campaign, please access your account on http://new.tapplocal.com and add more funds.<br/><br/> Best Regards,<br/>Tapplocal Team</html>","text/html");

			sender.send(message);	
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}		
	}
}