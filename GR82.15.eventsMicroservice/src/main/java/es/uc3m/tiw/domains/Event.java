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

import es.uc3m.tiw.model.LocalDateTimeAttributeConverter;
import es.uc3m.tiw.model.Usr;

@Entity
@Table(name = "EVENT")
public class Event implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id private int id;
	private String title;
	private String category;
	private byte[] image;
	private BigDecimal price;
	@Convert(converter = LocalDateTimeAttributeConverter.class)
	private LocalDateTime eventDate;
	private String place;
	private String description;
	private int availableTickets;
	private String state;
	@ManyToOne
	@JoinColumn(name = "creator")
	private Usr creator;

}
