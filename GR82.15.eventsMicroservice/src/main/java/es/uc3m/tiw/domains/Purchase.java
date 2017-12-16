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
@Table(name = "PURCHASE")
public class Purchase implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id private int id;
	@JsonSerialize(using=LocalDateTimeSerializer.class)
	@Convert(converter = LocalDateTimeAttributeConverter.class)
	private LocalDateTime date;
	private int tickets;
	@ManyToOne
    @JoinColumn(name = "event")
	private Event event;
	@ManyToOne
    @JoinColumn(name = "client")
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
