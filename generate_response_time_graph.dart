import 'dart:io';
import 'dart:math';

// Mock response time data for demonstration
class ResponseTimeData {
  final String operation;
  final int responseTime;
  final DateTime timestamp;

  ResponseTimeData(this.operation, this.responseTime, this.timestamp);
}

void main() {
  // Generate mock response time data
  final responseTimeData = [
    ResponseTimeData('App Launch', 2100, DateTime.now().subtract(Duration(days: 6))),
    ResponseTimeData('Login', 180, DateTime.now().subtract(Duration(days: 5))),
    ResponseTimeData('Dashboard Load', 150, DateTime.now().subtract(Duration(days: 4))),
    ResponseTimeData('Emotion Record', 120, DateTime.now().subtract(Duration(days: 3))),
    ResponseTimeData('Message Send', 200, DateTime.now().subtract(Duration(days: 2))),
    ResponseTimeData('Data Sync', 300, DateTime.now().subtract(Duration(days: 1))),
    ResponseTimeData('Analytics Load', 250, DateTime.now()),
  ];

  // Create a simple text-based chart
  print('Response Time Metrics Chart');
  print('==========================');
  print('');
  
  final maxTime = responseTimeData.map((d) => d.responseTime).reduce(max);
  final chartWidth = 50;
  
  for (final data in responseTimeData) {
    final barLength = ((data.responseTime / maxTime) * chartWidth).round();
    final bar = '█' * barLength;
    final padding = ' ' * (chartWidth - barLength);
    
    print('${data.operation.padRight(15)} | $bar$padding | ${data.responseTime}ms');
  }
  
  print('');
  print('Chart generated successfully!');
  print('This represents typical response times for different app operations.');
  print('');
  print('To get real performance data, you can:');
  print('1. Run: flutter run --profile');
  print('2. Use Flutter DevTools for performance profiling');
  print('3. Check Firebase Performance Monitoring if configured');
  print('4. Add custom performance logging to your app');
} 