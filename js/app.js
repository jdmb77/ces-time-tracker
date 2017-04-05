$(() => {
  //$.jqx.theme = 'office'
  // START // Job select combo //
  const jobSource = {
    datatype: 'json',
    datafields: [
      { name: 'JobID' },
      { name: 'JobName' }
    ],
    url: 'data/getAllJobs.php',
    async: false
  }

  const jobDataAdapter = new $.jqx.dataAdapter(jobSource)

  $('#job-select').jqxComboBox({
    placeHolder: "Select Job",
    source: jobDataAdapter,
    displayMember: 'JobName',
    valueMember: 'JobID',
    width: 250
  })

  $('#job-select').on('select', (e) => {
    if (e.args) {
      let item = e.args.item
      if (item) {
        let jobDetails = JSON.parse(jobDataAdapter.xhr.responseText)
        for (let JID in jobDetails) {
          if (jobDetails[JID].JobID == item.value) {
            const jd = jobDetails[JID]
            $('#job-details').html(`
              <div class="panel panel-success">
                <div class="panel-heading">
                  <h3 class="panel-title">${jd.JobName} | Job #${jd.JobNum}</h3>
                </div>
                <div class="panel-body">
                  ${jd.Address}
                </div>
              </div>`)
          }
        }
      }
    }
  })// END // Job select combo //

  // START // Employee select combo //
  const employeeSource = {
    datatype: 'json',
    datafields: [
      { name: 'EmployeeID' },
      { name: 'FirstName' },
      { name: 'LastName' }
    ],
    url: 'data/getAllEmployees.php',
    async: false
  }

  const employeeDataAdapter = new $.jqx.dataAdapter(employeeSource)

  $('#employee-select').jqxComboBox({
    placeHolder: "Select Employee",
    source: employeeDataAdapter,
    displayMember: 'LastName',
    valueMember: 'EmployeeID',
    width: 250
  })

  $('#employee-select').on('select', (e) => {
    if (e.args) {
      let item = e.args.item
      if (item) {
        let employeeDetails = JSON.parse(employeeDataAdapter.xhr.responseText)
        for (let EID in employeeDetails) {
          if (employeeDetails[EID].EmployeeID == item.value) {
            const empd = employeeDetails[EID]
            console.log(empd)
            /*$('#job-details').html(`
              <div class="panel panel-success">
                <div class="panel-heading">
                  <h3 class="panel-title">${empd.JobName} | Job #${empd.JobNum}</h3>
                </div>
                <div class="panel-body">
                  ${empd.Address}
                </div>
              </div>`)*/
          }
        }
      }
    }
  })// END // Employee select combo //

  // Start // Toggle button for time //
  $('#stopwatch-toggle').jqxToggleButton({
    width: 250,
    disabled: false
  })

  $('#stopwatch-toggle').on('click', () => {
    let toggled = $('#stopwatch-toggle').jqxToggleButton('toggled')
    if (toggled) {
      $('#stopwatch-toggle')[0].value = 'STOP TIME'
    } else {
      $('#stopwatch-toggle')[0].value = 'START TIME'
    }
  })
}) // END // Toggle button for time //


  /*$.ajax({
      method: "POST",
      data: { 'ID': 2 },
      url: "data/getTimeByID.php",
      dataType: "JSON"
    })
    .done(function(data, textStatus, jqXHR) {
      console.log(data)
      for (let i = 0; i <= data.length; i++) {
      console.log(data[i])
      }
    })
    .fail(function( jqXHR, textStatus, errorThrown) {
      console.error(textStatus, errorThrown)    
    })*/
