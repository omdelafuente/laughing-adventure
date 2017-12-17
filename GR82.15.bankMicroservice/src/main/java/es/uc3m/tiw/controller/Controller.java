package es.uc3m.tiw.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import es.uc3m.tiw.domains.Transaction;
import es.uc3m.tiw.domains.TransactionDAO;

@RestController
@CrossOrigin
public class Controller {
	
	@Autowired
	TransactionDAO transactionDAO;
	
	//crear una nueva transaccion
	//200: transaccion realizada
	//402: fallo al validar los datos de la tarjeta
	@RequestMapping(value="/transaction", method=RequestMethod.POST)
	public ResponseEntity<String> makeTransaction(@RequestBody Transaction transaction){
		
		String cardNumber = transaction.getCreditCardNumber();
		boolean checkCard = checkCreditCard(cardNumber);
		if(!checkCard){
			return new ResponseEntity<String>("Wrong credit-card number", HttpStatus.PAYMENT_REQUIRED);
		}
		else{
			
			String cvc = transaction.getCreditCardCVC();
			int cvcDigits = cvc.length();
			
			if(cvcDigits != 3 && cvcDigits != 4){
				return new ResponseEntity<String>("Wrong CVC.", HttpStatus.PAYMENT_REQUIRED);
			}
			else {
				
				for(int i = 0; i < cvcDigits; i++){
					
					int digit = 0;
					try {
						digit = Integer.parseInt(cvc.charAt(i)+"");
					}
					catch(NumberFormatException e) {
						return new ResponseEntity<String>("Wrong CVC.", HttpStatus.PAYMENT_REQUIRED);
		            }	
				}
				
				LocalDate now = LocalDate.now();
				LocalDate date = transaction.getCreditCardDate();
				
				if(now.isAfter(date)){
					return new ResponseEntity<String>("Credit-card has expired.", HttpStatus.PAYMENT_REQUIRED);
				}
				else {
					transactionDAO.save(transaction);
					return new ResponseEntity<String>("Transaction OK.", HttpStatus.OK);
				}
			}			
		}

	}
	
	protected static boolean checkCreditCard(String cardNumber) {
       
        int digits = cardNumber.length();
        int oddOrEven = digits & 1;
        long sum = 0;
        for (int count = 0; count < digits; count++) {
            int digit = 0;
            try {
                digit = Integer.parseInt(cardNumber.charAt(count) + "");
            } catch(NumberFormatException e) {
                return false;
            }

            if (((count & 1) ^ oddOrEven) == 0) { // not
                digit *= 2;
                if (digit > 9) {
                    digit -= 9;
                }
            }
            sum += digit;
        }

        return (sum == 0) ? false : (sum % 10 == 0);
    }

}
