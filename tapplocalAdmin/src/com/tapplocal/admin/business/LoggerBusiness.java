package com.tapplocal.admin.business;

import java.util.HashSet;
import java.util.concurrent.ConcurrentHashMap;

import org.jfree.util.Log;
import org.nextframework.core.standard.Next;

import com.meritia.util.DateUtils;
import com.tapplocal.admin.bean.Coupon;
import com.tapplocal.admin.bean.Couponreport;
import com.tapplocal.admin.constants.TappLocalConstants;
import com.tapplocal.admin.dao.CouponDAO;
import com.tapplocal.admin.dao.CouponreportDAO;
import com.tapplocal.admin.job.LogPersisterJob;
import com.tapplocal.admin.service.CouponService;
import com.tapplocal.admin.servlet.LogReceiverServlet;
import com.tapplocal.admin.vo.LogVO;

public class LoggerBusiness {

	//create the maps to receive the access log
	private ConcurrentHashMap<Long, LogVO> merchantMap;
	private ConcurrentHashMap<Long, LogVO> couponMap;
	private ConcurrentHashMap<Long, LogVO> storeMap;					
	private ConcurrentHashMap<Long, LogVO> developerMap;
	private ConcurrentHashMap<Long, LogVO> appMap;
	private ConcurrentHashMap<Long, LogVO> representativeMap;
	
	//create the opt-in/out lists
	private ConcurrentHashMap<Long, HashSet<String>> optInMap;
	private ConcurrentHashMap<Long, HashSet<String>> optOutMap;
	
	private static LoggerBusiness instance;

	private LoggerBusiness() {
		
		//create the maps to receive the access log
		merchantMap = new ConcurrentHashMap<Long, LogVO>();
		couponMap = new ConcurrentHashMap<Long, LogVO>();
		storeMap = new ConcurrentHashMap<Long, LogVO>();					
		developerMap = new ConcurrentHashMap<Long, LogVO>();
		appMap = new ConcurrentHashMap<Long, LogVO>();
		representativeMap = new ConcurrentHashMap<Long, LogVO>();
		
		//create the opt-in/out lists
		optInMap = new ConcurrentHashMap<Long, HashSet<String>>();
		optOutMap = new ConcurrentHashMap<Long, HashSet<String>>();		
	}

	public static LoggerBusiness getInstance() {

		if (instance == null)
			instance = new LoggerBusiness();

		return instance;
	}
				
	public ConcurrentHashMap<Long, LogVO> getMerchantMap() {
		return merchantMap;
	}

	public ConcurrentHashMap<Long, LogVO> getCouponMap() {
		return couponMap;
	}

	public ConcurrentHashMap<Long, LogVO> getStoreMap() {
		return storeMap;
	}

	public ConcurrentHashMap<Long, LogVO> getDeveloperMap() {
		return developerMap;
	}

	public ConcurrentHashMap<Long, LogVO> getAppMap() {
		return appMap;
	}

	public ConcurrentHashMap<Long, LogVO> getRepresentativeMap() {
		return representativeMap;
	}

	public ConcurrentHashMap<Long, HashSet<String>> getOptInMap() {
		return optInMap;
	}

	public ConcurrentHashMap<Long, HashSet<String>> getOptOutMap() {
		return optOutMap;
	}

	public void registerLog(Long id_coupon, Long id_store, Long id_merchant, Long id_app, Long id_developer, Long id_representative, Long action)
	{				
		//get the VO from coupon
		LogVO couponVO = getCouponVO(id_coupon);		
		LogVO merchantVO = getMerchantVO(id_merchant);		
		LogVO storeVO = getStoreVO(id_store);	
		LogVO appVO = getAppVO(id_app);
		LogVO developerVO = getDeveloperVO(id_developer);
		LogVO representativeVO = null;
						
		if (id_representative != null)
		{
			representativeVO = getRepresentativeVO(id_representative);
		}
		
		if (action.equals(LogReceiverServlet.ACTION_FLAG))
		{
			couponVO.flag +=1;
			merchantVO.flag +=1;
			storeVO.flag +=1;
			appVO.flag +=1;
			developerVO.flag +=1;
			
			if (representativeVO != null)
				representativeVO.flag +=1;
		}		
		else if (action.equals(LogReceiverServlet.ACTION_VIEW))
		{
			couponVO.views +=1;
			merchantVO.views +=1;
			storeVO.views +=1;
			appVO.views +=1;
			developerVO.views +=1;
			
			if (representativeVO != null)
				representativeVO.views +=1;
		}
		else if (action.equals(LogReceiverServlet.ACTION_CLOSE))
		{
			couponVO.close +=1;
			merchantVO.close +=1;
			storeVO.close +=1;
			appVO.close +=1;
			developerVO.close +=1;
			
			if (representativeVO != null)
				representativeVO.close +=1;			
		}
		else if (action.equals(LogReceiverServlet.ACTION_DIRECTIONS))
		{
			couponVO.directions +=1;
			merchantVO.directions +=1;
			storeVO.directions +=1;
			appVO.directions +=1;
			developerVO.directions +=1;
			
			if (representativeVO != null)
				representativeVO.directions +=1;			
		}
		else if (action.equals(LogReceiverServlet.ACTION_MERCHANT))
		{
			couponVO.merchant +=1;
			merchantVO.merchant +=1;
			storeVO.merchant +=1;
			appVO.merchant +=1;
			developerVO.merchant +=1;
			
			if (representativeVO != null)
				representativeVO.merchant +=1;			
		}
		else if (action.equals(LogReceiverServlet.ACTION_MORE_DEALS))
		{
			couponVO.moreDeals +=1;
			merchantVO.moreDeals +=1;
			storeVO.moreDeals +=1;
			appVO.moreDeals +=1;
			developerVO.moreDeals +=1;
			
			if (representativeVO != null)
				representativeVO.moreDeals +=1;			
		}
		else if (action.equals(LogReceiverServlet.ACTION_NO_THANKS))
		{
			couponVO.noThanks +=1;
			merchantVO.noThanks +=1;
			storeVO.noThanks +=1;
			appVO.noThanks +=1;
			developerVO.noThanks +=1;
			
			if (representativeVO != null)
				representativeVO.noThanks +=1;			
		}
		else if (action.equals(LogReceiverServlet.ACTION_USED_FAR))
		{
			couponVO.usedFar +=1;	
			merchantVO.usedFar +=1;
			storeVO.usedFar +=1;
			appVO.usedFar +=1;
			developerVO.usedFar +=1;
			
			if (representativeVO != null)
				representativeVO.usedFar +=1;			
		}
		else if (action.equals(LogReceiverServlet.ACTION_USED_OK))
		{
			couponVO.centsSpent += TappLocalConstants.priceInCents;
			merchantVO.centsSpent += TappLocalConstants.priceInCents;
			storeVO.centsSpent += TappLocalConstants.priceInCents;
			appVO.centsSpent += TappLocalConstants.developerCutInCents;
			developerVO.centsSpent += TappLocalConstants.developerCutInCents;			
			
			couponVO.usedOk +=1;
			merchantVO.usedOk +=1;
			storeVO.usedOk +=1;
			appVO.usedOk +=1;
			developerVO.usedOk +=1;
			
			if (representativeVO != null)
			{
				representativeVO.usedOk +=1;	
				representativeVO.centsSpent += TappLocalConstants.representativeCutInCents;
			}
		}
		
		//decrement the available on the coupon
		couponVO.centsAvailable -= TappLocalConstants.priceInCents;
		
		//if there is no money anymore
		if (couponVO.centsAvailable  < TappLocalConstants.priceInCents)
		{
			//save everybody
			LogPersisterJob.run();
			
			//remove the coupon
			Next.getObject(CouponService.class).removeCoupon(id_coupon);				
		}		
	}

	private synchronized LogVO getStoreVO(Long id_store) {
		LogVO storeVO = storeMap.get(id_store);

		if (storeVO == null)
		{
			storeVO = new LogVO();
			storeVO.date = DateUtils.now().substring(0,8);
			storeMap.put(id_store, storeVO);
		}
		return storeVO;
	}

	private synchronized LogVO getMerchantVO(Long id_merchant) {
		LogVO merchantVO = merchantMap.get(id_merchant);

		if (merchantVO == null)
		{
			merchantVO = new LogVO();
			merchantVO.date = DateUtils.now().substring(0,8);
			merchantMap.put(id_merchant, merchantVO);
		}
		return merchantVO;
	}

	private synchronized LogVO getCouponVO(Long id_coupon) {
		LogVO couponVO = couponMap.get(id_coupon);

		if (couponVO == null)
		{
			couponVO = new LogVO();
			couponVO.date = DateUtils.now().substring(0,8);
			couponMap.put(id_coupon, couponVO);
			
			//load the coupon to set the budget			
			Coupon c = Next.getObject(CouponDAO.class).loadById(id_coupon);			
			
			if (c != null)
			{
				Double mB = c.getMaxBudget();
				Double mDB = c.getMaxDailyBudget();
				
				Double available = null;
				
				if ((mDB != null) && (mB == null))			
					available = mDB;
				else if ((mDB == null) && (mB != null))
					available = mB;
				else if ((mDB == null) && (mB == null))
					Log.error("COUPON WITHOUT MONEY!!! ->" + id_coupon);
				else 
				{					
					Couponreport cr = Next.getObject(CouponreportDAO.class).findCouponReportByDateAndCoupon(id_coupon,couponVO.date);
					
					if ((cr != null) && (cr.getBalance() != null))
						mDB -= cr.getBalance();
										
					if (mDB <= mB)
						available = mDB;
					else
						available = mB;					
				}
				
				couponVO.centsAvailable = Math.round(available * 100.0);				
			}
			else
				Log.error("COUPON NOT FOUND!!! ->" + id_coupon);
		}
		
		if (couponVO.centsAvailable  < TappLocalConstants.priceInCents)
		{
			//remove the coupon
			Next.getObject(CouponService.class).removeCoupon(id_coupon);				
		}		
		
		return couponVO;
	}
	
	private synchronized LogVO getAppVO(Long id_app) {
		LogVO appVO = appMap.get(id_app);

		if (appVO == null)
		{
			appVO = new LogVO();
			appVO.date = DateUtils.now().substring(0,8);
			appMap.put(id_app, appVO);
		}
		return appVO;
	}	
	
	private synchronized LogVO getDeveloperVO(Long id_developer) {
		LogVO developerVO = developerMap.get(id_developer);

		if (developerVO == null)
		{
			developerVO = new LogVO();
			developerVO.date = DateUtils.now().substring(0,8);
			developerMap.put(id_developer, developerVO);
		}
		return developerVO;
	}	
	
	private synchronized LogVO getRepresentativeVO(Long id_representative) {
		LogVO representativeVO = representativeMap.get(id_representative);

		if (representativeVO == null)
		{
			representativeVO = new LogVO();
			representativeVO.date = DateUtils.now().substring(0,8);
			representativeMap.put(id_representative, representativeVO);
		}
		return representativeVO;
	}			
	
	public void registerOptIn(Long id_merchant, String email)
	{		
		//if there are no maps, create them
		if (optOutMap.get(id_merchant) == null)
			optOutMap.put(id_merchant, new HashSet<String>());
		
		if (optInMap.get(id_merchant) == null)
			optInMap.put(id_merchant, new HashSet<String>());		
		
		//if there is this email in opt-out list, remove it
		if (optOutMap.get(id_merchant).contains(email))
			optOutMap.get(id_merchant).remove(email);
		
		//add in the opt-in
		optInMap.get(id_merchant).add(email);		
	}
	
	
	public void registerOptOut(Long id_merchant, String email)
	{				
		//if there are no maps, create them
		if (optOutMap.get(id_merchant) == null)
			optOutMap.put(id_merchant, new HashSet<String>());
		
		if (optInMap.get(id_merchant) == null)
			optInMap.put(id_merchant, new HashSet<String>());		
		
		//if there is this email in opt-in list, remove it
		if (optInMap.get(id_merchant).contains(email))
			optInMap.get(id_merchant).remove(email);
		
		//add in the opt-out
		optOutMap.get(id_merchant).add(email);		
	}	
	
}
