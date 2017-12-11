package es.uc3m.tiw.domains;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer;


@Entity
@Table(name = "EVENT")
public class Event implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id private int id;
	private String title;
	private String category;
	private byte[] image;
	private BigDecimal price;
	@JsonDeserialize(using=LocalDateDeserializer.class)
	@Convert(converter = LocalDateTimeAttributeConverter.class)
	private LocalDateTime eventDate;
	private String place;
	private String description;
	private int availableTickets;
	private String state;
	@ManyToOne
	@JoinColumn(name = "creator")
	private Usr creator;


	public Event(int id, String title, String category, byte[] image, BigDecimal price, LocalDateTime eventDate,
			String place, String description, int availableTickets, String state, Usr creator) {
		super();
		this.id = id;
		this.title = title;
		this.category = category;
		this.image = image;
		this.price = price;
		this.eventDate = eventDate;
		this.place = place;
		this.description = description;
		this.availableTickets = availableTickets;
		this.state = state;
		this.creator = creator;
	}


	public Event(){
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public byte[] getImage() {
		return image;
	}


	public void setImage(byte[] image) {
		this.image = image;
	}


	public BigDecimal getPrice() {
		return price;
	}


	public void setPrice(BigDecimal price) {
		this.price = price;
	}


	public LocalDateTime getEventDate() {
		return eventDate;
	}


	public void setEventDate(LocalDateTime eventDate) {
		this.eventDate = eventDate;
	}

	public String getPlace() {
		return place;
	}


	public void setPlace(String place) {
		this.place = place;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public int getAvailableTickets() {
		return availableTickets;
	}


	public void setAvailableTickets(int availableTickets) {
		this.availableTickets = availableTickets;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public Usr getCreator() {
		return creator;
	}


	public void setCreator(Usr creator) {
		this.creator = creator;
	}
	
	
}