package com.tapplocal.admin.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.nextframework.bean.annotation.DescriptionProperty;

@Entity
@Table(name="representative")
public class Representative {

	private Long id;
	private String name;
	private String email;
	private String password;


	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_representative")
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public void setName(String name) {
		this.name = name;
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

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name="password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}	
}
