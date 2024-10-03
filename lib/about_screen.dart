import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/2k_stars.jpg"), // Path to your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AboutQuikVisionHeaderWithIcon(),
                  const SizedBox(height: 8),
                  const Text(
                    'Read about the history of Quick, Earth, and seismic events.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildCard(
                      '''The Apollo missions, undertaken by NASA between 1969 and 1972, were a monumental achievement in human history. These missions not only marked the first successful human landings on the Moon but also provided invaluable scientific data that deepened our understanding of Earth's celestial neighbor. Among the many scientific experiments conducted during the Apollo missions, the recording of lunar seismic events stands out as a significant contribution to lunar science. These seismic recordings have unearthed a wealth of knowledge about the Moon's geological history, structure, and evolution.
      '''),
                  const SizedBox(height: 32),
                  _buildCard(
                      '''The Apollo missions deployed a series of seismometers on the lunar surface during Apollo 11, 12, 14, 15, and 16 missions. These seismometers were collectively part of the Apollo Lunar Surface Experiments Package (ALSEP), and they recorded seismic activities on the Moon for extended periods. The primary goal of these experiments was to investigate the moon's internal structure, tectonic activity, and the nature of lunar earthquakes, also known as "moonquakes."'''),
                  const SizedBox(height: 32),
                  _buildCard('''
      Moonquakes, as recorded by the seismometers, were classified into two main categories: deep moonquakes and shallow moonquakes. Deep moonquakes were characterized by their origin in the deep lunar interior, often several hundred kilometers below the surface. These events were more akin to tectonic activity on Earth, and they provided vital insights into the Moon's internal dynamics. Shallow moonquakes, on the other hand, occurred relatively close to the lunar surface. These were generally weaker than deep moonquakes but were more frequent. The seismometers detected thousands of shallow moonquakes during their operational lifetimes. The exact cause of these shallow moonquakes remains a subject of scientific investigation, with potential triggers including meteorite impacts, thermal stress, or the gravitational pull of Earth.'''),
                  const SizedBox(height: 32),
                  _buildCard('''
      The seismic data recorded by the Apollo missions allowed scientists to develop a detailed picture of the Moon's internal structure. By analyzing the propagation of seismic waves through the lunar interior, researchers were able to estimate the composition and thickness of the Moon's crust, mantle, and potentially even a partially molten layer deep beneath the surface. One of the most surprising discoveries was the existence of a partially molten layer or "magma ocean" beneath the lunar surface. This finding challenged earlier assumptions about the Moon's interior and raised intriguing questions about its geological history and early volcanic activity.
      '''),
                  const SizedBox(height: 32),
                  _buildCard(
                    'Additionally, we are developing an interactive web application that visualizes this filtered quake data across Earth, Mars, and the Moon. This 3D interface will provide users with an engaging way to explore seismic activity, enhancing public understanding and education. By combining intelligent data analysis with informative visualization, this project aims to transform how we interpret and present planetary seismic data.',
                  ),
                  const SizedBox(height: 22),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.0,
                    ), // Adjust the value as needed
                    child: Divider(color: Colors.white54, thickness: 0),
                  ),
                  const SizedBox(height: 50),
                  const LauncherLinks(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String content) {
    return Card(
      color: Colors.black.withOpacity(1),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        content,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}

class LauncherLinks extends StatelessWidget {
  const LauncherLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // NASA Space Apps Challenge Link
            _buildLauncherLink(
              text: 'NASA Space Apps Challenge',
              url: 'https://www.spaceappschallenge.org/',
            ),
            // Apollo Seismic Event Catalog Link
            _buildLauncherLink(
              text: "Apollo Seismic Event Catalog (NASA's PDS)",
              url: 'https://pds-geosciences.wustl.edu/',
            ),
            // Lunar Seismic Events Info Link
            _buildLauncherLink(
              text: 'Read more about Quake Vision',
              url: 'https://www.example.com/', // Update with real link
            ),
          ],
        ),
        const SizedBox(height: 10),
        Lottie.asset(
          'assets/nasa_blue_logo.json',
          repeat: true,
          reverse: true,
          backgroundLoading: true,
          height: 75,
          width: 75,
        ),
      ],
    );
  }
}

class AboutQuikVisionHeaderWithIcon extends StatelessWidget {
  const AboutQuikVisionHeaderWithIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Quake Vision',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black45,
                  offset: Offset(3, 3),
                ),
              ],
            ),
          ),
          const Spacer(),
          Lottie.asset(
            'assets/about_us.json',
            repeat: true,
            reverse: true,
            backgroundLoading: true,
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}

// Helper function to build the clickable link
Widget _buildLauncherLink({required String text, required String url}) {
  return InkWell(
    onTap: () async {
      Uri parsedUrl = Uri.parse(url);
      if (!await launchUrl(parsedUrl)) {
        throw Exception('Could not launch $url');
      } else {
        throw 'Could not launch $url';
      }
    },
    child: Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(width: 5),
        const Icon(
          Icons.open_in_new,
          color: Colors.white,
          size: 16,
        ),
      ],
    ),
  );
}
