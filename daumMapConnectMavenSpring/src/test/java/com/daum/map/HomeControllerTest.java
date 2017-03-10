package com.daum.map;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

/**
 * Handles requests for the application home page.
 */


public class HomeControllerTest {
	
	@Test
	public void sumTest() {
		HomeController hc = new HomeController();
		int a = 3;
		int b = 5;
		boolean bo = true;
		int result = hc.sum(3, 5);
		
		String names[] = {"y2kpooh","hwang"};
		String names2[] = {"y2kpooh","hwang"};
		assertArrayEquals(names2, names);
		
		//assertArrayEquals(a, b);
		assertEquals(8, result); 		//	객체 A와 B가 일치함을 확인한다.  
		//assertSame(a, b); 			//	객체 A와 B가 같은 객체임을 확인한다. 
		//assertSame					//	메서드는 두 객체가 동일한가 즉 하나의 객인 가를 확인한다.(== 연산자)  
		assertTrue(bo); 				//	조건 A가 참인가를 확인한다.  
		assertNotNull(result); 			//	객체 A가 null이 아님을 확인한다.
		
		


	}
}
