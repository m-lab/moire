part of moire;

/**
 * An object that keeps track of the period under consideration. 
 * Contains a [startDate] and [endDate] that keeps the start of 
 * the period using the [DateTime] class. 
 */

class Period{
  DateTime startDate;
  DateTime endDate;
  
  Period(String start, String end) { // constructor with instance parameters
    this.startDate = DateTime.parse(start);
    this.endDate = DateTime.parse(end);
  }
 
  /**
   * Updates a period [startDate] and [endDate] using a UTC formatted string. 
   */
  
  void updatePeriod(Period, [start, end]){
    Period.startDate = DateTime.parse(start);
    Period.endDate = DateTime.parse(end);
  }
  
  /**
   * Updates a period [startDate] using a UTC formatted string. 
   * Throws an [Exception] if [startDate] is not UTC formatted.
   */
  //TODO: exception handling, non UTC formated or zero case
  void updateStartDate(String StartDate){
    if(StartDate != ''){
      this.startDate = DateTime.parse(StartDate);
    } else {
      print('StartDate value must be greater than zero');
    }
  }
  
  /**
   * Updates a period [endDate] using a UTC formatted string. 
   * Throws an [Exception] if [endDate] is not UTC formatted.
   */
  //TODO: exception handling, non UTC formated or zero case
  void updateEndDate(String endDate){
    if(endDate != ''){
      this.endDate = DateTime.parse(endDate);
    } else {
      print('EndDate value must be greater than zero');
    }
  }
}