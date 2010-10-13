package com.tapplocal.admin.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.tapplocal.admin.business.LoggerBusiness;


public class LogReceiverServler extends HttpServlet
{	
	public static final Long ACTION_FLAG = 0L;
	public static final Long ACTION_VIEW = 1L;
	public static final Long ACTION_DIRECTIONS = 2L;
	public static final Long ACTION_NO_THANKS = 3L;
	public static final Long ACTION_CLOSE = 4L;
	public static final Long ACTION_MORE_DEALS = 5L;
	public static final Long ACTION_USED_FAR = 6L;
	public static final Long ACTION_USED_OK = 7L;
	public static final Long ACTION_MERCHANT = 8L;
	public static final Long ACTION_FOLLOW = 9L;
	public static final Long ACTION_UNFOLLOW = 10L;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4444340215706604316L;



	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {					
		
		Logger logger = Logger.getLogger("com.tapplocal.admin.servlet");
		
		logger.debug("registerLog:" + req.getParameter("id_coupon") +" "+  req.getParameter("id_store") +" "+ req.getParameter("id_merchant") +" "+ req.getParameter("code") +" "+ req.getParameter("id_representative") +" "+ req.getParameter("action") +" "+ req.getParameter("udid") +" "+ req.getParameter("lat") +" "+ req.getParameter("lon") +" "+ req.getParameter("email"));
		
		if (req.getParameter("id_coupon") == null)
			return;
		
		//recover the data
		Long id_coupon = new Long(req.getParameter("id_coupon"));
		Long id_merchant = new Long(req.getParameter("id_merchant"));
		Long id_store = new Long(req.getParameter("id_store"));	
				
		Long id_representative = null;
		if ((req.getParameter("id_representative") == null) || (!req.getParameter("id_representative").equals("0"))) 
			id_representative = new Long(req.getParameter("id_representative"));
		
		Long action = new Long(req.getParameter("action"));
		String email = req.getParameter("email");

		String code = req.getParameter("code");
		
		Long id_app = new Long(code.substring(0,code.indexOf("_")));
		Long id_developer = new Long(code.substring(code.indexOf("_")+1));
		
		if (action.equals(ACTION_FOLLOW))		
			LoggerBusiness.getInstance().registerOptIn(id_merchant, email);					
		else if (action.equals(ACTION_UNFOLLOW))
			LoggerBusiness.getInstance().registerOptOut(id_merchant, email);
		else
			LoggerBusiness.getInstance().registerLog(id_coupon, id_store, id_merchant, id_app, id_developer, id_representative, action);
		
	}	
				
}