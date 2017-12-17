package es.uc3m.tiw.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import es.uc3m.tiw.domains.Message;
import es.uc3m.tiw.domains.MessageDAO;
@RestController
@CrossOrigin
public class Controller {
	
	@Autowired
	MessageDAO messageDAO;
	
	//guardar un nuevo mensaje
	@RequestMapping(value="/chat", method=RequestMethod.POST)
	public ResponseEntity<Message> saveMessage(@RequestBody Message message){
		return new ResponseEntity<Message>(messageDAO.save(message), HttpStatus.OK);
	}
	
	//obtener todos los mensajes de una conversacion
	@RequestMapping(value="/chat", method=RequestMethod.GET)
	public List<Message> getMessages(@RequestParam(required=true) String senderEmail, @RequestParam(required=true) String receiverEmail){
		
		return messageDAO.findConversation(senderEmail, receiverEmail);
	
	}
	

}
