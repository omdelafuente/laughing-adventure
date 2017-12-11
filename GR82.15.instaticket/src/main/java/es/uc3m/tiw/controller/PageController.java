package es.uc3m.tiw.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
			return "index.jsp";
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
			return "index.jsp";
		}
		else {
			
			model.addAttribute("errorEdit", errorEdit);
			return "editProfile.jsp";
		}
	}
	
	@RequestMapping("/logOut")
	public String logOut(HttpSession session){
		
		session.invalidate();
		return "index.jsp";
		
	}
}
