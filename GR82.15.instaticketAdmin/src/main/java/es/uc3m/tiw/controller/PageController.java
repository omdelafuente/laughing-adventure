package es.uc3m.tiw.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.ResponseErrorHandler;
import org.springframework.web.client.RestTemplate;

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
	
	
	
	

}
