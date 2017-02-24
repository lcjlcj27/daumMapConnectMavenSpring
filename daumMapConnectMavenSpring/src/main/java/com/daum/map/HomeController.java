package com.daum.map;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public ModelAndView home(@RequestParam HashMap<String, Object> pramMap, @ModelAttribute ParamVo paramVo) throws UnsupportedEncodingException {
		logger.debug(pramMap.get("address1").toString());
		logger.debug(pramMap.get("address2").toString());
		
		for (String key : pramMap.keySet()) {
            System.out.println( String.format("키 : %s, 값 : %s", key, pramMap.get(key)) );
		}
		
		String address = pramMap.get("address1").toString() + " "+ pramMap.get("address2").toString();
		String strUrl = "https://apis.daum.net/local/geo/addr2coord?apikey=deb64cbfb0f9b09c03d272dbfed6b7b2&q="+ URLEncoder.encode(address, "UTF-8")  +"&output=json";
		//strUrl = "https://apis.daum.net";
		
		//String httpResult = HttpConnection.PostData(strUrl, strData);
		String httpResult = HttpConnection.GetData(strUrl);
		JSONObject object;
		ModelAndView mv = new ModelAndView();
		
		try {
			object = (JSONObject) JSONValue.parseWithException(httpResult);
			System.out.println(object);
			mv.setViewName("jsonView");
			mv.addObject("httpResult",object);
		} catch (ParseException e) {
			System.out.println(e.getMessage());
		}
		
		
		
		return mv;
	}
	
}
