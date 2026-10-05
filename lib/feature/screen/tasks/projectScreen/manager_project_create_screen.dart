import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class ManagerProjectCreateScreen extends StatefulWidget {
  const ManagerProjectCreateScreen({super.key});

  @override
  State<ManagerProjectCreateScreen> createState() => _ManagerProjectCreateScreenState();
}

class _ManagerProjectCreateScreenState extends State<ManagerProjectCreateScreen> {
  final TextEditingController _projectNameController = TextEditingController(text: 'HRMS software CRM');
  final TextEditingController _projectCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController(text: '150');

  String _selectedTaskCategory = 'Low';
  String _selectedVisibility = 'Public';
  String _selectedCategory = 'Website';

  bool _enableSubtasks = true;
  bool _enableMilestones = true;
  bool _enableTimetracking = false;
  bool _enableFileSharing = true;
  bool _enableNotification = true;

  final List<Map<String, String>> _selectedMembers = [
    {'name': 'Biswajit', 'image': AppImagesPng.six},
    {'name': 'Bikash', 'image': AppImagesPng.four},
    {'name': 'Manoj', 'image': AppImagesPng.five},
    {'name': 'Moulina', 'image': AppImagesPng.three},
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
          'Create Project',
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
                  _buildLabel('Project Name', isRequired: true),
                  _buildTextField(
                    controller: _projectNameController,
                    hintText: 'Enter Project Name',
                    prefixIcon: Icons.language,
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Project Code'),
                  _buildTextField(
                    controller: _projectCodeController,
                    hintText: 'Enter Project Code',
                    prefixIcon: Icons.edit_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildLabel('Description'),
                  _buildDescriptionField(),
                  const SizedBox(height: 16),
                  _buildLabel('Team Members'),
                  _buildTeamMembersSection(),
                  const SizedBox(height: 16),
                  _buildLabel('Project Category', isRequired: true),
                  _buildProjectCategoryGrid(),
                  const SizedBox(height: 16),
                  _buildLabel('Task Category', isRequired: true),
                  _buildTaskCategorySelector(),
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
                  const SizedBox(height: 16),
                  _buildLabel('Project Visibility'),
                  _buildVisibilitySelector(),
                  const SizedBox(height: 16),
                  _buildLabel('Default Task Status'),
                  _buildDropdown('To Do', Icons.public),
                  const SizedBox(height: 16),
                  _buildSwitchRow('Enable Subtasks', _enableSubtasks, (v) => setState(() => _enableSubtasks = v)),
                  _buildSwitchRow('Enable Milestones', _enableMilestones, (v) => setState(() => _enableMilestones = v)),
                  _buildSwitchRow('Enable Timetracking', _enableTimetracking, (v) => setState(() => _enableTimetracking = v)),
                  _buildSwitchRow('Enable File Sharing', _enableFileSharing, (v) => setState(() => _enableFileSharing = v)),
                  _buildSwitchRow('Enable Notification to Team', _enableNotification, (v) => setState(() => _enableNotification = v)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF901AEA),
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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 12,
            fontWeight: FontWeight.w600,
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
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 0.0),
                  child: Icon(prefixIcon, size: 18, color: const Color(0xFF9CA3AF)),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffixText != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(suffixText, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            left: prefixIcon != null ? 0 : 12,
            right: 12,
            top: 0,
            bottom: 10,
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
              hintText: 'Enter project details, objective, expected etc..',
              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedMembers.map((member) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundImage: AssetImage(member['image']!),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      member['name']!,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.close, size: 12, color: Colors.grey),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        _buildDropdown('Select Employee', Icons.group_outlined),
      ],
    );
  }

  Widget _buildDropdown(String text, IconData icon) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF9CA3AF)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildProjectCategoryGrid() {
    final categories = [
      {'name': 'Website', 'icon': Icons.computer},
      {'name': 'CRM', 'icon': Icons.track_changes},
      {'name': 'ERP', 'icon': Icons.settings_input_component},
      {'name': 'Finance', 'icon': Icons.account_balance_wallet_outlined},
      {'name': 'MLM', 'icon': Icons.search},
      {'name': 'Automation', 'icon': Icons.people_outline},
      {'name': 'Cpaas', 'icon': Icons.home_work_outlined},
      {'name': 'SaaS', 'icon': Icons.dashboard_customize_outlined},
      {'name': 'Others', 'icon': Icons.grid_view},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.9,
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
              color: isSelected ? const Color(0xFFF5E6FF) : Colors.white,
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
                  size: 15,
                  color: isSelected ? const Color(0xFF901AEA) : const Color(0xFF6B7280),
                ),
                const SizedBox(height: 4),
                Text(
                  category['name'] as String,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildTaskCategorySelector() {
    final types = [
      {'label': 'Low', 'color': const Color(0xFF1BA6F1)},
      {'label': 'Normal', 'color': const Color(0xFFDFC900)},
      {'label': 'High', 'color': const Color(0xFFDF8D00)},
      {'label': 'Urgent', 'color': const Color(0xFFFF0000)},
    ];

    return Row(
      children: types.map((type) {
        final bool isSelected = _selectedTaskCategory == type['label'];
        final color = type['color'] as Color;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTaskCategory = type['label'] as String),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: isSelected ? color : const Color(0xFFE5E7EB)),
              ),
              alignment: Alignment.center,
              child: Text(
                type['label'] as String,
                style: TextStyle(
                  color: isSelected ? color : const Color(0xFF9CA3AF),
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
        border: Border.all(color: const Color(0xFF4B5563)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF4B5563)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF4B5563),
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
          height: 40,
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
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xFF111827)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilitySelector() {
    return Row(
      children: [
        _buildVisibilityOption('Public', Icons.group_outlined),
        const SizedBox(width: 12),
        _buildVisibilityOption('Private', Icons.lock_outline),
      ],
    );
  }

  Widget _buildVisibilityOption(String label, IconData icon) {
    final bool isSelected = _selectedVisibility == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedVisibility = label),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEBF5FF) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF4361EE) : const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? const Color(0xFF4361EE) : const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF4361EE) : const Color(0xFF9CA3AF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
          SizedBox(
            height: 30,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF4361EE),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
