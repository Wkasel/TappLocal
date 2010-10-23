package com.tapplocal.admin.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name="beta_signup")
public class Betasignup {

	private Long id;
	private String email;
	private String type;
	private byte[] details;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id")
	public Long getId() {
		return id;
	}
	
	public String getEmail() {
		return email;
	}

	public String getType() {
		return type;
	}

	@Lob
	public byte[] getDetails() {
		return details;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public void setDetails(byte[] details) {
		this.details = details;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
}
