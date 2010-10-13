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
@Table(name="app")
public class App {

	private Long id;
	private Developer developer;
	private String name;
	private String code;	

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_app")
	public Long getId() {
		return id;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id_developer")
	public Developer getDeveloper() {
		return developer;
	}
		
	@Column(name="code")
	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDeveloper(Developer developer) {
		this.developer = developer;
	}

	public void setId(Long id) {
		this.id = id;
	}


	
	
	
	
}
