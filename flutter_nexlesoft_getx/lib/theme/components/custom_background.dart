import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child, required this.path});

  final Widget child;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Image.asset(path),
            OverflowBox(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.topCenter,
                      colors: [Color(0xFF000000), Color(0x001d2238)]),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
