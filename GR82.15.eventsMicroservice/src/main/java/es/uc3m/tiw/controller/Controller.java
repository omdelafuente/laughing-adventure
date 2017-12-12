package es.uc3m.tiw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import es.uc3m.tiw.domains.*;

@RestController
@CrossOrigin
public class Controller {
	
	@Autowired
	EventDAO eventDAO;
	
	@RequestMapping(value="/event", method=RequestMethod.GET)
	public List<Event> getAllEvents(){	
		return eventDAO.findAll();
	}
	
	@RequestMapping(value="/event", method=RequestMethod.POST)
	public Event createEvent(@RequestBody Event event){
		return eventDAO.save(event);
	}
	
	@RequestMapping(value="/event/{id}", method=RequestMethod.GET)
	public Event getEvent(@PathVariable int id){
		return eventDAO.findById(id);
	}
	
	
	
	
	

}
