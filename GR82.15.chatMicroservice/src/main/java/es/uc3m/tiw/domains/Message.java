package es.uc3m.tiw.domains;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

@Entity
@Table(name = "MESSAGE")
public class Message implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id private int id;
	private String message;
	@JsonSerialize(using=LocalDateTimeSerializer.class)
	@Convert(converter = LocalDateTimeAttributeConverter.class)
	private LocalDateTime date;
	
	@ManyToOne
	@JoinColumn(name = "sender")
	private Usr sender;
	
	@ManyToOne
	@JoinColumn(name = "receiver")
	private Usr receiver;
	
	public Message(){
		
	}

	public Message(String message, Usr sender, Usr receiver) {
		super();
		this.message = message;
		this.sender = sender;
		this.receiver = receiver;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Usr getSender() {
		return sender;
	}

	public void setSender(Usr sender) {
		this.sender = sender;
	}

	public Usr getReceiver() {
		return receiver;
	}

	public void setReceiver(Usr receiver) {
		this.receiver = receiver;
	}

	public int getId() {
		return id;
	}

	public LocalDateTime getDate() {
		return date;
	}
	
	

}
