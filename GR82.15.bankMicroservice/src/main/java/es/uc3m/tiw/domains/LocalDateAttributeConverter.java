package es.uc3m.tiw.domains;

import java.sql.Date;
import java.time.LocalDate;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
//conversi�n entre date y localdate ya que este no lo soporta JPA
public class LocalDateAttributeConverter implements AttributeConverter<LocalDate, Date> {

    public Date convertToDatabaseColumn(LocalDate locDate) {
    	return (locDate == null ? null : Date.valueOf(locDate));
    }

   
    public LocalDate convertToEntityAttribute(Date date) {
    	return (date == null ? null : date.toLocalDate());
    }
	
}
