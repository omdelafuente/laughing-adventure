package es.uc3m.tiw.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import es.uc3m.tiw.domains.Usr;
import es.uc3m.tiw.domains.UsrDAO;

@RestController
@CrossOrigin
public class Controller {
	
	@Autowired 
	UsrDAO userDAO;
	
	@RequestMapping(value="users", method=RequestMethod.POST)
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
}
