part of moire;

/**
 * An object that keeps track of the period under consideration.
 * Contains a [startDate] and [endDate] that keeps the start of
 * the period using the [DateTime] class.
 */
class Period {
  DateTime startDate;
  DateTime endDate;

  Period(this.startDate, this.endDate);

  Period.fromStrings(String start, String end)
      : startDate = DateTime.parse(start),
        endDate = DateTime.parse(end) {
    assert(startDate != null);
    assert(endDate != null);
  }

  void setStartDate(String start) {
    startDate = DateTime.parse(start);
    assert(startDate != null);
  }

  void setEndDate(String end) {
    endDate = DateTime.parse(end);
    assert(endDate != null);
  }
}