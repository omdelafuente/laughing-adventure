package es.uc3m.tiw.domains;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateSerializer;

@Entity
@Table(name = "TRANSACTION")
public class Transaction implements Serializable{
	private static final long serialVersionUID = 1L;
	

	@Id private int id;
	private String creditCardNumber;
	private String creditCardCVC;
	@JsonSerialize(using=LocalDateSerializer.class)
	@Convert(converter = LocalDateAttributeConverter.class)
	private LocalDate creditCardDate;
	private BigDecimal amount;
	private int units;
	
	public Transaction(){
		
	}
	
	public Transaction(String creditCardNumber, String creditCardCVC, LocalDate creditCardDate, BigDecimal amount,
			int units) {
		super();
		this.creditCardNumber = creditCardNumber;
		this.creditCardCVC = creditCardCVC;
		this.creditCardDate = creditCardDate;
		this.amount = amount;
		this.units = units;
	}

	public String getCreditCardNumber() {
		return creditCardNumber;
	}

	public void setCreditCardNumber(String creditCardNumber) {
		this.creditCardNumber = creditCardNumber;
	}

	public String getCreditCardCVC() {
		return creditCardCVC;
	}

	public void setCreditCardCVC(String creditCardCVC) {
		this.creditCardCVC = creditCardCVC;
	}

	public LocalDate getCreditCardDate() {
		return creditCardDate;
	}

	public void setCreditCardDate(LocalDate creditCardDate) {
		this.creditCardDate = creditCardDate;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public int getUnits() {
		return units;
	}

	public void setUnits(int units) {
		this.units = units;
	}

	public int getId() {
		return id;
	}

	
}
