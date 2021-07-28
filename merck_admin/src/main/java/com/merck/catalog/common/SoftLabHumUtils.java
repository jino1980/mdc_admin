package com.merck.catalog.common;

import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

public class SoftLabHumUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(SoftLabHumUtils.class);
	
	public static <T> T convertMapToVo(Map<String,Object> map , Class<T> t){
		
		Gson gson = new Gson();
		
		try {
			JsonElement jsonElement = gson.toJsonTree(map);
			T returnT = gson.fromJson(jsonElement, t);
			return returnT;
		}catch (Exception e) {
			// TODO: handle exception
			logger.error("converting failed! aMap: {"+gson.toJson(map).toString()+"}, class: {"+t.getClass().getSimpleName()+"}", e);
        }
        return null;
		
	}
	
	@SuppressWarnings("deprecation")
	public static String convertVoToJson(Object vo){
		
		try {
			ObjectMapper mapper = new ObjectMapper();
		   JsonParser jp = new JsonParser();
		   JsonElement je = jp.parse(mapper.writeValueAsString(vo));
		   Gson gson = new GsonBuilder().setPrettyPrinting().create();
		   return gson.toJson(je);

		}catch (Exception e) {
			// TODO: handle exception
			logger.error("converting failed! vo: {"+vo.toString()+"}, class: {"+vo.getClass().getSimpleName()+"}", e);
        }
        return null;
		
	}
	
	public static String converMapToJson(Map<String,Object> map){
		Gson gson = new Gson();
		try {
			String serializeString = gson.toJson(map);
			 
	        return serializeString;
	 
		}catch (Exception e) {
			// TODO: handle exception
			logger.error("converting failed! vo: {"+map.toString()+"}", e);
        }
        return "";
		
	}
	
	public static Map<String, Object> converVoToMap(Object vo){
		
		Map<String, Object> rtnMap = null;
		try {
			rtnMap = BeanUtils.describe(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("converting failed! converVoToMap vo =>: {"+vo.toString()+"}", e);
		}
        return rtnMap;       
		
	}
	
	
}
