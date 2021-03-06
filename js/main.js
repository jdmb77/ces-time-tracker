/**
 * Created 20170329
 * Author: JLW
 * Purpose: JS for TimeTracker mobile
 */
$(document).on("pageinit", "#tt-page", () => {
  let seconds = 0
  let minutes = 0
  let hours = 0
  let t

  function add() {
    seconds++
    if (seconds >= 60) {
      seconds = 0
      minutes++
      if (minutes >= 60) {
        minutes = 0
        hours++
      }
    }
    let timeValue = (hours ? (hours > 9 ? hours : "0" + hours) : "00") + ":" + (minutes ? (minutes > 9 ? minutes : "0" + minutes) : "00") + ":" + (seconds > 9 ? seconds : "0" + seconds)
    $('#tt-timer').val(timeValue)
    $('#tt-clock').text(timeValue)
    timer()
  }

  function timer(e) {
    t = setTimeout(add, 1000)
  }

  $('#tt-start-btn').bind('click', timer)

  $('#tt-stop-btn').bind('click', (e) => {
    clearTimeout(t)
  })

  $.getJSON('data/getAllJobs.php')
    .done((data) => {
      let jobSelectList = ''
      for (job in data) {
        jobSelectList += `<option data-lat="${data[job].Latitude}" data-lng="${data[job].Longitude}" value="${data[job].JobID}">${data[job].JobName}</option>`
      }
      $('#tt-select-job').append(`<option value="" selected="selected">--- JOBS ---</option>${jobSelectList}`)
      const selectText = $('body').find('span')
      selectText[0].innerHTML = "Select Job"
    })
    .fail((jqxhr, textStatus, error) => {
      console.error(`getAllJobs.php failed: Status: ${textStatus}, Error: ${error}`)
    })

  $.getJSON('data/getAllEmployees.php')
    .done((data) => {
      let employeeSelectList = ''
      for (employee in data) {
        employeeSelectList += `<option value="${data[employee].EmployeeID}">${data[employee].LastName}, ${data[employee].FirstName}</option>`
      }
      $('#tt-select-employee').append(`<option value="" selected="selected">--- EMPLOYEES ---</option>${employeeSelectList}`)
      const selectText = $('body').find('span')
      selectText[1].innerHTML = "Select Employee"
    })
    .fail((jqxhr, textStatus, error) => {
      console.error(`getAllEmployees.php failed: Status: ${textStatus}, Error: ${error}`)
    })

  function notifications(type = "success", icon = "check", msg = "Time submitted!") {
    let alertHTML = `<div class="alert alert-${type}"><a href="#" class="ui-btn ui-shadow ui-corner-all ui-icon-${icon} ui-btn-icon-notext"></a> <h4>${msg}</h4></div>`
    $('#tt-messages').html(alertHTML)
    $('#tt-messages').show()
  }

  function getEmployeeRec (employeeID) {
    $.ajax({
      method: "POST",
      data: { 'EmployeeID': employeeID },
      url: "data/getTimeByID.php",
      dataType: "JSON"
    })
    .done((data, textStatus, jqXHR) => {
      console.log(data)
      notifications()
      $('#tt-messages').fadeOut(5000)
    })
    .fail(( jqXHR, textStatus, errorThrown) => {
      console.error(textStatus, errorThrown)    
    })
  }

  $('#tt-select-job').bind('change', (e) => {
    let jobMapLat = $('#tt-select-job').find(':selected').data('lat')
    let jobMapLng = $('#tt-select-job').find(':selected').data('lng')
    let jobLoc = { lat: parseFloat(jobMapLat), lng: parseFloat(jobMapLng) }

    let map = new google.maps.Map(document.getElementById('tt-map'), {
      zoom: 12,
      center: jobLoc
    })

    let marker = new google.maps.Marker({
      position: jobLoc,
      map: map
    })
  })

  $('#tt-submit-time').bind('click', (e) => {
    let formValues = $('#tt-form').serializeArray()
    let jobID = parseInt(formValues[0].value)
    let employeeID = parseInt(formValues[1].value)
    let endTime = formValues[2].value

    if (jobID != NaN && employeeID != NaN && endTime != "0") {
      if (typeof(Storage) != undefined) {
        let timeSubmitted = {'JobID': jobID, 'EmployeeID': employeeID, 'EndTime': endTime}
        localStorage.setItem('last_recorded_time', JSON.stringify(timeSubmitted))
      }
      $.ajax({
        method: "POST",
        data: { 'JobID': jobID, 'EmployeeID': employeeID, 'EndTime': endTime },
        url: "data/insertTime.php",
        dataType: "JSON"
      })
      .done((data, textStatus, jqXHR) => {
        getEmployeeRec(employeeID)     
        let locallyStored = localStorage.getItem('last_recorded_time')
        console.log(JSON.parse(locallyStored))   
      })
      .fail(( jqXHR, textStatus, errorThrown) => {
        console.error(textStatus, errorThrown)    
      })
    } else if (jobID == NaN || employeeID == NaN || endTime == "0") {
      notifications("danger", "alert", "Please select all options!")
    }
  })
})