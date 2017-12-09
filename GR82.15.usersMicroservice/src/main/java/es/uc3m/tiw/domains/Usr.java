package es.uc3m.tiw.domains;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="USR")
public class Usr implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String surname;
	private String password;
	@Id private String email;
	private boolean isActive = true;
	
	public Usr(String name, String surname, String password, String email, boolean isActive) {
		this.name = name;
		this.surname = surname;
		this.password = password;
		this.email = email;
		this.isActive = isActive;
	}
	
	public Usr() {
		
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public boolean isActive() {
		return isActive;
	}

	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}

}
