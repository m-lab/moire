part of moire;

/**
 * Returns the average of a list of metrics. A list of metrics
 * is used to compute aggregates over time.
 */
MetricValue getAverage(List<MetricValue> l) {
  assert(l != null);
  if (l.isEmpty)
    return null;
  assert(l.every((e) => e.units == l.first.units));
  double sum = 0.0;
  l.forEach((e) => sum += e.value);
  double avg = sum / l.length;
  // print('Your average is ${avg}');
  return new MetricValue(avg, l.first.units);
}

/**
 * Returns the percentage change of a list of metrics.A list of metrics
 * is used to compute aggregates over time.
 */
MetricValue getChange(List<MetricValue> l) {
  assert(l != null);
  if (l.isEmpty)
    return null;
  assert(l.every((e) => e.units == l.first.units));
  double change = ((l.last.value - l.first.value) / l.last.value) * 100;
  // print('Your change is ${change} or (${change.toStringAsFixed(1)} %)');
  return new MetricValue(change, l.first.units);
}