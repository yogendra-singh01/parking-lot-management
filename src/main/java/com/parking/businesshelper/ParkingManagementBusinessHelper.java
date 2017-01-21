package com.parking.businesshelper;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.parking.entity.ParkingArea;
import com.parking.entity.ParkingComparator;
import com.parking.entity.Vehicle;

@Component
public class ParkingManagementBusinessHelper {

	@Value("${parking.slots}")
	private String parkingSlots;

	private static Set<ParkingArea> availableParkingSlots;

	private static Map<String, ParkingArea> occupiedParkingSlots;

	@PostConstruct
	public void init() {
		availableParkingSlots = new TreeSet<ParkingArea>(new ParkingComparator());
		occupiedParkingSlots = new HashMap<String, ParkingArea>();
		String[] levels = parkingSlots.split(",");
		for (int i = 0; i < levels.length; i++) {
			String[] slots = levels[i].split(":");
			int s = Integer.parseInt(slots[1]);
			for (int j = 0; j < s; j++) {
				ParkingArea p = new ParkingArea();
				p.setLevel(i + 1);
				p.setSlot(j + 1);
				availableParkingSlots.add(p);
			}
		}
		/*Iterator<ParkingArea> it = availableParkingSlots.iterator();
		while (it.hasNext()) {
			ParkingArea p = it.next();
			System.out.println(p.getLevel() + ":::" + p.getSlot());

		}*/
	}

	public String parkVehicle(Vehicle vehicle) {
		if (availableParkingSlots.size() > 0) {
			if (occupiedParkingSlots.containsKey(vehicle.getVehicleNumber())) {
				return "Vehicle Already Parked !";
			} else {
				ParkingArea p = availableParkingSlots.iterator().next();
				availableParkingSlots.remove(p);
				p.setVehicleNumber(vehicle.getVehicleNumber());
				occupiedParkingSlots.put(vehicle.getVehicleNumber(), p);
				return "Vehicle Parked Successfully at Level :"+p.getLevel() +" Slot :"+p.getSlot();
			}
		} else {
			return "No Parking Space Available !";
		}

	}
	
	public String locateVehicle(String vehicleNumber) {
		if (occupiedParkingSlots.containsKey(vehicleNumber)) {
			ParkingArea p = occupiedParkingSlots.get(vehicleNumber);
			return "Vehicle Parked at Level :"+p.getLevel() +" Slot :"+p.getSlot();
		} else {
			return "Vehicle is not parked in Garage !";

		}
	}

	public Object fetchEmptyParkings() {
		if (availableParkingSlots.size() > 0) {
			Iterator<ParkingArea> it = availableParkingSlots.iterator();
			StringBuilder sb = new StringBuilder();
			while (it.hasNext()) {
				ParkingArea p = it.next();
				sb.append(p.getLevel()).append("-").append(p.getSlot()).append(",");
			}
			Set<ParkingArea> availableSlots = availableParkingSlots;
			return availableSlots;
		} else {
			return "Parking is full !";
		}
	}
	
	
	public String unparkVehicle(String vehicleNumber) {
		if (occupiedParkingSlots.size() > 0) {
			if (occupiedParkingSlots.containsKey(vehicleNumber)) {
				ParkingArea p = occupiedParkingSlots.get(vehicleNumber);
				occupiedParkingSlots.remove(vehicleNumber);
				p.setVehicleNumber(null);
				availableParkingSlots.add(p);
				return "Vehicle unparked Successfully from Level :"+p.getLevel() +" Slot :"+p.getSlot();
				
			} else {
				return "Vehicle is not present in parking !";
			}
		} else {
			return "Parking is empty !";
		}

	}
}
