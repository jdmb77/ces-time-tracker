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
	$JID = $_POST['JobID'];
  $EID = $_POST['EmployeeID'];
	$STARTTIME = "00:00:00";
  $ENDTIME = $_POST['EndTime'];

  //$JID = 2;
  //$EID = 2;
  //$STARTTIME = "00:00:00";
  //$ENDTIME = "19:19:19";

	if ($JID) {

		$result = $mysqli->query("CALL sp_insertTime('". $JID ."', '". $EID ."', '". $STARTTIME ."', '". $ENDTIME ."')");

		//$time = array();
		//echo $result;
		if($result) {
			echo json_encode($result);
		}
		exit;
	} else {	
			echo json_encode(array('error' => TRUE, 'message' => 'a problem occured'));
		exit;
	}
?>