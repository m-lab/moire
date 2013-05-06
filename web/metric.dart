part of moire;

/**
 * An object that keeps track of a specific metric.
 * Contains a [name] (i.e. Minimum Roundtrip Time, a [type] (min_rtt) that keeps track of the
 * measurement type for the API, [description] is the definition of the metric,
 * and [test] is the test used to compute the metric.
 */
class Metric {

  const List<String> kSupportedMetrics = const<String>["min_rtt",
                                                        "average_download_speed",
                                                        "average_upload_speed",
                                                        "upload_throughput_max",
                                                        "download_througput_max"];
  String name;
  String type;
  String description;
  String test;

  Metric(this.name, this.type, this.description, this.test) {
    assert(kSupportedMetrics.contains(type));
  }
}