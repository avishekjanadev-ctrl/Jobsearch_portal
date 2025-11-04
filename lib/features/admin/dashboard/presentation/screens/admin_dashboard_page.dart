import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';
import '../screens/JobPostingsScreen.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A5F),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Body
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      DashboardCard(
                        icon: Icons.work_outline,
                        title: 'Manage Job Postings',
                        onTap: () {
                        //   print('Manage Job Postings card was tapped!');
                        Navigator.push(
                                context,
                          MaterialPageRoute(builder: (context) => JobPostingsScreen()),
                          );

                        },
                      ),
                      DashboardCard(
                        icon: Icons.people_alt_outlined,
                        title: 'Manage Users',
                        subtitle: 'Job Seekers / Employers',
                        onTap: () {},
                      ),
                      DashboardCard(
                        icon: Icons.bar_chart_outlined,
                        title: 'Reports & Analytics',
                        onTap: () {},
                      ),
                      DashboardCard(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        onTap: () {},
                      ),
                      const SizedBox(height: 30),
                    ],
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
