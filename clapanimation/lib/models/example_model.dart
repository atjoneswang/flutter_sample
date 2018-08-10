class ExampleModel {
  final String title;
  final String shortDescription;
  final String route;

  const ExampleModel(this.title, this.shortDescription, this.route);
}

class Routes {
  static const String animation = "/animation";
  static const String designui = "/ui";
  static const String bottomnav = "/bottomnav";
  static const String scopemodel = "/scopemodel";
  static const String stream = "/stream";
  static const String datatable = "/datatable";
  static const String backdrop = "/backdrop";
}

List<ExampleModel> initModels = [
  const ExampleModel("Animation", "Clap Animation", Routes.animation),
  const ExampleModel("UI", "Design UI", Routes.designui),
  const ExampleModel(
      "Bottom Navigation", "Bottom Navigation Bars", Routes.bottomnav),
  const ExampleModel("Scoped Model", "Counter Demo", Routes.scopemodel),
  const ExampleModel("Stream", "Stream Demo", Routes.stream),
  const ExampleModel("DataTable", "Data Table demo", Routes.datatable),
  const ExampleModel("BackDrop", "BackDrop page", Routes.backdrop),
];
