// ===========================================
// 4. ADD NEW JOB PAGE (New Screen)
// ===========================================
import 'package:flutter/material.dart';
import 'package:job_portal/features/admin/dashboard/presentation/screens/JobPostingsScreen.dart';
class AddNewJobPage extends StatefulWidget {
  const AddNewJobPage({super.key});

  @override
  State<AddNewJobPage> createState() => _AddNewJobPageState();
}

class _AddNewJobPageState extends State<AddNewJobPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isActive = true;
 
  // Mock controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  void _saveJob() {
    if (_formKey.currentState!.validate()) {
      // In a real app, you would save this data to a database
      final newJob = JobPosting(
        title: _titleController.text,
        company: _companyController.text,
        location: _locationController.text,
        salary: double.tryParse(_salaryController.text) ?? 0,
        isActive: _isActive,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Job Saved: ${newJob.title} (${newJob.isActive ? "Active" : "Draft"})'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate back to the list screen
      Navigator.pop(context);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF1E3A5F)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F), // Dark header color
      body: SafeArea(
        child: Column(
          children: [
            // Header Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      "Add New Job",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Placeholder for alignment
                  const SizedBox(width: 48), 
                ],
              ),
            ),

            // Form Body Area (Rounded light container)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F7FB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _titleController,
                          label: 'Job Title',
                          icon: Icons.badge_outlined,
                        ),
                        _buildTextField(
                          controller: _companyController,
                          label: 'Company Name',
                          icon: Icons.business_outlined,
                        ),
                        _buildTextField(
                          controller: _locationController,
                          label: 'Location (e.g., Remote, City, State)',
                          icon: Icons.location_on_outlined,
                        ),
                        _buildTextField(
                          controller: _salaryController,
                          label: 'Annual Salary (\$)',
                          icon: Icons.attach_money,
                          keyboardType: TextInputType.number,
                        ),
                        
                        // Active/Draft Switch
                        SwitchListTile(
                          title: Text(
                            'Status: ${_isActive ? 'Active' : 'Draft'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          value: _isActive,
                          onChanged: (bool value) {
                            setState(() {
                              _isActive = value;
                            });
                          },
                          activeColor: Colors.green.shade600,
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        const SizedBox(height: 30),

                        // Save Button
                        ElevatedButton.icon(
                          onPressed: _saveJob,
                          icon: const Icon(Icons.save),
                          label: const Text('Save Job Posting'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A5F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
