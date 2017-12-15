package es.uc3m.tiw.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import es.uc3m.tiw.domains.Event;
import es.uc3m.tiw.domains.Message;
import es.uc3m.tiw.domains.Usr;

@Controller
public class PageController {
	
	@Autowired
	RestTemplate restTemplate;
	
	@Autowired
	public PageController(RestTemplate rt){
		restTemplate = rt;
		restTemplate.setErrorHandler(new ResponseErrorHandler(){

			@Override
			public void handleError(ClientHttpResponse arg0) throws IOException {
				// TODO Auto-generated method stub
				
			}

			@Override
			public boolean hasError(ClientHttpResponse arg0) throws IOException {
				// TODO Auto-generated method stub
				return false;
			}
			
		});
	}
	
	@RequestMapping("/")
	public String indexView(Model model){
		
		return "index.jsp";
	}
	
	@RequestMapping("/logOut")
	public String logOut(HttpSession session){
		
		session.invalidate();
		return "index.jsp";
		
	}
	
	@RequestMapping("/login")
	public String login(Model model, @RequestParam String psw, HttpSession session){
		
		String email = "admin@admin.com";

		Usr user = new Usr();
		String url = "http://localhost:11502/userCredential";
		
		user.setEmail(email);
		user.setPassword(psw);
		
		ResponseEntity<Usr> result = restTemplate.postForEntity(url, user, Usr.class);
		
		if(result.getStatusCode() == HttpStatus.OK){
			model.addAttribute("loginSuccess", true);
			session.setAttribute("loggedUser", result.getBody());
			return "index.jsp";
		}
		else {
			
			model.addAttribute("errorLogin", "La contraseña introducida es incorrecta para acceder como administrador.");
			model.addAttribute("loginSuccess", false);
			return "login.jsp";
		}	
	}
	
	@RequestMapping("/events")
	public String getEventsList(Model model){
		
		String url = "http://localhost:11503/event";
		
		ResponseEntity<List<Event>> response = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Event>>() {});
		
		model.addAttribute("events", response.getBody());
		
		return "events.jsp";
	}
	
	@RequestMapping("/users")
	public String getUsersList(Model model){
		
		String url = "http://localhost:11502/user";
		
		ResponseEntity<List<Usr>> response = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Usr>>() {});
		
		model.addAttribute("users", response.getBody());
		
		return "users.jsp";
	}
	
	@RequestMapping("/cancelEvent")
	public String cancelEvent(Model model, @RequestParam int id, @RequestParam(value="type", required=false) String type){
		
		String url = "http://localhost:11503/event/{id}";
		
		Event event = restTemplate.getForObject(url, Event.class, id);
		
		if(type != null){
			model.addAttribute("event", event);
			return "cancelEvent.jsp";
		}
		else {
			
			event.setState("Cancelado");		
			restTemplate.put(url, event, event.getId());
			return "index.jsp";
		}
	}
	
	@RequestMapping("/event")
	public String getEvent(@RequestParam(value="id", required=true) int id, @RequestParam(value="type", required=false) String type, Model model){
		
		String url = "http://localhost:11503/event/{id}";
		
		Event event = restTemplate.getForObject(url, Event.class, id);
		model.addAttribute("event", event);
		
		if(type != null){				
			return "editEvent.jsp";
		} else {
			return "event.jsp";
		}
	}
	
	@RequestMapping("/editEvent")
	public String editEvent(@RequestParam Map<String, String> params, @RequestParam("image") MultipartFile filePart){
		
		int id = Integer.parseInt(params.get("id"));
		String title = params.get("title");
		String place = params.get("place");
	    String description = params.get("description");
	    BigDecimal price = null;
	    if(!params.get("price").isEmpty()){
			price = new BigDecimal(params.get("price"));
		}
	    int availableTickets = 0;
	    
	    if(!params.get("availableTickets").isEmpty()){
	    	availableTickets = Integer.parseInt(params.get("availableTickets"));
	    }
	    
		String inputDate = params.get("date"); 
	    LocalDateTime date = null;
	    try {
	    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	    	if(!params.get("date").isEmpty()){
	    		date = LocalDateTime.parse(inputDate, formatter);
	    	}    	
	    }
	    catch(DateTimeParseException exc){
	    	System.out.println(exc.getMessage());
	    }
	    
	    String url = "http://localhost:11503/event/{id}";
		Event event = restTemplate.getForObject(url, Event.class, id);
		
		if(filePart.getSize() > 0){
			byte[] image = new byte[(int) filePart.getSize()];
		    try {
				filePart.getInputStream().read(image, 0, image.length);
			} catch (IOException e) {
				e.printStackTrace();
			}
		    event.setImage(image);
		}
		
		if(!title.isEmpty() && !title.equals(event.getTitle())){
			event.setTitle(title);
		}
		
		if(!place.isEmpty() && !place.equals(event.getPlace())){
			event.setPlace(place);
		}
		
		if(price != null && !price.equals(event.getPrice())){
			event.setPrice(price);
		}

		if(!description.isEmpty() && !description.equals(event.getDescription())){
			event.setDescription(description);
		}
		
		if(date != null && !date.equals(event.getEventDate())){
			event.setEventDate(date);
		}
		
		if(availableTickets != 0 && availableTickets != event.getAvailableTickets()){
			event.setAvailableTickets(availableTickets);
		}
		
		url = "http://localhost:11503/event/{id}";
		
		restTemplate.put(url, event, event.getId());
		
		return "index.jsp";
	    
	}
	
	@RequestMapping("/editUser")
	public String editUser(Model model, @RequestParam Map<String, String> params, HttpSession session, @RequestParam(value="type", required=false) String type){
		
		String url = "http://localhost:11502/user/{email}";
		Usr user = restTemplate.getForObject(url, Usr.class, params.get("email"));
		
		if(type != null){
			
			model.addAttribute("user", user);
			return "editUser.jsp";
			
		}
		else {
			
			String name = params.get("name");
			String surname = params.get("surname");
			Usr updatedUser = new Usr();
			updatedUser.setEmail(user.getEmail());
			updatedUser.setPassword(user.getPassword());
			updatedUser.setIsActive(true);
			
			ArrayList<String> errorEdit = new ArrayList<String>();
			boolean editSuccess = true;
			
			if((name.isEmpty() || name.equals(user.getName())) && (surname.isEmpty() || surname.equals(user.getSurname()))){
				editSuccess = false;
				errorEdit.add("No hay ningún campo que modificar.");
			}
			else {
				
				if(!name.isEmpty()){
					
					if(!name.equals(user.getName())){
						if(!name.matches("^[\\p{Space}\\p{L}]+$")){
							editSuccess = false;
							errorEdit.add("El nombre solo puede contener letras.");
						}
						updatedUser.setName(name);
					}else{
						updatedUser.setName(user.getName());
					}
					
				}else{
					updatedUser.setName(user.getName());
				}
				
				if(!surname.isEmpty()){
					
					if(!surname.equals(user.getSurname())){
						if(!surname.matches("^[\\p{Space}\\p{L}]+$")){
							editSuccess = false;
							errorEdit.add("Los apellidos solo pueden contener letras.");
						}
						updatedUser.setSurname(surname);
					}else{
						updatedUser.setSurname(user.getSurname());
					}
				}else{
					updatedUser.setSurname(user.getSurname());
				}
			}
			
			model.addAttribute("editSuccess", editSuccess);
			
			if(editSuccess){
					
				url = "http://localhost:11502/user/{email}";
				
				restTemplate.put(url, updatedUser, user.getEmail());
				
				return "index.jsp";
			} else {
				
				model.addAttribute("errorEdit", errorEdit);
				model.addAttribute("user", user);
				return "editUser.jsp";
			}
			
		}
	}
	
	@RequestMapping("/deleteUser")
	public String deleteUser(Model model, @RequestParam String email, @RequestParam(value="type", required=false) String type){
		
		String url = "http://localhost:11502/user/{email}";
		Usr user = restTemplate.getForObject(url, Usr.class, email);
		
		if(type != null){
			
			model.addAttribute("user", user);
			return "deleteUser.jsp";
			
		}else {
			
			ResponseEntity<Usr> result = restTemplate.exchange(url, HttpMethod.DELETE, null, Usr.class, user.getEmail());
			
			if(result.getStatusCode() == HttpStatus.OK){			
				return "index.jsp";
			}
			else {
				
				model.addAttribute("deleteError", true);
				model.addAttribute("user", user);
				return "deleteUser.jsp";			
			}		
		}	
	}
	
	@RequestMapping("/availableChats")
	public String showAvailableChats(Model model){
		
		String url = "http://localhost:11502/user?creators=true";
		
		ResponseEntity<List<Usr>> response = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Usr>>() {});
		
		List<Usr> users = response.getBody();
		
		if(users.isEmpty()){
			model.addAttribute("noUsers", true);
		}
		else {
			model.addAttribute("users", users);
		}
		
		return "availableChats.jsp";
	}
	
	@RequestMapping("/chat")
	public String chat(HttpSession session, Model model, @RequestParam(value="type", required=false) String type, @RequestParam(value="userEmail", required=false) String userEmail, @RequestParam(required=false) String msg){
		
		model.addAttribute("userEmail", userEmail);
		
		if(type == null){
			
			String url = "http://localhost:11504/chat?receiverEmail=admin@admin.com&senderEmail={email}";
			
			ResponseEntity<List<Message>> messages = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Message>>() {}, userEmail);
			
			model.addAttribute("messages", messages.getBody());
		}
		else {
			
			if(type.equals("write")){
				
				Usr user = new Usr();
				user.setEmail(userEmail);
				
				Message message = new Message();
				message.setMessage(msg);
				message.setReceiver(user);
				message.setSender((Usr)session.getAttribute("loggedUser"));
				
				String url = "http://localhost:11504/chat";
				
				ResponseEntity<Message> result = restTemplate.postForEntity(url, message, Message.class);
				
				if(result.getStatusCode() == HttpStatus.OK){
					model.addAttribute("sendSuccess", true);
				}			
			}
			else {
				
				String url = "http://localhost:11504/chat?receiverEmail=admin@admin.com&senderEmail={email}";
				
				ResponseEntity<List<Message>> messages = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Message>>() {}, userEmail);
				
				model.addAttribute("messages", messages.getBody());
				
			}
		}
		
		return "chat.jsp";
		
	}
	
	@RequestMapping("/search")
	public String search(Model model, @RequestParam String search){
		
		
		String url = "http://localhost:11503/event?str={str}";
		ResponseEntity<List<Event>> eventsResponse = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Event>>() {}, search);
		url = "http://localhost:11502/user?search={search}";
		ResponseEntity<List<Usr>> usersResponse = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Usr>>() {}, search);

		model.addAttribute("events", eventsResponse.getBody());
		model.addAttribute("users", usersResponse.getBody());
		
		return "searchResults.jsp";
		
	}
	
	
	

}
