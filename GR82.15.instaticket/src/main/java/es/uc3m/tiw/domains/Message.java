package es.uc3m.tiw.domains;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;

public class Message implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String message;
	@JsonDeserialize(using=LocalDateTimeDeserializer.class)
	private LocalDateTime date;
	private Usr sender;
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
