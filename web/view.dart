part of moire;

class View {
  Controller _controller;

  View(this._controller);

  Locale get locale => _controller.locale;

  // Dates
  String get startMonth => _controller.startMonth;
  String get startYear => _controller.startYear;
  String get endMonth => _controller.endMonth;
  String get endYear => _controller.endYear;

  String set startMonth(String startMonth) => _controller.startMonth = startMonth;
  String set startYear(String startYear) => _controller.startYear = startYear;
  String set endMonth(String endMonth) => _controller.endMonth = endMonth;
  String set endYear(String endYear) => _controller.endYear = endYear;

  // Alerts
  void _addError(String error) => _addAlert(error, true);

  DivElement _addAlert(String alert, [bool isError = false]) {
    ButtonElement closeButton = new ButtonElement();
    closeButton.text = "x";
    closeButton.type = "button";
    closeButton.classes.add("close");
    closeButton.attributes["data-dismiss"] = "alert";

    SpanElement errorText = new SpanElement();
    errorText.text = alert;

    DivElement errorDiv = new DivElement();
    errorDiv.classes.add("alert");
    if (isError) errorDiv.classes.add("alert-error");
    errorDiv.children.add(closeButton);
    errorDiv.children.add(errorText);

    query("#alerts").children.add(errorDiv);
    return errorDiv;
  }
}