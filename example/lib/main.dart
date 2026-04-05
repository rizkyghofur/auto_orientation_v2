import 'package:auto_orientation_v2/auto_orientation_v2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AutoOrientationDemo(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class AutoOrientationDemo extends StatefulWidget {
  const AutoOrientationDemo({super.key, this.title = 'Auto Orientation Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _AutoOrientationDemoState();
  }
}

class _AutoOrientationDemoState extends State<AutoOrientationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SectionHeader(title: "Recommended API (Enum Based)"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OrientationButton(
                  label: "Landscape Right",
                  onPressed: () => AutoOrientation.setOrientation(
                      AutoOrientationMode.landscapeRight),
                ),
                OrientationButton(
                  label: "Landscape Left",
                  onPressed: () => AutoOrientation.setOrientation(
                      AutoOrientationMode.landscapeLeft),
                ),
                OrientationButton(
                  label: "Portrait Up",
                  onPressed: () => AutoOrientation.setOrientation(
                      AutoOrientationMode.portraitUp),
                ),
                OrientationButton(
                  label: "Portrait Down",
                  onPressed: () => AutoOrientation.setOrientation(
                      AutoOrientationMode.portraitDown),
                ),
                OrientationButton(
                  label: "Full Auto",
                  onPressed: () => AutoOrientation.setOrientation(
                      AutoOrientationMode.fullAuto),
                ),
                OrientationButton(
                  label: "User Default",
                  color: Colors.orange,
                  onPressed: () =>
                      AutoOrientation.setOrientation(AutoOrientationMode.user),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: "Android Specific (Force Sensor)"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OrientationButton(
                  label: "Landscape Auto (Forced)",
                  color: Colors.green,
                  onPressed: () => AutoOrientation.setOrientation(
                    AutoOrientationMode.landscapeAuto,
                    forceSensor: true,
                  ),
                ),
                OrientationButton(
                  label: "Portrait Auto (Forced)",
                  color: Colors.green,
                  onPressed: () => AutoOrientation.setOrientation(
                    AutoOrientationMode.portraitAuto,
                    forceSensor: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: "Legacy API (Deep Link)"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OrientationButton(
                  label: "Legacy Landscape Right",
                  color: Colors.grey,
                  onPressed: () => AutoOrientation.landscapeRightMode(),
                ),
                OrientationButton(
                  label: "Legacy Portrait Up",
                  color: Colors.grey,
                  onPressed: () => AutoOrientation.portraitUpMode(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
      ),
    );
  }
}

class OrientationButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const OrientationButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
