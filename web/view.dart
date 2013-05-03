part of moire;

class View{

  void showHome(String path) {
    print('We are at index ${path}');
    this.generateGetMetrics();
    this.generateHomeStatic();
  }

  void showExplore(String path) {
    print('We are at explore: ${path}');
        // show article page with loading indicator
    // load article from server, then render article
  }

  void showRankings(String path) {
    print('We are at rankings: ${path}');
        // show article page with loading indicator
    // load article from server, then render article
  }

  void showMethods(String path) {
    print('We are at methods: ${path}');
        // show article page with loading indicator
    // load article from server, then render article
  }

  void showContacts(String path) {
    print('We are at contact: ${path}');
        // show article page with loading indicator
    // load article from server, then render article
  }

  void searchInput() {
    var search = query('#search-input');
    search.onChange.listen((Event e) {
      var newLocale = e.newValue;
      print('new locale $newLocale');
    });
  }

  void dateInput() {
    var date = query('#date-input');
    date.onChange.listen((Event e) {
      var newDate = e.newValue;
      print("new date $newDate");
    });
  }

  //Generates geMetrics section on the homepage
  void generateGetMetrics() {
    var metricunit = query("#metric-unit");
    var title = new Element.html("<h1>Get all the metrics!</h1>");
    var paragraph = new Element.html("<p>Find metrics for a country with an ugly id (for example 250)</p>");
    metricunit.children.add(title);
    metricunit.children.add(paragraph);

    InputElement metricInput = new Element.tag("input");
    metricInput.id = "metric-item";
    metricInput.placeholder = "What art thou country number?";
    metricInput.type = "text";
    metricunit.children.add(metricInput);


    ButtonElement searchButton = new Element.tag("button");
    searchButton.id = "btn-search";
    searchButton.text = "Search";
    searchButton.type = "button";
    //searchButton.onClick.listen((e) => getMetricResponse(metricInput.value));
    metricunit.children.add(searchButton);
  }

  void showMenu() {
    var navbar = new DivElement();
      navbar.$dom_className = 'navbar-inner';

    var container = new DivElement();
    navbar.$dom_className = 'container';

    var list = new UListElement();
    list.$dom_className = 'nav';

    var explore = new LIElement();
    explore.text = "Explore";
    var rankings = new LIElement();
    explore.text = "Rankings";
    var you = new LIElement();
    explore.text = "Your city";
    var methods = new LIElement();
    explore.text = "Methods";
    var contact = new LIElement();
    explore.text = "Contact";
  }

  void generateMasthead() {
    var masthead = query("#masthead");
    var title = new Element.html("<h3>Open Internet Report</h3>");
    var menu = new Element.html("""<div class="navbar">
          <div class="navbar-inner">
            <div class="container">
              <ul class="nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#">Explore</a></li>
                <li><a href="#">Rankings</a></li>
                <li><a href="#">Your City</a></li>
                <li><a href="#">Methods</a></li>
                <li><a href="#">Contact</a></li>
              </ul>
            </div>
          </div>""");

    masthead.children.add(title);
    masthead.children.add(menu);
    }
  //Generates static text section on the homepage
  void generateHomeStatic(){
    var homestatic = query("#home-static");

    var download = new Element.html("""
        <div class="span4">
        <h2>Get the report</h2>
        <p>Every quarter the Open Technology Institute publishes the State of the Web report. In this report you can find the details from quarter to quarter. The report is published under creative commons so fee free to re-use is.</p>
        <p><a class="btn" href="#">PDF</a><a class="btn" href="#">ePub</a></p>
        </div>
    """);

    var countries = new Element.html("""
        <div class="span4">
        <h2>Countries we cover</h2>
        <p>The Open Internet report is based on over 3.3 billion measurements worldwide in 2013. We cover most of the world but for some countries we might not have enough data to draw conclusions. </p>
        <p><a class="btn" href="#">Learn more&raquo;</a></p>
        </div>
    """);

    var explenation = new Element.html("""
        <div class="span4">
        <h2>Fair &amp; Honest measurement</h2>
        <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa.</p>
        <p><a class="btn" href="#">Learn more</a></p>
        </div>
    """);

    homestatic.children.add(download);
    homestatic.children.add(countries);
    homestatic.children.add(explenation);
  }

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

