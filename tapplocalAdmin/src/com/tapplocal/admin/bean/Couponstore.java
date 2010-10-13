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
@Table(name="coupon_store")
public class Couponstore {

	private Long id;			
	private Coupon coupon;
	private Store store;


	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_coupon_store")
	public Long getId() {
		return id;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_coupon")	
	public Coupon getCoupon() {
		return coupon;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_store")	
	public Store getStore() {
		return store;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

	public void setStore(Store store) {
		this.store = store;
	}	
	
}
