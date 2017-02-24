package com.daum.map;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.log4j.Logger;

public class HttpConnection {
	
	private static Logger logger = Logger.getLogger(HttpConnection.class);
	
	public static String GetData(String strUrl) {
    	StringBuilder strResult = new StringBuilder("");
    	BufferedReader in = null;
    	
        try {
            URL url = new URL(strUrl) ;
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");
            urlConnection.connect();
            
            if(urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
            	in = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "UTF-8"));
            	
            	String inputLine;
            	while((inputLine = in.readLine()) != null) {
            		strResult.append(inputLine);
            	}
            } else {
            	strResult.append(urlConnection.getResponseCode());
            }
        } catch (MalformedURLException e) {
        	strResult.append(e.toString());

        } catch (IOException e) {
        	strResult.append(e.toString());
        } finally {
        	if(in != null) {
				try {
					in.close();
				} catch (IOException e) {
					logger.error("HttpConnection.GetData() Failed");
				}
        	}
        }
        return strResult.toString();
    }
	
	public static String PostData(String strUrl, String strData) {
		StringBuilder strResult = new StringBuilder("");
		BufferedReader in = null;
		PrintWriter writer = null;
		OutputStreamWriter outStream = null;
		try {
			URL url = new URL(strUrl);
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			
			urlConnection.setDefaultUseCaches(false);                                           
			urlConnection.setDoInput(true);
			urlConnection.setDoOutput(true);
			urlConnection.setRequestMethod("POST");
			
			urlConnection.setRequestProperty("content-type", "application/x-www-form-urlencoded");
           
			outStream= new OutputStreamWriter(urlConnection.getOutputStream(), "UTF-8");
			writer = new PrintWriter(outStream);
			writer.write(strData.toString());
			writer.flush();
			
            if(urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
             
				in = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "UTF-8"));
				
				String inputLine;
	        	while((inputLine = in.readLine()) != null) {
	        		strResult.append(inputLine);
	        	}
            } else {
            	strResult.append(urlConnection.getResponseCode());
            }
            
		} catch (MalformedURLException e) {
			strResult.append(e.toString());
        } catch (IOException e) {
        	strResult.append(e.toString());
        } finally {

        	if(in != null) {
				try {
					in.close();
				} catch (IOException e) {
					logger.error("HttpConnection.PostData() Failed");
				}
        	}
        	
        	if(writer != null) {
				writer.close();
        	}
        	
        	if(outStream != null) {
				try {
					outStream.close();
				} catch (IOException e) {
					logger.error("HttpConnection.PostData() Failed");
				}
        	}
        }
        
        return strResult.toString();
	}
}
