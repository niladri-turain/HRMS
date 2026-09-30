import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'widgets/task_text_field.dart';
import 'widgets/category_item.dart';
import 'widgets/priority_item.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String? _selectedProject;
  String? _selectedModule;
  String? _selectedStatus = 'To Do';
  String _selectedCategory = 'Development';
  String _selectedPriority = 'Urgent';
  bool _startWorkingNow = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController(text: '0 hours');
  final TextEditingController _minutesController = TextEditingController(text: '30 minutes');
  final TextEditingController _dueDateController = TextEditingController(text: '14 Aug 2026');

  final List<Map<String, String>> _categories = [
    {'label': 'Development', 'icon': AppImagesPng.development},
    {'label': 'Design', 'icon': AppImagesPng.design},
    {'label': 'Testing', 'icon': AppImagesPng.research}, // Using research as placeholder for bug icon if not exact
    {'label': 'Documentation', 'icon': AppImagesPng.documentation},
    {'label': 'Research', 'icon': AppImagesPng.research},
    {'label': 'Meeting', 'icon': AppImagesPng.meeting},
    {'label': 'Client Visit', 'icon': AppImagesPng.clientCity},
    {'label': 'Presentation', 'icon': AppImagesPng.presentation},
    {'label': 'Others', 'icon': AppImagesPng.others},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF311040),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create My Task',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Selection

              const SizedBox(height: 16),
              _buildDropdownLabel('Project', isRequired: true),
              const SizedBox(height: 8),
              _buildDropdownField(
                hint: 'Select Project',
                value: _selectedProject,
                prefixIcon: AppImagesPng.module,
                onChanged: (val) => setState(() => _selectedProject = val),
                items: ['Bill Track', 'HRMS', 'STTN'],
              ),

              const SizedBox(height: 16),

              // Project Module
              _buildDropdownLabel('Project Module (Optional)'),
              const SizedBox(height: 8),
              _buildDropdownField(
                hint: 'Select Project Module',
                value: _selectedModule,
                prefixIcon: AppImagesPng.module,
                onChanged: (val) => setState(() => _selectedModule = val),
                items: ['Auth Module', 'Dashboard', 'Settings'],
              ),

              const SizedBox(height: 16),

              // Task Title
              TaskTextField(
                label: 'Task Title',
                hintText: 'Select Project Module', // Matching the screenshot's weird hint
                isRequired: true,
                prefixIcon: AppImagesPng.editss,
                controller: _titleController,
              ),

              const SizedBox(height: 16),

              // Task Description
              TaskTextField(
                label: 'Task Description',
                hintText: 'Enter task details, objective, expected etc..',
                maxLines: 4,
                maxLength: 300,
                controller: _descriptionController,
              ),



              // Default Task Status
              _buildDropdownLabel('Default Task Status'),
              const SizedBox(height: 16),
              _buildDropdownField(
                hint: 'To Do',
                value: _selectedStatus,
                prefixIcon: AppImagesPng.todo,
                onChanged: (val) => setState(() => _selectedStatus = val),
                items: ['To Do', 'In Progress', 'In Review', 'Completed'],
              ),

              const SizedBox(height: 16),

              // Task Category Grid
              _buildDropdownLabel('Task Category', isRequired: true),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return CategoryItem(
                    label: cat['label']!,
                    iconPath: cat['icon']!,
                    isSelected: _selectedCategory == cat['label'],
                    onTap: () => setState(() => _selectedCategory = cat['label']!),
                  );
                },
              ),



              // Priority (labeled "Task Category" in screenshot)
              _buildDropdownLabel('Task Category', isRequired: true),
              const SizedBox(height: 8),
              Row(
                children: [
                  PriorityItem(
                    label: 'Low',
                    color: const Color(0xFF3B82F6),
                    isSelected: _selectedPriority == 'Low',
                    onTap: () => setState(() => _selectedPriority = 'Low'),
                  ),
                  const SizedBox(width: 8),
                  PriorityItem(
                    label: 'Normal',
                    color: const Color(0xFFDFAF00),
                    isSelected: _selectedPriority == 'Normal',
                    onTap: () => setState(() => _selectedPriority = 'Normal'),
                  ),
                  const SizedBox(width: 8),
                  PriorityItem(
                    label: 'High',
                    color: const Color(0xFFF97316),
                    isSelected: _selectedPriority == 'High',
                    onTap: () => setState(() => _selectedPriority = 'High'),
                  ),
                  const SizedBox(width: 8),
                  PriorityItem(
                    label: 'Urgent',
                    color: const Color(0xFFEF4444),
                    isSelected: _selectedPriority == 'Urgent',
                    onTap: () => setState(() => _selectedPriority = 'Urgent'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Estimated Duration
              _buildDropdownLabel('Estimated Duration'),

              Row(
                children: [
                  Expanded(
                    child: TaskTextField(
                      label: '',
                      hintText: '0 hours',
                      controller: _hoursController,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TaskTextField(
                      label: '',
                      hintText: '30 minutes',
                      controller: _minutesController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Switch and Due Date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: _startWorkingNow,
                            onChanged: (val) => setState(() => _startWorkingNow = val),
                            activeColor: AppColors.primary200,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Start Working Now?',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF6B7280)),
                              ),
                              Text(
                                'Yes, start this task immediately.\nThe task will be available in your\nactive tasks.',
                                style: TextStyle(fontSize: 9, color: Color(0xFF6B7280)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TaskTextField(
                      label: 'Due Date',
                      hintText: '14 Aug 2026',
                      prefixIcon: AppImagesPng.scheduleDate,
                      isReadOnly: true,
                      onTap: () {},
                      controller: _dueDateController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Add Comments & Upload Documents
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(AppImagesPng.commants, width: 16, height: 16, color: const Color(0xFF6B7280)),
                      label: const Text('Add Comments', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12,fontWeight: FontWeight.w500)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF6B7280), width: .75),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(AppImagesPng.attachedd, width: 16, height: 16, color: const Color(0xFF6B7280)),
                      label: const Text('Upload Documents', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12,fontWeight: FontWeight.w500)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF6B7280), width: .75),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF901AEA),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownLabel(String label, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
        ),
        children: [
          if (isRequired)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required String prefixIcon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Row(
            children: [
              Image.asset(prefixIcon, width: 16, height: 16, color: const Color(0xFF9CA3AF)),
              const SizedBox(width: 12),
              Text(hint, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF)),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
