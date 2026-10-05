import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class ManagerProjectTaskCreateScreen extends StatefulWidget {
  final String projectName;
  const ManagerProjectTaskCreateScreen({super.key, required this.projectName});

  @override
  State<ManagerProjectTaskCreateScreen> createState() => _ManagerProjectTaskCreateScreenState();
}

class _ManagerProjectTaskCreateScreenState extends State<ManagerProjectTaskCreateScreen> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  String _selectedPriority = 'Low';
  String _selectedCategory = 'Development';

  final List<Map<String, String>> _selectedMembers = [
    {'name': 'Biswajit', 'image': AppImagesPng.six},
    {'name': 'Bikash', 'image': AppImagesPng.four},
    {'name': 'Manoj', 'image': AppImagesPng.five},
    {'name': 'Moulina', 'image': AppImagesPng.one},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -10,
        title: const Text(
          'Create Project Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF311040), Color(0xFFFFFFFF)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Task Title', isRequired: true),
                  _buildTextField(
                    controller: _taskTitleController,
                    hintText: 'Select Project Module', // Matching image hint exactly
                    prefixIcon: Icons.edit_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Task Description'),
                  _buildDescriptionField(),
                  const SizedBox(height: 16),
                  _buildLabel('Team Members'),
                  _buildTeamMembersSection(),
                  const SizedBox(height: 12),
                  _buildDropdown('Select Employee', Icons.groups_outlined, showBorder: false),
                  const SizedBox(height: 16),
                  _buildLabel('Default Task Status'),
                  _buildDropdown('To Do', Icons.language),
                  const SizedBox(height: 16),
                  _buildLabel('Task Category', isRequired: true),
                  _buildProjectCategoryGrid(),
                  const SizedBox(height: 16),
                  _buildLabel('Task Category', isRequired: true), // Image 9:41 had duplicate label for priorities
                  _buildTaskPrioritySelector(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(Icons.chat_bubble_outline, 'Add Comments'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(Icons.attach_file, 'Upload Documents'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildDatePicker('Start Date', '14 Aug 2026')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildDatePicker('Due Date', '14 Aug 2026')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Estimated Duration (Optional)'),
                  _buildTextField(
                    controller: _durationController,
                    hintText: '150',
                    suffixText: 'hours',
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF901AEA),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          children: isRequired
              ? [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  )
                ]
              : [],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? prefixIcon,
    String? suffixText,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(prefixIcon, size: 18, color: const Color(0xFF9CA3AF)),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixText != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: Text(suffixText, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            left: prefixIcon != null ? 0 : 12,
            right: 12,
            top: -5,
            bottom: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              hintText: 'Enter task details, objective, expected etc..',
              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0, bottom: 4.0),
            child: Text(
              '0 / 300',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_selectedMembers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.start,
                children: _selectedMembers.map((member) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 9,
                          backgroundImage: AssetImage(member['image']!),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          member['name']!,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.close, size: 14, color: Color(0xFF6B7280)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),


        ],
      ),
    );
  }

  Widget _buildDropdown(String text, IconData icon, {bool showBorder = true}) {
    final bool isHint = text.startsWith('Select');
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border:  Border.all(color: const Color(0xFFE5E7EB)) ,
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF9CA3AF)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isHint ? const Color(0xFF9CA3AF) : const Color(0xFF1F2937),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280), size: 20),
        ],
      ),
    );
  }

  Widget _buildProjectCategoryGrid() {
    final categories = [
      {'name': 'Development', 'icon': Icons.computer_outlined},
      {'name': 'Design', 'icon': Icons.colorize_outlined},
      {'name': 'Testing', 'icon': Icons.bug_report_outlined},
      {'name': 'Documentation', 'icon': Icons.assignment_outlined},
      {'name': 'Research', 'icon': Icons.search},
      {'name': 'Meeting', 'icon': Icons.groups_outlined},
      {'name': 'Client Visit', 'icon': Icons.business_outlined},
      {'name': 'Presentation', 'icon': Icons.co_present_outlined},
      {'name': 'Others', 'icon': Icons.grid_view_outlined},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final bool isSelected = _selectedCategory == category['name'];
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = category['name'] as String),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF901AEA).withValues(alpha: 0.05) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? const Color(0xFF901AEA) : const Color(0xFFE5E7EB),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  category['icon'] as IconData,
                  size: 18,
                  color: isSelected ? const Color(0xFF901AEA) : const Color(0xFF6B7280),
                ),
                const SizedBox(height: 4),
                Text(
                  category['name'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? const Color(0xFF901AEA) : const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaskPrioritySelector() {
    final priorities = [
      {'label': 'Low', 'color': const Color(0xFF3B82F6)},
      {'label': 'Normal', 'color': const Color(0xFFDFAF00)},
      {'label': 'High', 'color': const Color(0xFFF97316)},
      {'label': 'Urgent', 'color': const Color(0xFFEF4444)},
    ];

    return Row(
      children: priorities.map((p) {
        final bool isSelected = _selectedPriority == p['label'];
        final color = p['color'] as Color;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedPriority = p['label'] as String),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? color.withValues(alpha: 0.05) : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? color : const Color(0xFFE5E7EB)),
              ),
              alignment: Alignment.center,
              child: Text(
                p['label'] as String,
                style: TextStyle(
                  color: isSelected ? color : const Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF9CA3AF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF9CA3AF)),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
