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
            const SectionHeader(
                title: "Declarative API (AutoOrientationScope)"),
            OrientationButton(
              label: "Open Landscape Screen (Auto Lock & Revert)",
              color: Colors.deepPurple,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScopedLandscapeScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: "Legacy API (Direct Methods)"),
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
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Current Orientation: ${AutoOrientation.isLandscape(context) ? "LANDSCAPE 📱↔️" : "PORTRAIT 📱↕️"}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScopedLandscapeScreen extends StatelessWidget {
  const ScopedLandscapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoOrientationScope(
      targetMode: AutoOrientationMode.landscapeRight,
      onDisposeMode: AutoOrientationMode.portraitUp,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Scoped Landscape Screen"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.screen_rotation,
                  size: 64, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text(
                "This screen is automatically locked to Landscape Right!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "When you press back, it will revert back to Portrait Up.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Go Back"),
              ),
            ],
          ),
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
