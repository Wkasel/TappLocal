package com.tapplocal.admin.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="representative_report")
public class Representativereport {
	
	private Long id;
	private Long idRepresentative;
	private String date;
	private Long couponFlag;
	private Long couponView;	
	private Long couponUse;
	private Long couponUseFar;
	private Long couponClose;
	private Long couponRefuse;
	private Long couponDirections;	
	private Long couponMerchant;
	private Long couponMoreDeals;
	

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_representative_report")
	public Long getId() {
		return id;
	}

	@Column(name="id_representative")
	public Long getIdRepresentative() {
		return idRepresentative;
	}

	public String getDate() {
		return date;
	}

	@Column(name="coupon_view")
	public Long getCouponView() {
		return couponView;
	}

	@Column(name="coupon_use")
	public Long getCouponUse() {
		return couponUse;
	}

	@Column(name="coupon_use_far")
	public Long getCouponUseFar() {
		return couponUseFar;
	}

	@Column(name="coupon_close")
	public Long getCouponClose() {
		return couponClose;
	}

	@Column(name="coupon_refuse")
	public Long getCouponRefuse() {
		return couponRefuse;
	}

	@Column(name="coupon_directions")
	public Long getCouponDirections() {
		return couponDirections;
	}

	@Column(name="coupon_merchant")
	public Long getCouponMerchant() {
		return couponMerchant;
	}

	@Column(name="coupon_more_deals")
	public Long getCouponMoreDeals() {
		return couponMoreDeals;
	}
	
	@Column(name="coupon_flag")
	public Long getCouponFlag() {
		return couponFlag;
	}

	public void setCouponFlag(Long couponFlag) {
		this.couponFlag = couponFlag;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public void setIdRepresentative(Long idRepresentative) {
		this.idRepresentative = idRepresentative;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public void setCouponView(Long couponView) {
		this.couponView = couponView;
	}

	public void setCouponUse(Long couponUse) {
		this.couponUse = couponUse;
	}

	public void setCouponUseFar(Long couponUseFar) {
		this.couponUseFar = couponUseFar;
	}

	public void setCouponClose(Long couponClose) {
		this.couponClose = couponClose;
	}

	public void setCouponRefuse(Long couponRefuse) {
		this.couponRefuse = couponRefuse;
	}

	public void setCouponDirections(Long couponDirections) {
		this.couponDirections = couponDirections;
	}

	public void setCouponMerchant(Long couponMerchant) {
		this.couponMerchant = couponMerchant;
	}

	public void setCouponMoreDeals(Long couponMoreDeals) {
		this.couponMoreDeals = couponMoreDeals;
	}
	
}
