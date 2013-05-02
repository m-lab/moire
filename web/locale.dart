part of moire; 

/**
 * An object that keeps track of the location under consideration. 
 * Contains either a [latitude] and [longtitude] that can be used to find
 * other parameters using the [getNearest] method, or it contains [continent],
 * [country],[region] and [city] based on the M-lab API. 
 */

class Locale{
  final double latitude;
  final double longtitude;
  final String continent;
  final String country;
  final String region;
  final String city;
  //TODO: make everything final that is set in the constructor, check validation in the constructor. 
  //TODO: add tostring method that returns string we are using everywhere
  
  Locale(this.latitude,this.longtitude,this.continent,this.country,this.region,this.city);
  
  String toString(){ 
    String location = '';
    if (this.country !=''){
      location += '${this.country}';
    } 
    if (this.region !=''){
      location += '_${this.region}';
    }
    if (this.city !=''){
      location += '_${this.city}';
    }
    print('location to string resulted in ${location}');
    return location;
  }
 
  
  /**
   * Requests nearest existing location using a [lat] and [lon]. 
   * Formats latitude and longtitude into the proper HTTP GET URL, and performs
   * a HTTP request. 
   * On response, loades the children locations, grabs the JSON string, and
   * maps the response to variables. 
   * Throws an [Exception] if [lat] and [lon] are malformed, or 
   * Metrics API server cannot be reached.
   */
  
  //TODO: error handling for empty Http response, no response from server, malformed location string
 
  Future<Map> getNearest(double lat, double lon){
    String url = 'http://mlab-metrics-api-server.appspot.com/api/nearest?lat=$lat&lon=$lon';
    
    Completer completer = new Completer();
    HttpRequest.getString(url).then((response) {

      print(response);
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else { 
        completer.complete(result["city"]);
        print('The nearest city is ${result["city"]}');
      }
    });
    return completer.future;
  }
  
  /**
   * Requests the parent location of a location using the M-lab Metrics API. 
   * Formats Locale into the proper HTTP GET URL, and performs a HTTP request. 
   * Throws an [Exception] if [Locale] doesn't have the appropriate values, or 
   * Metrics API server cannot be reached.
   */
  //TODO: error handling for empty Http response, no response from server, malformed location string
 
  Future<Map> getParent(){
    String location = this.toString();
    print(location);
    String url = 'http://mlab-metrics-api-server.appspot.com/api/locale/$location';
    
    Completer completer = new Completer();
    HttpRequest.getString(url).then((response) {

      print(response);
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        completer.complete(result["parent"]);
        print('The parent of your location is ${result["parent"]}');
      }
    })
    .catchError((error) => print(error));
    return completer.future;
  }
  
  /**
   * Requests the children locations of a location using the M-lab Metrics API. 
   * Formats Locale into the proper HTTP GET URL, and performs a HTTP request. 
   * Throws an [Exception] if [Locale] doesn't have the appropriate values, or 
   * Metrics API server cannot be reached.Callers of this can use 'getChildren().then((List l) { ... })
   */
  
  // TODO: this won't do what you think - the loadChildren return won't be
  // returned to the caller. Instead, you probably want this to return a
  // Future<List> that is only completed once loadChildren is called. Then
  // callers of this can use 'getChildren().then((List l) { ... });'
  
  Future<Map> getChildren(){
    String location = this.toString();
    String url = 'http://mlab-metrics-api-server.appspot.com/api/locale/$location';

    Completer completer = new Completer();
    HttpRequest.getString(url).then((response) {

      print(response);
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        completer.complete(result["children"]);
        print('The children of your location are ${result["children"]}');
      }
    })
    .catchError((error) => print(error));
    return completer.future;
  }
  
}