package es.uc3m.tiw.domains;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface MessageDAO extends CrudRepository<Message, Integer>{
	
	@Query("SELECT c FROM Message c WHERE (c.sender.email = :senderEmail AND c.receiver.email = :receiverEmail) OR (c.receiver.email = :senderEmail AND c.sender.email = :receiverEmail) ORDER BY c.date")
	public List<Message> findConversation(@Param("senderEmail") String senderEmail, @Param("receiverEmail") String receiverEmail);

}
