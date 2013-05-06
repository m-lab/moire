part of moire;

class View{
  String showTestCount() {
    return "lots and lots";
  }
  
  String showMetric(String metric_type) {
    String metricStr = "<loading>";
    controller.getMetric(metric_type, controller.startDate).then((content) {
      metricStr = content.toString();
//      watchers.dispatch();
    });
    return metricStr;
  }
  
  String showMetricChange(String metric_type) {
    String change = "<loading>";
    controller.getMetricsForPeriod(metric_type).then((content){
      change = controller.getChange(content).toStringAsFixed(3);   
    });
    return change;
  }
  
  String showMetricAverage(String metric_type) {
    String average = "<loading>";
    controller.getMetricsForPeriod(metric_type).then((List<double> content) {
      average = controller.getAverage(content).toStringAsFixed(3);
//      watchers.dispatch();
    })
    .catchError((e) => average = e);
    return average;
  }
  
  String showMetricName(String type) => kMetrics[type].name;
  String showMetricDefinition(String type) => kMetrics[type].description;
}

class Chart extends View{
  var title;
  var type;
  var legend;
  int width;
  int height;

  Chart(this.title,this.type,this.legend,this.width,this.height);

  //Draws graph using the Vizualization API.
  drawGraph(){
    js.context.google.load('visualization', '1', js.map(
        {
          'packages': ['corechart'],
          'callback': new js.Callback.once(this.buildGraph)
        }));
  }

  //Builds graph using the Vizualization API.
  //TODO: check getter error in js.context.google, because it seems to work
  //TODO: pass data from other methods to build the graph.
  void buildGraph() {
    var gviz = js.context.google.visualization;

    // Create and populate the data table.
    //TODO: get some real data.

    var listData = [
                    ['Month', 'UL'],
                    ['JAN',   1],
                    ['FEB',   2],
                    ['MAR',   4],
                    ['APR',   8],
                    ['MAY',   7],
                    ['JUN',   7],
                    ['JUL',   8],
                    ];

    var arrayData = js.array(listData);

    var tableData = gviz.arrayToDataTable(arrayData);

    // Sets options for chart.
    //TODO: subclasses have other options
    var options = js.map({
      'curveType': "function",
      'title': '${this.title}',
      'width': '${this.width}',
      'height': '${this.height}',
    });

    // Create and draw the visualization.
    var chart = new js.Proxy(gviz.LineChart,
        query('#visualization'));
    chart.draw(tableData, options);
  }
}

