package es.uc3m.tiw.domains;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;

public class Purchase implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int id;
	@JsonDeserialize(using=LocalDateTimeDeserializer.class)
	private LocalDateTime date;
	private int tickets;
	private Event event;
	private Usr client;
	
	public Purchase() {
		
	}
	
	public Purchase(int tickets, Event event, Usr client) {
		super();
		this.tickets = tickets;
		this.event = event;
		this.client = client;
	}
	public int getId() {
		return id;
	}

	public LocalDateTime getDate() {
		return date;
	}

	public int getTickets() {
		return tickets;
	}
	public void setTickets(int tickets) {
		this.tickets = tickets;
	}
	public Event getEvent() {
		return event;
	}
	public void setEvent(Event event) {
		this.event = event;
	}
	public Usr getClient() {
		return client;
	}
	public void setClient(Usr client) {
		this.client = client;
	}

}
