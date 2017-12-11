package es.uc3m.tiw.controller;

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
	UsrDAO userDAO;
	
	@RequestMapping(value="/user", method=RequestMethod.POST)
	public ResponseEntity<Usr> register(@RequestBody Usr user){
		
		String email = user.getEmail();
		
		if(!userDAO.exists(user.getEmail())){
			userDAO.save(user);
			return new ResponseEntity<Usr>(user, HttpStatus.OK);
		}
		else {
			return new ResponseEntity<Usr>(user, HttpStatus.CONFLICT);
		}
	}
	
	@RequestMapping(value="/userCredential", method=RequestMethod.POST)
	public ResponseEntity<Usr> authenticate(@RequestBody Usr user){
		
		if(userDAO.exists(user.getEmail())){
			Usr existingUser = userDAO.findByEmail(user.getEmail());
			if(!existingUser.isActive()){
				return new ResponseEntity<Usr>(user, HttpStatus.GONE);
			}
			else{
				if(!user.getPassword().equals(existingUser.getPassword())){
					return new ResponseEntity<Usr>(user, HttpStatus.BAD_REQUEST);
				}
				else{
					return new ResponseEntity<Usr>(existingUser, HttpStatus.OK);
				}
			}
		}
		else {
			return new ResponseEntity<Usr>(user, HttpStatus.NOT_FOUND);
		}
	}
	
	@RequestMapping(value="/user/{email:.+}", method=RequestMethod.PUT)
	public void editUser(@PathVariable String email, @RequestBody Usr user){
		user.setEmail(email);		
		userDAO.save(user);
	}
	
	@RequestMapping(value="/user/{email:.+}", method=RequestMethod.DELETE)
	public ResponseEntity<Usr> deleteUser(@PathVariable String email){
		
		Usr user = userDAO.findByEmail(email);
		
		List<Event> events = user.getEvents();
		
		if(events == null){
			user.setIsActive(false);
			userDAO.save(user);
			return new ResponseEntity<Usr>(user, HttpStatus.OK);
		}
		else {
			boolean hasAvailableEvents = false;
			
			for(int i = 0; i < events.size(); i++){
				if(events.get(i).getState().equals("Disponible")){
					hasAvailableEvents = true;
					break;
				}
			}
			
			if(hasAvailableEvents){
				return new ResponseEntity<Usr>(user, HttpStatus.BAD_REQUEST);
			}
			else {				
				user.setIsActive(false);
				userDAO.save(user);
				return new ResponseEntity<Usr>(user, HttpStatus.OK);
			}
		}
	}
	
	

}
