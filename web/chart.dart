part of moire;

class Chart {
  View _view;
  String _divName;
  String _metricType;
  var _legend;
  int _width;
  int _height;

  Chart(this._view, this._divName, this._metricType, this._legend,
        this._width, this._height);

  //Draws graph using the Vizualization API.
  void drawGraph() {
    js.context.google.load('visualization', '1', js.map({
        'packages': ['corechart'],
        'callback': new js.Callback.once(_buildGraph)
    }));
  }

  //Builds graph using the Vizualization API.
  //TODO: check getter error in js.context.google, because it seems to work
  //TODO: pass data from other methods to build the graph.
  void _buildGraph() {
    
    // Create and populate the data table.
    _view.controller.getMetricsForPeriod(_metricType)
      .then((Map<DateTime, MetricValue> results) {
        List<List> listData = new List<List>();
        listData.add(['Date', 'Value']);
        results.forEach((k, v) {
          listData.add([k.toString(), v.value]);
        });

        var arrayData = js.array(listData);

        var gviz = js.context.google.visualization;
        var tableData = gviz.arrayToDataTable(arrayData);

        // Sets options for chart.
        //TODO: subclasses have other options
        var options = js.map({
          'curveType': "none",
          'title': '${kMetrics[_metricType].name}',
          'width': '$_width',
          'height': '$_height',
        });

        // Create and draw the visualization.
        var chart = new js.Proxy(gviz.LineChart, query('#$_divName'));
        chart.draw(tableData, options);
    })
    .catchError((dynamic e) {
        if (e is String)
          _view._addError(e);
        else
          _view._addError(e.toString());
    });
  }
}
