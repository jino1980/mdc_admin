<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<div class="jumbotron">
    <h1>Admin</h1>
</div>

<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">google chart</div>
    <div class="panel-body">
        <div class="clearfix">
            <div class="row">
                <div id="line_chart_div"></div>
            </div>
            <div class="row">
                <hr>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div id="pie_chart_div"></div>
                </div>
                <div class="col-md-4">
                    <div id="table_div"></div>
                </div>
                <div class="col-md-4">
                    <div id="gauge_div"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:url var="signUpInsert" value="/signUpInsert" />
<form class="form-horizontal" action="${signUpInsert}" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div class="form-group">
        <label class="control-label col-sm-2" for="name">Name:</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="name" placeholder="Enter username" name="name">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-2" for="pwd">Password:</label>
        <div class="col-sm-10">          
            <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
        </div>
    </div>
    <div class="form-group">        
        <div class="col-sm-offset-2 col-sm-10">
            <button type="submit" class="btn btn-default">Submit</button>
        </div>
    </div>
</form>

<script>
    /* Line chart
     */
    // sample data make -- start
    function getRandomIntInclusive(min, max) {
      return Math.round(Math.random() * (max - min + 1)) + min;
    }
    var cnt = 0;
    var tempArry = [];
    // sample data make -- end

    // google line chart example
    google.charts.load('current', {packages: ['corechart', 'line', 'gauge', 'table']});
    google.charts.setOnLoadCallback(load_page_data);

    function load_page_data() {
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', 'User');
      data.addRows(20);
      // data.setCell(rowNumber, X, UserCount);
      for (var i=0; i < 20; i++) {
        data.setCell(i, 0, 0);
        data.setCell(i, 1, 0);
      }

      // basic chart draw
      drawChart(data);

      // chart update
      setInterval(function() {
        $.ajax({
          url: '/home/admin',
          data: '2017',
          async: false,
          success: function(d) {
            if (d) {
              cnt += 1;
              var random = getRandomIntInclusive(0, 10);
              data.removeRow(1);
              data.addRows([[cnt, random]]);
              drawChart(data);
            }
          },
        });
      }, 1000);
    }

    function drawChart(data) {
      var options = {
        hAxis: {
          title: 'Time',
          logScale: true
        },
        vAxis: {
          title: 'Connection',
          logScale: false
        },
        colors: ['#a52714', '#097138']
      };

      var chart = new google.visualization.LineChart(document.getElementById('line_chart_div'));
      chart.draw(data, options);
    }
    
    
    /* Pie chart
     */
    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawPieChart);

    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawPieChart() {

      // Create the data table.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Topping');
      data.addColumn('number', 'Slices');
      data.addRows([
        ['Mushrooms', 3],
        ['Onions', 1],
        ['Olives', 1],
        ['Zucchini', 1],
        ['Pepperoni', 2]
      ]);

      // Set chart options
      var options = {'title':'How Much Pizza I Ate Last Night',
                     'width':400,
                     'height':300};

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.PieChart(document.getElementById('pie_chart_div'));
      chart.draw(data, options);
    }
    

    /* Guage
     */
     google.charts.setOnLoadCallback(drawGauge);

     function drawGauge() {
    	 var data = google.visualization.arrayToDataTable([
             ['Label', 'Value'],
             ['Memory', 80],
             ['CPU', 55],
             ['Network', 68]
           ]);

           var options = {
             width: 400, height: 120,
             redFrom: 90, redTo: 100,
             yellowFrom:75, yellowTo: 90,
             minorTicks: 5
           };

           var chart = new google.visualization.Gauge(document.getElementById('gauge_div'));

           chart.draw(data, options);

           setInterval(function() {
             data.setValue(0, 1, 40 + Math.round(60 * Math.random()));
             chart.draw(data, options);
           }, 13000);
           setInterval(function() {
             data.setValue(1, 1, 40 + Math.round(60 * Math.random()));
             chart.draw(data, options);
           }, 5000);
           setInterval(function() {
             data.setValue(2, 1, 60 + Math.round(20 * Math.random()));
             chart.draw(data, options);
           }, 26000);
     }
     
     /* table
      */
    google.charts.setOnLoadCallback(drawTable);

    function drawTable() {
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Name');
      data.addColumn('number', 'Salary');
      data.addColumn('boolean', 'Full Time Employee');
      data.addRows([
        ['Mike',  {v: 10000, f: '$10,000'}, true],
        ['Jim',   {v:8000,   f: '$8,000'},  false],
        ['Alice', {v: 12500, f: '$12,500'}, true],
        ['Bob',   {v: 7000,  f: '$7,000'},  true]
      ]);
     var table = new google.visualization.Table(document.getElementById('table_div'));
     table.draw(data, {showRowNumber: true, width: '100%', height: '100%'});
    }
</script>
