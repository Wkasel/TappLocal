package com.tapplocal.admin.bean;

import java.util.Date;
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

import org.nextframework.types.Money;

@Entity
@Table(name="coupon")
public class Coupon {

	private Long id;
	private Merchant merchant;
	private String logoUrl;
	private String name;	
	private String couponText;
	private String dates;
	private String location;
	
	private String couponType;
	private String targetSex;
	private String authorized; 	
	private Date couponStart; 
	private Date couponEnd;	
	private Long radius;
	private Long targetAgeStart; 
	private Long targetAgeEnd;
	private Money maxBudget; 
	private Money maxDailyBudget;
	
	private List<Couponstore> couponstoreList;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_coupon")
	public Long getId() {
		return id;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_merchant")
	public Merchant getMerchant() {
		return merchant;
	}
		
	@Column(name="logo_url")
	public String getLogoUrl() {
		return logoUrl;
	}

	public String getName() {
		return name;
	}

	@Column(name="coupon_text")
	public String getCouponText() {
		return couponText;
	}

	@Column(name="coupon_type")	
	public String getCouponType() {
		return couponType;
	}

	@Column(name="target_sex")	
	public String getTargetSex() {
		return targetSex;
	}

	public String getAuthorized() {
		return authorized;
	}

	@Column(name="coupon_start")	
	public Date getCouponStart() {
		return couponStart;
	}

	@Column(name="coupon_end")
	public Date getCouponEnd() {
		return couponEnd;
	}

	public Long getRadius() {
		return radius;
	}

	@Column(name="target_age_start")
	public Long getTargetAgeStart() {
		return targetAgeStart;
	}

	@Column(name="target_age_end")
	public Long getTargetAgeEnd() {
		return targetAgeEnd;
	}

	@Column(name="max_budget")
	public Money getMaxBudget() {
		return maxBudget;
	}

	@Column(name="max_daily_budget")
	public Money getMaxDailyBudget() {
		return maxDailyBudget;
	}
	
	public String getDates() {
		return dates;
	}

	public String getLocation() {
		return location;
	}	

	@OneToMany(mappedBy="coupon")
	public List<Couponstore> getCouponstoreList() {
		return couponstoreList;
	}

	public void setCouponstoreList(List<Couponstore> couponstoreList) {
		this.couponstoreList = couponstoreList;
	}

	public void setDates(String dates) {
		this.dates = dates;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setCouponText(String couponText) {
		this.couponText = couponText;
	}

	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}

	public void setTargetSex(String targetSex) {
		this.targetSex = targetSex;
	}

	public void setAuthorized(String authorized) {
		this.authorized = authorized;
	}

	public void setCouponStart(Date couponStart) {
		this.couponStart = couponStart;
	}

	public void setCouponEnd(Date couponEnd) {
		this.couponEnd = couponEnd;
	}

	public void setRadius(Long radius) {
		this.radius = radius;
	}

	public void setTargetAgeStart(Long targetAgeStart) {
		this.targetAgeStart = targetAgeStart;
	}

	public void setTargetAgeEnd(Long targetAgeEnd) {
		this.targetAgeEnd = targetAgeEnd;
	}

	public void setMaxBudget(Money maxBudget) {
		this.maxBudget = maxBudget;
	}

	public void setMaxDailyBudget(Money maxDailyBudget) {
		this.maxDailyBudget = maxDailyBudget;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public void setId(Long id) {
		this.id = id;
	}


	
	
	
	
}
