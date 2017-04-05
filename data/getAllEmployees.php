<?php 
	// Import connection file
	include ('connect.php');

  // Connect to the database, connection string
	$mysqli = new mysqli($hostname, $username, $password, $database);

  if (mysqli_connect_errno()) {
    printf("Connection failed: %s\n", mysqli_connect_error());
    exit();
  }

  $result = $mysqli->query("CALL sp_getAllEmployees()");

  $employees = array();
  
  if($result) {
    while ($row = $result->fetch_object()) {
      $employees[] = $row;
    }
    $mysqli->next_result();
  }
  echo json_encode($employees);
?>