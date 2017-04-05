<?php 
	// Import connection file
	include ('connect.php');

	// Connect to the database, connection string
	$mysqli = new mysqli($hostname, $username, $password, $database);

	// Test connection
	if (mysqli_connect_errno()) {
		printf("Connection to database failed: %s\n", mysqli_connect_error());
		exit;
	}
	// Retreive param from http POST
	$ID = $_POST['ID'];

	if ($ID) {

		$result = $mysqli->query("CALL sp_getEmployeeByID('". $ID ."')");

		$employee = array();
		
		if($result) {
			while ($row = $result->fetch_object()) {
				$employee[] = $row;
			}
			$mysqli->next_result();
		}
		echo json_encode($employee);
		exit;
	} else {	
		echo json_encode(array('error' => TRUE, 'message' => 'a problem occured'));
		exit;
	}
?>