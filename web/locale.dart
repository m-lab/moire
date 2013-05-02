part of moire;

/**
 * An object that keeps track of the location under consideration.
 * Contains either a [latitude] and [longtitude] that can be used to find
 * other parameters using the [getNearest] method, or it contains [continent],
 * [country],[region] and [city] based on the M-lab API.
 */

class Locale{
  final String continent;
  final String country;
  final String region;
  final String city;
    
  static Future<Locale> fromLatitudeAndLongitude(double latitude, double longitude) {
    Completer completer = new Completer();

    HttpRequest.getString("URL_TO_GET_COUNTRY_FROM_LAT_LONG").then((String response) {
      Map data = parse(response);
      if (data.containsKey("error")) {
        completer.completeError(data["error"]);
      } else {
        completer.complete(new Locale(country: data["country"],
                                      region: data["region"],
                                      city: data["city"]));
      }
    });

    return completer.future;
  }

  Locale({this.continent: "", this.country: "", this.region: "", this.city: ""});

 
  //TODO: make everything final that is set in the constructor, check validation in the constructor. 
    
  String toString(){ 
    String location = '';
    if (!this.country.isEmpty) {
      location += '${this.country}';
    }
    if (!this.region.isEmpty) {
      location += '_${this.region}';
    }
    if (!this.city.isEmpty) {
      location += '_${this.city}';
    }
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