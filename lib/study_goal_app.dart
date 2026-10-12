import 'package:flutter/material.dart';

void main() {
  runApp(const StudyGoalApp());
}

class StudyGoal {
  StudyGoal(this.title, {this.isCompleted = false}) {
    this.title = title.trim();
  }

  String title;
  bool isCompleted;

  void toggle() {
    isCompleted = !isCompleted;
  }
}

class StudyGoalApp extends StatelessWidget {
  const StudyGoalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 03 · Study Goal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StudyGoalScreen(),
    );
  }
}

class StudyGoalScreen extends StatefulWidget {
  const StudyGoalScreen({super.key});

  @override
  State<StudyGoalScreen> createState() => _StudyGoalScreenState();
}

class _StudyGoalScreenState extends State<StudyGoalScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<StudyGoal> _goals = <StudyGoal>[];
  String? _errorText;

  void _addGoal() {
    final value = _controller.text.trim();

    if (value.isEmpty) {
      setState(() {
        _errorText = '목표를 입력하세요';
      });
      return;
    }

    if (value.length > 20) {
      setState(() {
        _errorText = '목표는 1~20자여야 합니다';
      });
      return;
    }

    setState(() {
      _goals.add(StudyGoal(value));
      _controller.clear();
      _errorText = null;
    });
  }

  void _toggleGoal(StudyGoal goal) {
    setState(() {
      goal.toggle();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 03 · Study Goal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '학습 목표를 입력하세요',
                border: const OutlineInputBorder(),
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addGoal,
              child: const Text('추가'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _goals.isEmpty
                  ? const Center(child: Text('목표를 추가해 보세요'))
                  : ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final goal = _goals[index];
                        return Card(
                          child: CheckboxListTile(
                            value: goal.isCompleted,
                            title: Text(
                              goal.title,
                              style: TextStyle(
                                decoration: goal.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(goal.isCompleted ? '완료' : '미완료'),
                            onChanged: (_) => _toggleGoal(goal),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
