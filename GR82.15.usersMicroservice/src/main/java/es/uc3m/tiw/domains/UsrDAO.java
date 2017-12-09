package es.uc3m.tiw.domains;

import org.springframework.data.repository.CrudRepository;

public interface UsrDAO extends CrudRepository<Usr, String>{

	public Usr findByEmail(String email);
}
