package com.tapplocal.admin.bean;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="developer")
public class Developer {

	private Long id;
	private String name;
	
	List<App> appList;


	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="id_developer")
	public Long getId() {
		return id;
	}

	@Column(name="name")
	public String getName() {
		return name;
	}

	@OneToMany(mappedBy="developer")
	public List<App> getAppList() {
		return appList;
	}	

	public void setAppList(List<App> appList) {
		this.appList = appList;
	}


	public void setId(Long id) {
		this.id = id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
}
