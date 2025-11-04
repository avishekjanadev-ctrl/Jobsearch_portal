import 'package:flutter/material.dart';
import '../screens/AddNewJobScreen.dart';

// ===========================================
// 1. DATA MODEL
// ===========================================
class JobPosting {
  final String title;
  final String company;
  final String location;
  final double salary;
  final bool isActive;

  const JobPosting({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    this.isActive = true,
  });
}

// ===========================================
// 2. JOB CARD WIDGET
// ===========================================
class JobPostingCard extends StatelessWidget {
  final JobPosting job;

  const JobPostingCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    // Determine status color/icon
    final Color statusColor = job.isActive ? Colors.green.shade600 : Colors.red.shade600;
    final String statusText = job.isActive ? 'Active' : 'Draft';
    
    return Card(
      color: Color(0xFFF6F7FB),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: job.isActive ? const Color.fromARGB(255, 246, 243, 243) : Colors.amber.shade200,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        onTap: () {
          // Action when a specific job is tapped (e.g., go to edit page)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing/Editing: ${job.title}')),
          );
        },
        leading: Icon(
          Icons.work_outline, 
          color: const Color(0xFF1E3A5F), // Your primary dark color
          size: 30,
        ),
        title: Text(
          job.title, 
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${job.company} - ${job.location}', style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 2),
            Text(
              'Salary: \$${job.salary.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 13, color: Colors.blueGrey.shade600),
            ),
            const SizedBox(height: 4),
            // Status Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                statusText,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.edit, size: 20.0, color: Color(0xFF1E3A5F)),
      ),
    );
  }
}

// ===========================================
// 3. JOB POSTINGS SCREEN (Main View)
// ===========================================
class JobPostingsScreen extends StatelessWidget {
  const JobPostingsScreen({super.key});

  final List<JobPosting> jobListings = const [
    JobPosting(title: 'Flutter Developer (Active)', company: 'Tech Solutions Inc.', location: 'Remote', salary: 95000, isActive: true),
    JobPosting(title: 'Senior UX Designer (Draft)', company: 'Creative Agency', location: 'New York, NY', salary: 110000, isActive: false),
    JobPosting(title: 'Data Scientist (Active)', company: 'DataCorp', location: 'San Francisco, CA', salary: 130000, isActive: true),
    JobPosting(title: 'Technical Writer (Active)', company: 'Documentation Co.', location: 'Remote', salary: 75000, isActive: true),
    JobPosting(title: 'Project Manager (Draft)', company: 'BuildFast', location: 'Dallas, TX', salary: 120000, isActive: false),
    JobPosting(title: 'QA Engineer (Active)', company: 'TestIt All', location: 'Austin, TX', salary: 85000, isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      body: SafeArea(
        child: Column(
          children: [
            // Header Area (Custom AppBar look)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),

                  // Title
                  const Expanded(
                    child: Text(
                      "Manage Job Postings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Add Job Button
                 IconButton(
                    icon: const Icon(Icons.add_box_outlined, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddNewJobPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Body Area (Rounded light container with job list)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color:  Color(0xFFF6F7FB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    itemCount: jobListings.length,
                    itemBuilder: (context, index) {
                      final job = jobListings[index];
                      return JobPostingCard(job: job);
                    },
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
