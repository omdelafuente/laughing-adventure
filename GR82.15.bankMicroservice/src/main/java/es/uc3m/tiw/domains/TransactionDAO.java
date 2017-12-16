package es.uc3m.tiw.domains;

import org.springframework.data.repository.CrudRepository;

public interface TransactionDAO extends CrudRepository<Transaction, Integer>{

}
