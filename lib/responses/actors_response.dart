import 'package:movies/models/actor.dart';

class ActorResponse {
  List<Actor> actors = [];

  
  ActorResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((actor) {
      actors.add(Actor.fromJson(actor));
    });
  }
}
