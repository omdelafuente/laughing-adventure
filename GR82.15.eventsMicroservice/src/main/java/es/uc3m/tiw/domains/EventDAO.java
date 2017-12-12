package es.uc3m.tiw.domains;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface EventDAO extends CrudRepository<Event, Integer> {
	
	public List<Event> findAll();
	public Event findById(int id);
	
}
