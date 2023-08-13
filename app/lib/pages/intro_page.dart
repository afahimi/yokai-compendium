import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 197, 253),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the world of...',
              style: GoogleFonts.pacifico(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/yokai_watch.png',
              width: 200, // You can adjust the size as needed
            ),
            const SizedBox(height: 20),
            Center(
                child: ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                "assets/yokai_watch_icon.png",
                width: 30,
                height: 30,
              ),
              label: Text(
                'Get Started',
                style: GoogleFonts.pacifico(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 112, 93, 218),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 5,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
