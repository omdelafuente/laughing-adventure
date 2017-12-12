package es.uc3m.tiw.domains;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface UsrDAO extends CrudRepository<Usr, String>{

	public Usr findByEmail(String email);
	public List<Usr> findByIsActiveTrue();
} 
