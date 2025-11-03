import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart'; 
// NOTE: Replace this line with the actual package you choose (e.g., 'package:app_usage/app_usage.dart' or 'package:usage_stats/usage_stats.dart')
// For this example, we will use a mock data structure since the actual package isn't runnable here.

// --- CONFIGURATION ---
const int maxScreenTimeMs = 3 * 60 * 60 * 1000; // 3 hours limit

// Mock App Usage Data Structure (Replace with your package's actual data model)
class AppUsageInfo {
  final String appName;
  final int usageTimeMs; // Time in milliseconds

  AppUsageInfo({required this.appName, required this.usageTimeMs});
}

// --- HELPER FUNCTIONS ---

// Converts milliseconds to a human-readable format (Hh Mmin)
String formatMsToHumanTime(int ms) {
  final totalSeconds = (ms / 1000).floor();
  final hours = (totalSeconds / 3600).floor();
  final minutes = ((totalSeconds % 3600) / 60).floor();

  if (hours > 0) {
    return '${hours}h ${minutes}min';
  } else if (minutes > 0) {
    return '${minutes}min';
  }
  return 'Less than 1 min';
}

// --- WIDGET ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  int _totalScreenTimeMs = 0;
  List<AppUsageInfo> _topApps = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadScreenTimeData();
  }

  // NOTE: This function needs to implement the actual package logic and permission checks.
  Future<void> _loadScreenTimeData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Check for/Request Permissions (Crucial step not fully implemented here)
      // Example: if (!await UsageStats.checkPermission()) { await UsageStats.grantUsagePermission(); }
      
      // 2. Query Data for Today (Start of day to current time)
      final DateTime now = DateTime.now();
      final DateTime startOfDay = DateTime(now.year, now.month, now.day);
      
      // MOCK DATA - REPLACE WITH REAL PACKAGE CALLS
      // -------------------------------------------------------------------
      // In a real app, you would query the system for usage statistics here.
      
      // Mock Data Generation:
      await Future.delayed(const Duration(seconds: 1)); // Simulate network/system delay

      final List<AppUsageInfo> rawUsage = [
          AppUsageInfo(appName: "Social Media", usageTimeMs: 14000000), // ~3.9 hours
          AppUsageInfo(appName: "Video Streaming", usageTimeMs: 9800000), // ~2.7 hours
          AppUsageInfo(appName: "Work Email", usageTimeMs: 3600000), // 1 hour
          AppUsageInfo(appName: "Maps", usageTimeMs: 1200000), // 20 mins
      ];
      // -------------------------------------------------------------------

      // 3. Process and Aggregate Data
      final totalMs = rawUsage.fold<int>(0, (sum, app) => sum + app.usageTimeMs);
      
      rawUsage.sort((a, b) => b.usageTimeMs.compareTo(a.usageTimeMs));
      
      setState(() {
        _totalScreenTimeMs = totalMs;
        _topApps = rawUsage.take(3).toList();
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load screen time. Check permissions and package setup. Error: $e';
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'ERROR: $_errorMessage',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    // Progress Bar Logic
    final totalTime = _totalScreenTimeMs;
    final maxLimit = maxScreenTimeMs;
    final progressRatio = totalTime / maxLimit;
    final isOverLimit = totalTime > maxLimit;
    final progressValue = progressRatio.clamp(0.0, 1.0); // Clamp to max 1.0

    Color barColor;
    if (isOverLimit) {
      barColor = Colors.red.shade700;
    } else if (progressRatio > 0.8) {
      barColor = Colors.orange.shade600;
    } else {
      barColor = Colors.indigo.shade600;
    }

    String progressText = formatMsToHumanTime(totalTime);
    if (isOverLimit) {
      progressText = '$progressText (Limit Over)';
    }

    return RefreshIndicator(
      onRefresh: _loadScreenTimeData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Header (Current Date)
                Text(
                  'Today, ${DateFormat('EEEE, MMM d').format(DateTime.now())}',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),

                // Screen Time Card with Progress Bar
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Total Screen Time',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Time and Limit Display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              progressText,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: isOverLimit ? Colors.red.shade700 : Colors.indigo.shade700,
                              ),
                            ),
                            Text(
                              'Limit: ${formatMsToHumanTime(maxLimit)}',
                              style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Progress Bar
                        LinearProgressIndicator(
                          value: progressValue.toDouble(),
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(barColor),
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        const SizedBox(height: 12),

                        // Over Limit Warning
                        if (isOverLimit)
                          const Text(
                            '⚠️ Limit exceeded! Scroll down to see your top apps.',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Top Used Apps Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Top 3 Most Used Apps',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const Divider(height: 25, thickness: 1.5),
                        ..._topApps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final app = entry.value;
                          
                          // Calculate app percentage of total screen time
                          final double appRatio = totalTime > 0 ? app.usageTimeMs / totalTime : 0.0;
                          final String percentage = (appRatio * 100).toStringAsFixed(1);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                // Rank Circle
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.indigo.shade50,
                                  child: Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.indigo.shade700)),
                                ),
                                const SizedBox(width: 12),
                                // App Name
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        app.appName,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '$percentage% of total time',
                                        style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                ),
                                // Usage Time
                                Text(
                                  formatMsToHumanTime(app.usageTimeMs),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
