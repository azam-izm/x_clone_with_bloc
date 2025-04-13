// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:x_clone_with_bloc/models/mock_data.dart';
import 'package:x_clone_with_bloc/models/user.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Mentions'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllNotifications(),
            _buildMentionsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllNotifications() {
    return ListView(
      children: [
        _buildNotificationItem(
          user: null,
          icon: Icons.favorite,
          iconColor: Colors.red,
          title: '${mockUsers[0].name} liked your post',
          subtitle: '@${mockUsers[0].handle}',
          time: '2 min ago',
        ),
        _buildNotificationItem(
          user: null,
          icon: Icons.repeat,
          iconColor: Colors.green,
          title: '${mockUsers[2].name} retweeted your post',
          subtitle: '@${mockUsers[2].handle}',
          time: '1 hour ago',
        ),
        _buildNotificationItem(
          user: null,
          icon: Icons.person_add,
          iconColor: Colors.blue,
          title: '${mockUsers[3].name} followed you',
          subtitle: '@${mockUsers[3].handle}',
          time: '3 hours ago',
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required User? user,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return ListTile(
      leading: user != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.profileImage),
            )
          : Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor),
            ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(time, style: TextStyle(color: Colors.grey.shade600)),
    );
  }

  Widget _buildMentionsTab() {
    return Column(
      children: [
        _buildMentionsSection(title: 'Recent Mentions', count: 3),
        const Divider(height: 1),
        _buildMentionsSection(title: 'Earlier Mentions', count: 2),
      ],
    );
  }

  Widget _buildMentionsSection({required String title, required int count}) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      initiallyExpanded: true,
      children: [
        for (int i = 0; i < count; i++)
          _buildNotificationItem(
            user: mockUsers[i],
            icon: Icons.alternate_email,
            iconColor: Colors.blue,
            title: '${mockUsers[i].name} mentioned you',
            subtitle: '@${mockUsers[i].handle}',
            time: '${i + 1} day${i == 0 ? '' : 's'} ago',
          ),
      ],
    );
  }
}
