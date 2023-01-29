enum Routes {
  map(name: "map", path: "/"),
  details(name: "details", path: "/details");

  final String name;
  final String path;

  const Routes({required this.name, required this.path});
}
