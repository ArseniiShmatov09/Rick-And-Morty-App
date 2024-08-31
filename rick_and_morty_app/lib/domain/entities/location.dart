class Location{
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;

  Location({
    required this.id, 
    required this.name, 
    required this.type, 
    required this.dimension, 
    required this.residents, 
    required this.url, 
    required this.created
  });

}