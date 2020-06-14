import 'package:equatable/equatable.dart';


class Picture extends Equatable{
  final author;
  final id;
  final imageLink;

  const Picture ({this.author, this.id, this.imageLink });


  @override
  List<Object> get props => [id, author, imageLink];
}