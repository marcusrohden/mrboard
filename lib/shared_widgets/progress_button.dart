import 'dart:developer';

import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Future<void> Function() onPressed;

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : executeCall,

      child: Row(
        children: [
          Text(widget.label, style: TextStyle(fontSize: 16)),
          if (_isLoading)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.deepPurple,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> executeCall() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } catch (e) {
      log('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
