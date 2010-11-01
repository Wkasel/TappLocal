package com.tapplocal.admin.dao;

import org.nextframework.bean.annotation.Bean;
import org.nextframework.persistence.GenericDAO;

import com.tapplocal.admin.bean.Merchant;
import com.tapplocal.admin.bean.User;

@Bean
public class UserDAO extends GenericDAO<User>{

	public User userByEmail(String email) {

		return query()
		.where("user.email = ?",email)
		.unique();			
	}	
	

	public User userByMerchant(Merchant merchant) {

		return query()
		.where("user.merchant = ?",merchant)
		.unique();			
	}		
	
}
