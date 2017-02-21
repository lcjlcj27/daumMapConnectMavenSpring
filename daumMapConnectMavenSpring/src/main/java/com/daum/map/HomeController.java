package com.daum.map;

import java.util.HashMap;
import java.util.Iterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public ModelAndView home(@RequestParam HashMap<String, Object> pramMap) {
		logger.debug(pramMap.get("address").toString());
		logger.debug(pramMap.get("param1").toString());
		
		ModelAndView mv = new ModelAndView();
		
		for (String key : pramMap.keySet()) {
            System.out.println( String.format("키 : %s, 값 : %s", key, pramMap.get(key)) );
		}
		
		return mv;
	}
	
}
