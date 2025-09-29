import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>((event, emit) {
      final updatedTasks = List<String>.from(state.tasks)..add(event.task);
      emit(TaskState(tasks: updatedTasks));
    });

    on<DeleteTaskEvent>((event, emit) {
      final updatedTasks = List<String>.from(state.tasks)..remove(event.task);
      emit(TaskState(tasks: updatedTasks));
    });
  }
}