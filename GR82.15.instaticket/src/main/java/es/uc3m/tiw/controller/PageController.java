package es.uc3m.tiw.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import es.uc3m.tiw.domains.*;

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
		
		return "index";
	}

	@RequestMapping("/register")
	public String register(Model model, @RequestParam Map<String, String> params){
		
		Usr user = new Usr();
		
		String url = "http://localhost:11502/user";
		String email = params.get("email");
		String name = params.get("name");
		String surname = params.get("surname");
		String password = params.get("psw");
		String checkPassword = params.get("checkpsw");
		
		user.setIsActive(true);
	    user.setEmail(email);
	    user.setName(name);
	    user.setSurname(surname);
	    user.setPassword(password);
		
		ArrayList<String> errorRegister = new ArrayList<String>();
		boolean registerSuccess = true;
		
		if(!password.equals(checkPassword)){
			
			registerSuccess = false;
			errorRegister.add("La contraseña y la confirmación deben coincidir.");	
		}
		if(password.length() < 6){
			
			registerSuccess = false;
			errorRegister.add("La contraseña debe tener mínimo 6 números o letras.");
		}
		
		if(!name.matches("^[\\p{Space}\\p{L}]+$") || !surname.matches("^[\\p{Space}\\p{L}]+$")){
			
			registerSuccess = false;
			errorRegister.add("Los nombres y apellidos solo pueden contener letras.");
		}
		
		if(!registerSuccess){	
			model.addAttribute("errorRegister", errorRegister);
			model.addAttribute("registerSuccess", registerSuccess);
			return "register.jsp";
		}
		else {
			
			ResponseEntity<Usr> result = restTemplate.postForEntity(url, user, Usr.class);
			if(result.getStatusCode() == HttpStatus.OK){
				model.addAttribute("registerSuccess", true);
				return "login.jsp";
			}
			else{				
				errorRegister.add("Ya existe una cuenta con esa dirección de correo, por favor use otra.");
				model.addAttribute("errorRegister", errorRegister);
				model.addAttribute("registerSuccess", false);
				return "register.jsp";
			}
		}
	}
	
	@RequestMapping("/login")
	public String login(Model model, @RequestParam Map<String, String> params, HttpSession session){
	
		Usr user = new Usr();
		String url = "http://localhost:11502/userCredential";
		
		user.setEmail(params.get("email"));
		user.setPassword(params.get("psw"));
		
		ResponseEntity<Usr> result = restTemplate.postForEntity(url, user, Usr.class);
		
		if(result.getStatusCode() == HttpStatus.OK){
			model.addAttribute("loginSuccess", true);
			session.setAttribute("loggedUser", result.getBody());
			return "index";
		}
		else{

			String errorLogin = null;
			
			if(result.getStatusCode() == HttpStatus.GONE){
				errorLogin = "La cuenta especificada ha sido eliminada.";
			}	
			else if(result.getStatusCode() == HttpStatus.BAD_REQUEST){
				errorLogin = "La contraseña introducida es incorrecta.";
			}			
			else if(result.getStatusCode() == HttpStatus.NOT_FOUND){
				errorLogin = "No se encontró ninguna cuenta con ese e-mail, por favor regístrate si no lo has hecho o introduce una cuenta existente.";
			}
			
			model.addAttribute("errorLogin", errorLogin);
			model.addAttribute("loginSuccess", false);
			return "login.jsp";
			
		}
	}
	
	@RequestMapping("/edit")
	public String editProfile(Model model, @RequestParam Map<String, String> params, HttpSession session){
		
		String name = params.get("name");
		String surname = params.get("surname");
		String oldPassword = params.get("psw");
		String newPassword = params.get("npsw");
		String checkNewPassword = params.get("checknpsw");
		
		ArrayList<String> errorEdit = new ArrayList<String>();
		boolean editSuccess = true;
		
		Usr user = (Usr) session.getAttribute("loggedUser");
		Usr userToUpdate = new Usr();
		userToUpdate.setEmail(user.getEmail());
		userToUpdate.setIsActive(true);
		
		if(!name.isEmpty()){
			
			if(!name.equals(user.getName())){
				if(!name.matches("^[\\p{Space}\\p{L}]+$")){
					editSuccess = false;
					errorEdit.add("El nombre solo puede contener letras.");
				}
				userToUpdate.setName(name);
			}else{
				userToUpdate.setName(user.getName());
			}
			
		}else{
			userToUpdate.setName(user.getName());
		}
		
		if(!surname.isEmpty()){
			if(!surname.equals(user.getSurname())){
				if(!surname.matches("^[\\p{Space}\\p{L}]+$")){
					editSuccess = false;
					errorEdit.add("Los apellidos solo pueden contener letras.");
				}
				userToUpdate.setSurname(surname);
			}else{
				userToUpdate.setSurname(user.getSurname());
			}
		}else{
			userToUpdate.setSurname(user.getSurname());
		}
		
		if(!newPassword.isEmpty()) {
			
			if(checkNewPassword.isEmpty()){
				
				editSuccess = false;
				errorEdit.add("Debes confirmar la nueva contraseña.");
			}else {
				
				if(!newPassword.equals(checkNewPassword)){
					editSuccess = false;
					errorEdit.add("La nueva contraseña y su confirmación deben ser iguales.");
				}
				if(newPassword.equals(user.getPassword())){
					editSuccess = false;
					errorEdit.add("La nueva contraseña debe ser distinta a la antigua.");
				}
				if(newPassword.length() < 6){
					
					editSuccess = false;
					errorEdit.add("La contraseña debe tener mínimo 6 números o letras.");
					
				}
				userToUpdate.setPassword(newPassword);
			}
		}else{
			userToUpdate.setPassword(user.getPassword());
		}
		
		if(newPassword.isEmpty() && (name.isEmpty() || name.equals(user.getName())) && (surname.isEmpty() || surname.equals(user.getSurname()))){
			editSuccess = false;
			errorEdit.add("No hay ningún campo que modificar.");
		}
		
		if(oldPassword.isEmpty()){
			
			editSuccess = false;
			errorEdit.add("Debes introducir la contraseña actual para poder realizar cambios.");
			
		}else{
			
			if(!oldPassword.equals(user.getPassword())){
				
				editSuccess = false;
				errorEdit.add("La contraseña actual no es correcta.");
				
			}
			
		}
		
		model.addAttribute("editSuccess", editSuccess);
		
		if(editSuccess){
			
			String url = "http://localhost:11502/user/{email}";
			
			restTemplate.put(url, userToUpdate, user.getEmail());
			session.setAttribute("loggedUser", userToUpdate);
			return "index";
		}
		else {
			
			model.addAttribute("errorEdit", errorEdit);
			return "editProfile.jsp";
		}
	}
	
	@RequestMapping("/logOut")
	public String logOut(HttpSession session){
		
		session.invalidate();
		return "index";
		
	}
	
	@RequestMapping("/dropOut")
	public String dropOut(Model model, HttpSession session){
		
		Usr user = (Usr) session.getAttribute("loggedUser");
		
		String url = "http://localhost:11502/user/{email}";
	
		ResponseEntity<Usr> result = restTemplate.exchange(url, HttpMethod.DELETE, null, Usr.class, user.getEmail());
		
		if(result.getStatusCode() == HttpStatus.OK){
			model.addAttribute("dropOutSuccess", true);
			session.invalidate();
			return "index";
		}
		else {
			model.addAttribute("dropOutSuccess", false);
			return "editProfile.jsp";	
		}
	}
	
	@RequestMapping("/index")
	public String indexPage(Model model){
		
		String url = "http://localhost:11503/event";
		
		ResponseEntity<List<Event>> response = restTemplate.exchange(url, HttpMethod.GET, null,	new ParameterizedTypeReference<List<Event>>() {});
		
		List<Event> events = response.getBody();
		
		List<Event> eventsToShow = new ArrayList<Event>();
		List<Integer> randomNums = null;
		
		if(events.size() > 0){
			randomNums = ThreadLocalRandom.current().ints(0,events.size()).distinct().limit(9).boxed().collect(Collectors.toList());
			
			for(int i = 0; i < randomNums.size(); i++){			
				eventsToShow.add(events.get(randomNums.get(i)));		
			}
		}
		
		model.addAttribute("events", eventsToShow);
		return "index.jsp";
	}
	
	@RequestMapping("/createEvent")
	public String createEvent(@RequestParam Map<String, String> params, @RequestParam("image") MultipartFile filePart, HttpSession session){
		
		String title = params.get("title");
		String category = params.get("category");
		byte[] image = new byte[(int) filePart.getSize()];
	    try {
			filePart.getInputStream().read(image, 0, image.length);
		} catch (IOException e) {
			e.printStackTrace();
		}
	    BigDecimal price = new BigDecimal(params.get("price"));
	    String inputDate = params.get("date"); 
	    LocalDateTime date = null;
	    try {
	    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	    	date = LocalDateTime.parse(inputDate, formatter);
	    }
	    catch(DateTimeParseException exc){
	    	System.out.println(exc.getMessage());
	    }
	    String place = params.get("place");
	    String description = params.get("description");
	    int availableTickets = Integer.parseInt(params.get("availableTickets"));
		
	    Usr creator = (Usr)session.getAttribute("loggedUser");
	    
	    Event newEvent = new Event();
		newEvent.setTitle(title);
		newEvent.setCategory(category);
		newEvent.setImage(image);
		newEvent.setPrice(price);
		newEvent.setEventDate(date);
		newEvent.setPlace(place);
		newEvent.setDescription(description);
		newEvent.setAvailableTickets(availableTickets);
		newEvent.setState("Disponible");
		newEvent.setCreator(creator);
		
		String url = "http://localhost:11503/event";
		
		restTemplate.postForObject(url, newEvent, Event.class);
		
		return "myCreatedEvents";
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
	
	
	
}
