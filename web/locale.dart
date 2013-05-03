part of moire;

/** Represents a location. */
class Locale {
  final String continent;
  final String country;
  final String region;
  final String city;

  /** Constructs a Locale that is nearest to a given [latitude] and [longitude]. */
  static Future<Locale> fromLatitudeAndLongitude(double latitude, double longitude) {
    Completer completer = new Completer();

    String url = "$kMetricsAPIUrl/nearest?lat=$latitude&lon=$longitude";

    HttpRequest.getString(url).then((response) {
      print(response);
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        Locale l = new Locale(country: result["country"],
                              region: result["region"],
                              city: result["city"]);
        print('The nearest location is $l');
        completer.complete(l);
      }
    });

    return completer.future;
  }

  Locale({this.continent: "", this.country: "", this.region: "", this.city: ""});

  String toString() {
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
   * Requests the parent location of a location using the M-lab Metrics API.
   * Formats Locale into the proper HTTP GET URL, and performs a HTTP request.
   * Throws an [Exception] if [Locale] doesn't have the appropriate values, or
   * Metrics API server cannot be reached.
   */
  //TODO: error handling for empty Http response, no response from server, malformed location string

  Future<Map> getParent() {
    String location = this.toString();
    print(location);
    String url = "$kMetricsAPIUrl/locale/$location";

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
  Future<Map> getChildren() {
    String location = this.toString();
    String url = "$kMetricsAPIUrl/locale/$location";

    Completer completer = new Completer();
    HttpRequest.getString(url).then((response) {
      print(response);
      Map result = parse(response);
      if (result.containsKey("error")) {
        completer.completeError(result["error"]);
      } else {
        print('The children of your location are ${result["children"]}');
        completer.complete(result["children"]);
      }
    })
    .catchError((error) => print(error));
    return completer.future;
  }
}
