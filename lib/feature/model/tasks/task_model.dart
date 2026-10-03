class TaskModel {
  final String id;
  final String clientProject;
  final String title;
  final String assignBy;
  final String assignInitials;
  final String dueDate;
  final String status;
  final String priority;
  final String subTasksCount;
  final double progress;
  final int commentsCount;
  final int attachmentsCount;
  final String assignedOn;
  final String estimatedTime;
  final String durationCover;
  final String description;
  final String? userImageUrl;
  final String? timeAgo;

  TaskModel({
    required this.id,
    required this.clientProject,
    required this.title,
    required this.assignBy,
    required this.assignInitials,
    required this.dueDate,
    required this.status,
    required this.priority,
    required this.subTasksCount,
    required this.progress,
    required this.commentsCount,
    required this.attachmentsCount,
    required this.assignedOn,
    required this.estimatedTime,
    required this.durationCover,
    required this.description,
    this.userImageUrl,
    this.timeAgo,
  });
}

class TaskDashboardStats {
  final int totalProjects;
  final int teamMembers;
  final int totalAssignedTasks;
  final int inProgressTasks;
  final int completedTasks;
  final int overdueTasks;
  final int todoTasks;
  final double taskCompletionPercentage;

  TaskDashboardStats({
    required this.totalProjects,
    required this.teamMembers,
    required this.totalAssignedTasks,
    required this.inProgressTasks,
    required this.completedTasks,
    required this.overdueTasks,
    required this.todoTasks,
    required this.taskCompletionPercentage,
  });
}
