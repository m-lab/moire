part of moire;

/**
 * An object that keeps track of a specific metric. 
 * Contains a [name] (i.e. Minimum Roundtrip Time, a [type] (min_rtt) that keeps track of the 
 * measurement type for the API, the [unit] describes the unit of measurement, [description]
 * describes the definition of the metric, [test] describes the test used to compute
 * the metric, [value] is the metric value and [date] contains the date the value was recorded for
 * currently we only support metrics on a montly basis. 
 */
//TODO: date should be a data object
class Metric{
  String name;
  String type;
  String unit;
  String description;
  String test;
  double value;
  var date;
  
  Metric(this.name,this.type,this.unit,this.description,this.test,this.value,this.date);
 
}