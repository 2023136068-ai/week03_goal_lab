import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: StudyGoalScreen());
  }
}

class GoalItem {
  String id;
  String title;
  bool isCompleted;

  GoalItem({required this.id, required this.title, this.isCompleted = false});
}

class StudyGoalScreen extends StatefulWidget {
  const StudyGoalScreen({super.key});

  @override
  State<StudyGoalScreen> createState() => _StudyGoalScreenState();
}

class _StudyGoalScreenState extends State<StudyGoalScreen> {
  final List<GoalItem> _goals = [];
  final TextEditingController _textController = TextEditingController();

  // AC1, AC2: 목표 추가 메서드
  void _addGoal() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      // AC2: 빈 값 입력 시 추가하지 않고 스낵바 출력
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('목표 내용을 입력해주세요.')));
      return;
    }

    setState(() {
      _goals.add(GoalItem(id: DateTime.now().toString(), title: text));
      _textController.clear();
    });
  }

  // AC3: 완료 상태 토글 메서드
  void _toggleGoal(int index) {
    setState(() {
      _goals[index].isCompleted = !_goals[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Goal Lab'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: '새 학습 목표 입력',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addGoal, child: const Text('추가')),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _goals.isEmpty
                  ? const Center(child: Text('등록된 목표가 없습니다.'))
                  : ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final goal = _goals[index];
                        return ListTile(
                          leading: Checkbox(
                            value: goal.isCompleted,
                            onChanged: (_) => _toggleGoal(index),
                          ),
                          title: Text(
                            goal.title,
                            style: TextStyle(
                              decoration: goal.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: goal.isCompleted
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          onTap: () => _toggleGoal(index),
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
