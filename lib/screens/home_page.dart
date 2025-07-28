import 'package:flutter/material.dart';
import 'map_screen.dart'; // Import your map screen

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool featuresEnabled = false;

  void _searchRoute() {
    String input = _searchController.text.trim();
    if (input.isNotEmpty) {
      setState(() {
        featuresEnabled = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Route '$input' activated.")),
      );
    } else {
      setState(() {
        featuresEnabled = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid bus number or route.")),
      );
    }
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40, color: Colors.deepPurple),
                const SizedBox(height: 10),
                Text(label, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSOSSection() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              debugPrint("SOS Pressed!");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("🚨 SOS sent to authorities.")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text(
              "🚨 SOS",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              debugPrint("Emergency Alert Triggered!");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Emergency Alert sent.")),
              );
            },
            icon: const Icon(Icons.warning_amber, color: Colors.orange),
            label: const Text("Emergency Alert", style: TextStyle(fontSize: 16)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.orange, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapScreen()),
          );
        },
        icon: const Icon(Icons.map, color: Colors.white),
        label: const Text("Live Map"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Public Transport")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Enter bus number or route",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _searchRoute,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text("Search"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    icon: Icons.directions_bus,
                    label: "Current Bus",
                    enabled: featuresEnabled,
                    onTap: () => debugPrint("Current Bus clicked"),
                  ),
                  _buildFeatureCard(
                    icon: Icons.people_alt,
                    label: "Passenger Count",
                    enabled: featuresEnabled,
                    onTap: () => debugPrint("Passenger Count clicked"),
                  ),
                  _buildFeatureCard(
                    icon: Icons.male,
                    label: "Gender Ratio",
                    enabled: featuresEnabled,
                    onTap: () => debugPrint("Gender Ratio clicked"),
                  ),
                  _buildFeatureCard(
                    icon: Icons.verified_user,
                    label: "Safety Badge",
                    enabled: featuresEnabled,
                    onTap: () => debugPrint("Safety Badge clicked"),
                  ),
                ],
              ),
            ),

            _buildSOSSection(),
            _buildMapButton(), // Add Live Map button
          ],
        ),
      ),
    );
  }
}
