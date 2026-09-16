class InstructionItem {
  final String title;
  final String description;

  const InstructionItem({
    required this.title,
    required this.description,
  });
}

class Activity {
  final String id;
  final String label; // e.g. "Activity 1"
  final String title;
  final String dateDisplay; // shown on the dashboard card
  final String deadline;
  final String time;
  final String objective;
  final List<InstructionItem> instructions;

  const Activity({
    required this.id,
    required this.label,
    required this.title,
    required this.dateDisplay,
    required this.deadline,
    required this.time,
    required this.objective,
    required this.instructions,
  });
}
