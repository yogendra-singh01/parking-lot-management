<html>
<head>

<style>
body {
	background-color: powderblue;
}

h1 {
	color: blue;
}

h1 {
	color: blue;
}

p {
	color: red;
}

.button {
	width: 200px;
}

.text {
	width: 200px;
}

.parking {
	text-align: center;
	border: solid;
	width: 195;
	position: relative;
	left: 50%;
	margin-left: -101;
}

.dropdown {
	width: 158px;
}
</style>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">


<script>
	function toggleMenuItem(id) {
		var element = document.getElementById(id);
		if (element.style.display == "block") {
			element.style.display = "none";
		} else {
			element.style.display = "block";
		}
	}
	function parkVehicle(){
		var vehicleType = $('#vehicleType').val();
		var vehicleNumber = $('#vechicleNumber').val();
		var model = $('#model').val();
		var contextPath = "<%=request.getContextPath()%>";
		var modelYear = $('#modelYear').val();
		var car = {"type": vehicleType,"model":model,"modelYear":modelYear,"vehicleNumber":vehicleNumber};
		 $.ajax({
		        url: contextPath+"/parkVehicle",
		        type: "POST",
		        data: JSON.stringify(car),
		        async: false,
		        contentType: "application/json",
		        success: function (data) {
		        	$('div#parkingStatus').html(data);
		        },
		        error: function (error) {
		        	$('div#parkingStatus').html(error);
		        }
		    });
	}
	
	function unparkVehicle(){
		var contextPath = "<%=request.getContextPath()%>";
		var vehicleNumber = $('#unparkVechicleNumber').val();
		var car = {"type": vehicleType,"vehicleNumber":vehicleNumber};
		 $.ajax({
		        url: contextPath+"/unparkVehicle?vehicleNumber="+vehicleNumber,
		        type: "POST",
		        async: false,
		        contentType: "application/json",
		        success: function (data) {
		        	$('div#unparkStatus').html(data);
		        },
		        error: function (error) {
		        	$('div#unparkStatus').html(error);
		        }
		    });
	}
	
	function locateVehicle(){
		var vehicleNumber = $('#locateVechicleNumber').val();
		var contextPath = "<%=request.getContextPath()%>";
		$.ajax({
			url : contextPath + "/locateVehicle?vehicleNumber="+vehicleNumber,
			type : "GET",
			async : false,
			contentType : "application/json",
			success : function(data) {
				$('div#locationStatus').html(data);
			},
			error : function(error) {
				$('div#locationStatus').html(error);
			}
		});
	}
	
	function toggleEmptyParking() {
		var element = document.getElementById("toggleEmptyParking");
		if (element.style.display == "block") {
			element.style.display = "none";
			return;
		} else {
			element.style.display = "block";
		}
		if ( $.fn.dataTable.isDataTable( '#parkingTable' ) ) {
		    table = $('#parkingTable').DataTable();
		    table.destroy();
		}
		$('#parkingTable').empty()
		$('div#emptyParkingStatus').html("");
		var contextPath = "<%=request.getContextPath()%>";
		$.ajax({
			url : contextPath + "/fetchEmptyParkings",
			type : "GET",
			async : false,
			contentType : "application/json",
			success : function(data) {
				if($.type(data) === "string"){
					$('div#emptyParkingStatus').html(data);
				}
				else{
					 $('#parkingTable').DataTable( {
					        data: data,
					        "paging":   false,
					        "info":     false,
					        "searching": false,
					        columns: [
					            { data: "level" },
					            { data: "slot" },
					            { data: "vehicleNumber" }
					        ],
					        "columnDefs": [
					            {
					                "targets": [ 0 ],
					                "title": "Level",
					            },
					            {
					                "targets": [ 1 ],
					                "title": "Slot",
					            },
					            {
					                "targets": [ 2 ],
					                "visible": false,
					                "searchable": false
					            }
					        ]
					    } );
				}

			},
			error : function(error) {
				$('div#emptyParkingStatus').html(error);
			}
		});
	}
</script>
</head>
<body>
	<h2 style="text-align: center;">Welcome to Vehicle Parking
		Management</h2>
	<div style="text-align: center;">
		Please select an action : <br> <br>
		
		<button type="submit" value="parkVehicle" class="button"
			onclick="toggleMenuItem('togglePark')">Park a vehicle</button>
		<br>
		<div id="togglePark" style="display: none">
			<div class="parking">
				<div class="text">Select Vehicle Type :</div>
				<select id="vehicleType" class="dropdown">
					<option value="Car">Car</option>
					<option value="MotorCycle">MotorCycle</option>
				</select>
				<div class="text">Vehicle Number :</div>
				<input id="vechicleNumber" type="text">
				<div class="text">Model :</div>
				<input id="model" type="text">
				<div class="text">Model Year:</div>
				<input id="modelYear" type="text"><br> <input
					type="submit" id="savebtn" onclick="parkVehicle()" value="Submit">
				<div id="parkingStatus"></div>
			</div>
		</div>
		<br>
		
		<button type="submit" value="unparkVehicle" class="button"
			onclick="toggleMenuItem('toggleUnpark')">Unpark a vehicle</button>
		<br>
		<div id="toggleUnpark" style="display: none">
			<div class="parking">
				<!-- <div class="text">Select Vehicle Type :</div>
				<select id="unparkVehicleType" class="dropdown">
					<option value="Car">Car</option>
					<option value="MotorCycle">MotorCycle</option>
				</select> -->
				<div class="text">Vehicle Number :</div>
				<input id="unparkVechicleNumber" type="text"> <input
					type="submit" id="savebtn" onclick="unparkVehicle()" value="Submit">
				<div id="unparkStatus"></div>
			</div>
		</div>
		<br>
		
		<button type="submit" value="locateVehicle" class="button"
			onclick="toggleMenuItem('toggleLocate')">Locate a vehicle</button>
		<br>
		<div id="toggleLocate" style="display: none">
			<div class="parking">
				<!-- <div class="text">Select Vehicle Type :</div>
				<select id="locateVehicleType" class="dropdown">
					<option value="Car">Car</option>
					<option value="MotorCycle">MotorCycle</option>
				</select> -->
				<div class="text">Vehicle Number :</div>
				<input id="locateVechicleNumber" type="text"> <input
					type="submit" id="savebtn" onclick="locateVehicle()" value="Submit">
				<div id="locationStatus"></div>
			</div>
		</div>
		<br>
		
		<button type="submit" value="getEmptyParkings" class="button"
			onclick="toggleEmptyParking()">Find Empty parking slots</button>
		<div id="toggleEmptyParking" style="display: none">
			<div class="parking">
				<table id="parkingTable"></table>
				<div id="emptyParkingStatus"></div>
			</div>
		</div>
		
	</div>
</body>
</html>