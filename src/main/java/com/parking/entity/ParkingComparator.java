package com.parking.entity;

import java.util.Comparator;

public class ParkingComparator implements Comparator<ParkingArea>{

	public int compare(ParkingArea p1, ParkingArea p2) {
		int res = new Integer(p1.getLevel()).compareTo(p2.getLevel());
		if(res == 0){
			return new Integer(p1.getSlot()).compareTo(p2.getSlot());
		}
		else{
			return res;
		}
	}

}
