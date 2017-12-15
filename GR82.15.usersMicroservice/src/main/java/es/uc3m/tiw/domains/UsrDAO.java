package es.uc3m.tiw.domains;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

public interface UsrDAO extends CrudRepository<Usr, String>{

	public Usr findByEmail(String email);
	public List<Usr> findByIsActiveTrue();
	
	@Query("SELECT c FROM Usr c WHERE c.isActive = TRUE AND c.events IS NOT EMPTY")
	public List<Usr> findCreators();
} 
