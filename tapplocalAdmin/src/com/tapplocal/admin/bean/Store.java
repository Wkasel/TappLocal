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
@Table(name="store")
public class Store {

	private Long id;
	private Merchant merchant;	
	private Double latitude;
	private Double longitude;	
	private String address;
	private String zipcode;	
	private String city;
	private String state;
	private String phone;
	private String nickname;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_store")
	public Long getId() {
		return id;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_merchant")
	public Merchant getMerchant() {
		return merchant;
	}

	public Double getLatitude() {
		return latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public String getAddress() {
		return address;
	}

	public String getZipcode() {
		return zipcode;
	}

	public String getCity() {
		return city;
	}

	public String getState() {
		return state;
	}

	public String getPhone() {
		return phone;
	}

	public String getNickname() {
		return nickname;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public void setState(String state) {
		this.state = state;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public void setMerchant(Merchant merchant) {
		this.merchant = merchant;
	}

	public void setId(Long id) {
		this.id = id;
	}
}
