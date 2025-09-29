import 'package:equatable/equatable.dart';

class TaskState extends Equatable {
  final List<String> tasks;

  const TaskState({this.tasks = const []});

  @override
  List<Object> get props => [tasks];
}