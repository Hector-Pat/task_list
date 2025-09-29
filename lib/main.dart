import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      debugShowCheckedModeBanner: false, // Elimina el banner de debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => TaskBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final titlePosition = screenHeight * 0.33; // Aproximadamente a 2/3 de abajo hacia arriba

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: titlePosition,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const Text(
                    'Task List',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              labelText: 'Nueva tarea',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final text = _controller.text.trim();
                            if (text.isNotEmpty) {
                              context.read<TaskBloc>().add(AddTaskEvent(text));
                              _controller.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: screenHeight * 0.4, // Espacio para la lista
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, state) {
                          if (state.tasks.isEmpty) {
                            return const Center(child: Text('No hay tareas'));
                          }
                          return ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              final task = state.tasks[index];
                              return ListTile(
                                title: Text(task),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context.read<TaskBloc>().add(DeleteTaskEvent(task));
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}