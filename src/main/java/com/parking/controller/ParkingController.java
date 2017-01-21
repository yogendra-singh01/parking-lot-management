package com.parking.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.parking.businesshelper.ParkingManagementBusinessHelper;
import com.parking.entity.Vehicle;

@Controller
public class ParkingController {

	private static final Logger LOG = Logger.getLogger(ParkingController.class.getName());
	@Autowired
	private ParkingManagementBusinessHelper businessHeper;
	
	@RequestMapping(value="/parkVehicle",method = RequestMethod.POST)
	@ResponseBody
	public String parkVehicle(@RequestBody Vehicle vehicle) {
		String response = businessHeper.parkVehicle(vehicle);
		LOG.debug(response);
		return response;
	}
	
	@RequestMapping(value="/unparkVehicle",method = RequestMethod.POST)
	@ResponseBody
	public String unparkVehicle(@RequestParam(value = "vehicleNumber", required = true) String vehicleNumber) {
		String response = businessHeper.unparkVehicle(vehicleNumber);
		LOG.debug(response);
		return response;
	}
	
	@RequestMapping(value="/locateVehicle",method = RequestMethod.GET)
	@ResponseBody
	public String locateVehicle(@RequestParam(value = "vehicleNumber", required = true) String vehicleNumber) {
		String response = businessHeper.locateVehicle(vehicleNumber);
		LOG.debug(response);
		return response;
	}
	
	@RequestMapping(value="/fetchEmptyParkings",method = RequestMethod.GET)
	@ResponseBody
	public Object fetchEmptyParkings() {
		Object response = businessHeper.fetchEmptyParkings();
		LOG.debug(response);
		return response;
	}
	

}