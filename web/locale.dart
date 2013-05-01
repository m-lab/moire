part of moire; 

/**
 * An object that keeps track of the location under consideration. 
 * Contains either a [latitude] and [longtitude] that can be used to find
 * other parameters using the [getNearest] method, or it contains [continent],
 * [country],[region] and [city] based on the M-lab API. 
 */

class Locale{
  double latitude;
  double longtitude;
  String continent;
  String country;
  String region;
  String city;
  String type;
  
  Locale(this.latitude,this.longtitude,this.continent, this.country,this.region, this.city, this.type);
  
  /**
   * Requests the parent location of a location using the M-lab Metrics API. 
   * Formats Locale into the proper HTTP GET URL, and performs a HTTP request. 
   * [loadParent] handles the response of the request. 
   * Throws an [Exception] if [Locale] doesn't have the appropriate values, or 
   * Metrics API server cannot be reached.
   */
  //TODO: error handling, todo, generic api request handling
  void getParent(){
        var location = "${this.country}_${this.region}_${this.city}";
    var url = 'http://mlab-metrics-api-server.appspot.com/api/locale/$location';
    var request = HttpRequest.getString(url).then(loadParent);
  }
  
  /**
   * Loads the parent location using the HTTP response. 
   * Grabs the JSON string and maps the respons to variables.
   * Returns parent. 
   */
  //TODO: error handling, todo, generic response parser
  String loadParent(String response_text){
    print(response_text);
    Map response = parse(response_text);
    var parent = response['parent'];
    print(parent);
    return parent;
  }
  
  /**
   * Requests the children locations of a location using the M-lab Metrics API. 
   * Formats Locale into the proper HTTP GET URL, and performs a HTTP request. 
   * [loadChildren] handles the response of the request. 
   * Throws an [Exception] if [Locale] doesn't have the appropriate values, or 
   * Metrics API server cannot be reached.
   */
  
  void getChildren(){
    var location = "${this.country}";
    var url = 'http://mlab-metrics-api-server.appspot.com/api/locale/$location';
    var request = HttpRequest.getString(url).then(loadChildren);
  }
  
  /**
   * Loads the children locations using the HTTP response. 
   * Grabs the JSON string and maps the respons to variables.
   * Returns list of children. 
   */ 
  //TODO: map multiple children in the JSON. Issues with Map value types. Error handling. 
  List loadChildren(String response_text){
    print(response_text);
    Map response = parse(response_text);
    var parent = response['parent'];
    //TODO: error handling, get every child in the list (subtyping problem now)
    for (Map t in response["children"]) 
      print(t["children"]);
  }
 
  /**
   * Requests nearest existing location using a [lat] and [long]. 
   * Formats latitude and longtitude into the proper HTTP GET URL, and performs a HTTP request. 
   * [loadNearest] handles the response of the request. 
   * Throws an [Exception] if [lat] and [lon] are malformed, or 
   * Metrics API server cannot be reached.
   */
  
  void getNearest(double lat, double lon){
    var url = 'http://mlab-metrics-api-server.appspot.com/api/nearest?lat=$lat&lon=$lon';
    var request = HttpRequest.getString(url).then(loadNearest);
  }
  
  /**
   * Loads the children locations using the HTTP response. 
   * Grabs the JSON string and maps the respons to variables.
   * Returns a Location. 
   */ 
  //TODO: fix API server and make sure it doesnt respond with a 500
  void loadNearest(String response_text){
    print(response_text);
  }

}