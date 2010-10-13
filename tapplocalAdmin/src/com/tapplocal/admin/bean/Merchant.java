package com.tapplocal.admin.bean;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.nextframework.bean.annotation.DescriptionProperty;

@Entity
@Table(name="merchant")
public class Merchant {

	private Long id;
	private String name;
	private String email;
	private String password;	
	private String site;
	private String phone;
	private String logoUrl;	
	private String description;
	private Representative representative;
	
	List<Coupon> couponList;
	List<Store> storeList;	


	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_merchant")
	public Long getId() {
		return id;
	}

	@Column(name="name")
	public String getName() {
		return name;
	}

	@DescriptionProperty
	@Column(name="email")
	public String getEmail() {
		return email;
	}	

	@Column(name="password")
	public String getPassword() {
		return password;
	}

	@Column(name="site")	
	public String getSite() {
		return site;
	}

	@Column(name="phone")
	public String getPhone() {
		return phone;
	}

	@Column(name="logo_url")
	public String getLogoUrl() {
		return logoUrl;
	}

	@Column(name="description")
	public String getDescription() {
		return description;
	}	

	@OneToMany(mappedBy="merchant")
	public List<Coupon> getCouponList() {
		return couponList;
	}	

	@OneToMany(mappedBy="merchant")
	public List<Store> getStoreList() {
		return storeList;
	}
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_representative")
	public Representative getRepresentative() {
		return representative;
	}

	public void setRepresentative(Representative representative) {
		this.representative = representative;
	}

	public void setStoreList(List<Store> storeList) {
		this.storeList = storeList;
	}

	public void setCouponList(List<Coupon> couponList) {
		this.couponList = couponList;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}

	public void setDescription(String description) {
		this.description = description;
	}	
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
}
