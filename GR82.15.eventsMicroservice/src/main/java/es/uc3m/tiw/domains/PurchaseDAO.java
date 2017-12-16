package es.uc3m.tiw.domains;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface PurchaseDAO extends CrudRepository<Purchase, Integer> {
	
	public List<Purchase> findByClientEmail(String email);
	public List<Purchase> findByEventId(int id);

}
