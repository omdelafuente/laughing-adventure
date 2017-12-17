package es.uc3m.tiw.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import es.uc3m.tiw.domains.*;

@RestController
@CrossOrigin
public class Controller {
	
	@Autowired
	EventDAO eventDAO;
	@Autowired
	PurchaseDAO purchaseDAO;
	
	//crear un evento
	@RequestMapping(value="/event", method=RequestMethod.POST)
	public Event createEvent(@RequestBody Event event){
		return eventDAO.save(event);
	}
	
	//obtener un evento por su id
	@RequestMapping(value="/event/{id}", method=RequestMethod.GET)
	public Event getEvent(@PathVariable int id){
		return eventDAO.findById(id);
	}
	
	//actualizar un evento con id
	@RequestMapping(value="/event/{id}", method=RequestMethod.PUT)
	public void editUser(@PathVariable int id, @RequestBody Event event){
		event.setId(id);		
		eventDAO.save(event);
	}
	
	//conseguir una lista de eventos
	//sin parametros -> todos los eventos
	//con un string -> eventos que contegan el string en sus campos
	//con varios parametros -> eventos que cumplan esos parametros
	@RequestMapping(value="/event", method=RequestMethod.GET)
	public List<Event> getEvents(
			@RequestParam(value = "str", required = false) String str,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "place", required = false) String place,
			@RequestParam(value = "description", required = false) String description,
			@RequestParam(value = "state", required = false) String state,
			@RequestParam(value = "priceMin", required = false) BigDecimal priceMin,
			@RequestParam(value = "priceMax", required = false) BigDecimal priceMax,
			@RequestParam(value = "dateMin", required = false) LocalDateTime dateMin,
			@RequestParam(value = "dateMax", required = false) LocalDateTime dateMax){
		
		if(str == null && 
		email == null && 
		title == null && 
		category == null && 
		place == null && 
		description == null && 
		state == null && 
		priceMin == null && 
		priceMax == null && 
		dateMin == null && 
		dateMin == null){
			return eventDAO.findAll();
		}
		else {
			
			if(str != null){
				return eventDAO.findMatchingString(str);
			}
			else {
				if(email != null){
					return eventDAO.findByCreatorEmail(email);				
				}
				else {
					return eventDAO.findByMultipleFields(title, category, place, description, state, priceMin, priceMax, dateMin, dateMax);
				}
			}	
		}
		 
	}
	
	//crear una nueva compra de entrada
	@RequestMapping(value="/purchase", method=RequestMethod.POST)
	public ResponseEntity<Purchase> purchase(@RequestBody Purchase purchase){
		
		Event event = purchase.getEvent();
		
		int newTickets = event.getAvailableTickets() - purchase.getTickets();

		if(newTickets == 0){
			event.setState("Completo");
		}	
		event.setAvailableTickets(newTickets);
		eventDAO.save(event);
			
		return new ResponseEntity<Purchase>(purchaseDAO.save(purchase), HttpStatus.OK);
	}
	
	//obtener una lista de entradas compradas
	//parametro email -> lista de compras realizadas por el usuario con ese email
	//parametro id -> lista de entradas compradas para ese evento
	@RequestMapping(value="/purchase", method=RequestMethod.GET)
	public List<Purchase> getPurchases(@RequestParam(required = false) String email, @RequestParam(required=false) Integer eventId){
		
		if(email != null){
			return purchaseDAO.findByClientEmail(email);		
		}
		else {
			return purchaseDAO.findByEventId(eventId);
		}
	}
		
}
