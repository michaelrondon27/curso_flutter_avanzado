class Band {

  String id;
  String name;
  int votes;

  Band({
    required this.id,
    required this.name,
    required this.votes
  });

  factory Band.fromMao(Map<String, dynamic> obj) => Band(
    id   : obj['id'],
    name : obj['name'],
    votes: obj['votes']
  );

}
