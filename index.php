<!DOCTYPE html>
<html lang="en">
<head>
  <title id='Description'>jQuery mobile demo</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/jquery.mobile-1.4.5.min.css" />
  <link rel="stylesheet" href="css/main.css" />
	<script src="js/vendor/jquery-1.11.1.min.js"></script>
	<script src="js/vendor/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
  <div data-role="page" id="tt-page">
    <div data-role="header" id="tt-header">Time Tracker</div>
    <div role="main" class="ui-content">
      <div id="tt-messages">
        <!-- Notifications -->
      </div>
      <form method="POST" id="tt-form">
        <select name="JobID" id="tt-select-job" data-icon="location" data-iconpos="left"></select>
        <select name="EmployeeID" id="tt-select-employee" data-icon="user" data-iconpos="left"></select>
        <div class="ui-grid-a">
          <div class="ui-block-a">
            <input id="tt-start-btn" type="button" value="Start Time" data-icon="plus" data-iconpos="top">
          </div>
          <div class="ui-block-b">
            <input id="tt-stop-btn" type="button" value="Stop Time" data-icon="minus" data-iconpos="top">
          </div>
        </div>
        <input name="EndTime" id="tt-timer" type="hidden" value="0">
        <input id="tt-submit-time" type="button" value="Submit Time" data-icon="clock">
      </form>
      <div id="tt-clock">00:00:00</div>
    </div>
  </div>
  <script src="js/main.js"></script>
</body>
</html>