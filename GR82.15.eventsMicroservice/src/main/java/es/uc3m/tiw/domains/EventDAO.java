package es.uc3m.tiw.domains;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface EventDAO extends CrudRepository<Event, Integer> {
	
	public Event findById(int id);
	
	public List<Event> findAll();
	
	@Query("SELECT c FROM Event c WHERE c.creator.email = :email")
	public List<Event> findByCreatorEmail(@Param("email") String email);
	
	@Query("SELECT c FROM Event c WHERE c.title LIKE CONCAT('%',:str,'%') OR c.category LIKE CONCAT('%',:str,'%') OR c.price LIKE CONCAT('%',:str,'%') OR function('date_format',c.eventDate, '%r %M %d %Y') LIKE CONCAT('%',:str,'%') OR c.place LIKE CONCAT('%',:str,'%') OR c.description LIKE CONCAT('%',:str,'%') OR c.state LIKE CONCAT('%',:str,'%')")
	public List<Event> findMatchingString(@Param("str") String str);
	
	@Query("SELECT c FROM Event c WHERE (:title IS NULL OR c.title LIKE CONCAT('%',:title,'%')) AND (:category IS NULL OR c.category = :category) AND (:place IS NULL OR c.place LIKE CONCAT('%',:place,'%')) AND (:description IS NULL OR c.description LIKE CONCAT('%',:description,'%')) AND (:state IS NULL OR c.state = :state) AND (:priceMin IS NULL OR c.price >= :priceMin) AND (:priceMax IS NULL OR c.price <= :priceMax) AND (:dateMin IS NULL OR c.eventDate >= :dateMin) AND (:dateMax IS NULL OR c.eventDate <= :dateMax)")
	public List<Event> findByMultipleFields(@Param("title") String title, @Param("category") String category, @Param("place") String place, @Param("description") String description, @Param("state") String state, @Param("priceMin") BigDecimal priceMin, @Param("priceMax") BigDecimal priceMax, @Param("dateMin") LocalDateTime dateMin, @Param("dateMax") LocalDateTime dateMax);
	
	
}
