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
	//$ID = $_POST['ID'];
	$ID = 2;
	if ($ID) {

		$result = $mysqli->query("CALL sp_getTimeByID('". $ID ."')");

		$time = array();
		
		if($result) {
			while ($row = $result->fetch_object()) {
				$time[] = $row;
			}
			$mysqli->next_result();
		}
		echo json_encode($time);
		exit;
	} else {	
		echo json_encode(array('error' => TRUE, 'message' => 'a problem occured'));
		exit;
	}
?>