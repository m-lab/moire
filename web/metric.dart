part of moire;


const Map<String, Metric> kMetrics = const<String, Metric> {
  "min_rtt": const Metric("Minimum RTT", "the minimum RTT", "NDT"),
  "upload_throughput_max": const Metric("Upload throughput max",
                                        "the maximum upload throughput",
                                        "NDT"),
  "upload_throughput_med": const Metric("Upload throughput med",
                                        "the median upload throughput", "NDT"),
  "download_throughput_max": const Metric("Download throughput max",
                                          "the maximum download throughput",
                                          "NDT"),
  "download_throughput_med": const Metric("Download throughput med",
                                          "the median download throughput",
                                          "NDT"),
};

/**
 * Metadata for a specific metric.
 * Contains a [name] (i.e. Minimum Roundtrip Time, and a [description] of the
 * metric, and [test] is used to calculate the metric.
 */
class Metric {
  final String name;
  final String description;
  final String test;

  const Metric(this.name, this.description, this.test);
}