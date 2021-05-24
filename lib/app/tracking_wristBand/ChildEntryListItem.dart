import 'package:flutter/material.dart';

class ChildEntryListItem extends StatelessWidget {
  const ChildEntryListItem({@required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: _buildContents(context),
            ),
            Icon(Icons.chevron_right, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  _buildContents(BuildContext context) {}
}
