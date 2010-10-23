package com.tapplocal.admin.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="user")
public class User {

	private Long id;
	private String name;
	private String email;
	private String passwd;
	private String code;
	private Long accessFree;
	private Merchant merchant;
	private Developer developer;
	private Representative representative;
	

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_user")
	public Long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public String getPasswd() {
		return passwd;
	}

	@Column(name="access_free")
	public Long getAccessFree() {
		return accessFree;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_merchant")
	public Merchant getMerchant() {
		return merchant;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_developer")	
	public Developer getDeveloper() {
		return developer;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_representative")	
	public Representative getRepresentative() {
		return representative;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public void setAccessFree(Long accessFree) {
		this.accessFree = accessFree;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public void setDeveloper(Developer developer) {
		this.developer = developer;
	}

	public void setRepresentative(Representative representative) {
		this.representative = representative;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
