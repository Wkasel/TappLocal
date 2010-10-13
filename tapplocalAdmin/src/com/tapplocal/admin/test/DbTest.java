package com.tapplocal.admin.test;

import com.konkix.util.RandomKeyUtils;

public class DbTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		System.out.println(RandomKeyUtils.generateKey(32));

		try {
			//KeyGeneratorBusiness.generateKey(KeyTypeEnumeration.TRIAL,"guilherme@konkix.com",DateUtils.now(),"Mobile Reports",null);
			//KeyGeneratorBusiness.generateKey(KeyTypeEnumeration.FULL,"guilherme@konkix.com",DateUtils.now(),"Mobile Reports","12345");
			//KeyGeneratorBusiness.generateKey(KeyTypeEnumeration.TIME,"guilherme@konkix.com",DateUtils.now(),"Mobile Reports",null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
