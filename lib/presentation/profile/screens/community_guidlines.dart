import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommunityGuidelines extends StatefulWidget {
  const CommunityGuidelines({Key? key}) : super(key: key);

  @override
  _CommunityGuidelinesState createState() => _CommunityGuidelinesState();
}

class _CommunityGuidelinesState extends State<CommunityGuidelines> {
  String text = '';
  String lastUpdated = 'Not Available';

  @override
  void initState() {
    super.initState();
    _fetchCommunityGuidelines();
  }

  Future<void> _fetchCommunityGuidelines() async {
    var doc = await FirebaseFirestore.instance
        .collection("settings")
        .doc("community_guidelines")
        .get();
    if (doc.exists) {
      setState(() {
        text = doc.data()?['text'] ?? '';
        lastUpdated = doc.data()?['last_updated'] != null
            ? DateFormat('yyyy-MM-dd – kk:mm').format(
            doc.data()?['last_updated'].toDate())
            : "Not Available";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Community Guidelines",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize:16.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRichText(text),
            SizedBox(height: 20),
            Text(
              'Last Updated: $lastUpdated',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String text) {
    // Call the parse function and pass the text to it
    List<TextSpan> spans = _parseMarkdown(text);
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: spans,
      ),
    );
  }

  List<TextSpan> _parseMarkdown(String text) {
    List<TextSpan> spans = [];
    List<String> lines = text.split('\n');
    for (String line in lines) {
      // Remove markdown symbols and apply styles
      line = line.replaceAll('**', '');
      line = line.replaceAll('*', '');
      line = line.replaceAll('~', '');

      // Add new line character for proper line spacing
      line += '\n';

      if (line.startsWith('# ')) {
        spans.add(TextSpan(text: line.substring(2), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
      } else if (line.startsWith('## ')) {
        spans.add(TextSpan(text: line.substring(3), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
      } else if (line.startsWith('### ')) {
        spans.add(TextSpan(text: line.substring(4), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      } else {
        // Apply inline styles if present
        spans.addAll(_parseInlineMarkdown(line));
      }
    }
    return spans;
  }

  List<TextSpan> _parseInlineMarkdown(String line) {
    // This function should parse inline markdown (bold, italic, underline)
    // For simplicity, this function currently just returns a plain text span.
    // You'll need to implement the actual parsing logic here.
    return [TextSpan(text: line)];
  }
}