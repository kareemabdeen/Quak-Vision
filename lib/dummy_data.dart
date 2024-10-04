import 'package:flutter/material.dart';
import 'package:flutter_earth_globe/globe_coordinates.dart';
import 'package:flutter_earth_globe/point.dart';
final pointStyle = const PointStyle(color: Colors.red, size: 15);
bool isLabelVisible = false;
List<Point> getMoonQuakes(BuildContext context) {
  return [
    Point(
      id: '1',
      coordinates: const GlobeCoordinates(3.01239, 23.42157), // Apollo 12
      label: 'Apollo 12 Moonquake (1970)',
      style: pointStyle,
      isLabelVisible: isLabelVisible,
      labelBuilder: labelBuilder,
      onTap: () {
        _showDetailsDialog(
            context,
            'Apollo 12',
            'Station: s12\n'
                'Latitude: about 3.01239° South\n'
                'Longitude: about 23.42157° West\n'
                'Location: Oceanus Procellarum, a large dark region on the Moon surface.\n'
                'Date: 1975/4/12 \n'
                'Sensing Duration: All day (572416 datapoint / day)\n'
                'Velocity: 5.98E-11\n'
                'Power: 4.8');
      },
      onHover: () {
        isLabelVisible = true;
      },
    ),
    Point(
      id: '2',
      coordinates: const GlobeCoordinates(26.0, 3.0), // Apollo 15
      label: 'Apollo 15 Moonquake (1971)',
      labelBuilder: labelBuilder,
      style: pointStyle,
      onTap: () {
        _showDetailsDialog(
            context,
            'Apollo 15 Moonquake (1971)',
            'Magnitude: 5.2\n'
                'Date: July 30, 1971\n'
                'Depth: Unknown\n'
                'Affected Areas: Near Apollo 15 landing site\n'
                'Tsunami Risk: No\n'
                'Casualties: None\n'
                'Response: Enhanced understanding of lunar geology.');
      },
    ),
  ];
}

Widget? labelBuilder(context, point, isHovered, _) {
  return Visibility(
    visible: isHovered,
    child: Text(
      point.label!,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

List<Point> getMarsQuakes(BuildContext context) {
  return [
    Point(
      id: '3',
      coordinates: const GlobeCoordinates(4.5, 135.0), // InSight
      label: 'First Detected Marsquake (2019)',
      style: const PointStyle(color: Colors.lime, size: 6),
      labelBuilder: labelBuilder,
      onTap: () {
        _showDetailsDialog(
            context,
            'First Detected Marsquake (2019)',
            'Magnitude: 3.6\n'
                'Date: April 6, 2019\n'
                'Depth: Unknown\n'
                'Affected Areas: Near InSight lander\n'
                'Tsunami Risk: No\n'
                'Casualties: None\n'
                'Response: Confirmed seismic activity on Mars.');
      },
    ),
    Point(
      id: '4',
      coordinates: const GlobeCoordinates(4.5, 135.0),
      label: 'Second Detected Marsquake (2019)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        _showDetailsDialog(
            context,
            'Second Detected Marsquake (2019)',
            'Magnitude: 4.2\n'
                'Date: May 22, 2019\n'
                'Depth: Unknown\n'
                'Affected Areas: Near InSight lander\n'
                'Tsunami Risk: No\n'
                'Casualties: None\n'
                'Response: Provided more data on Martian seismic activity.');
      },
    ),
  ];
}

void _showDetailsDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      elevation: 2,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

List<Point> getPoints(BuildContext context) {
  return [
    Point(
      id: '1',
      coordinates: const GlobeCoordinates(-38.14, -73.16),
      label: 'Great Chilean Earthquake (1960)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Great Chilean Earthquake (1960)'),
              content: const Text(
                'Magnitude: 9.5\n'
                'Date: May 22, 1960\n'
                'Depth: 25 km\n'
                'Affected Areas: Southern Chile\n'
                'Tsunami Risk: Yes\n'
                'Casualties: Approximately 5,000\n'
                'Response: Extensive international aid provided.',
              ),
              elevation: .5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '2',
      coordinates: const GlobeCoordinates(61.02, -147.73),
      label: 'Alaska Earthquake (1964)',
      labelBuilder: labelBuilder,
      style: pointStyle,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Alaska Earthquake (1964)'),
              content: const Text(
                'Magnitude: 9.2\n'
                'Date: March 27, 1964\n'
                'Depth: 25 km\n'
                'Affected Areas: Prince William Sound, Anchorage\n'
                'Tsunami Risk: Yes\n'
                'Casualties: 131\n'
                'Response: Significant rebuilding efforts in Anchorage.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '3',
      coordinates: const GlobeCoordinates(3.30, 95.98),
      label: 'Sumatra Earthquake (2004)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Sumatra Earthquake (2004)'),
              content: const Text(
                'Magnitude: 9.1\n'
                'Date: December 26, 2004\n'
                'Depth: 30 km\n'
                'Affected Areas: Northern Sumatra, Indonesia\n'
                'Tsunami Risk: Yes\n'
                'Casualties: Over 230,000\n'
                'Response: International tsunami relief efforts initiated.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '4',
      coordinates: const GlobeCoordinates(38.32, 142.37),
      label: 'Tohoku Earthquake (2011)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Tohoku Earthquake (2011)'),
              content: const Text(
                'Magnitude: 9.0\n'
                'Date: March 11, 2011\n'
                'Depth: 29 km\n'
                'Affected Areas: Eastern Japan\n'
                'Tsunami Risk: Yes\n'
                'Casualties: Over 18,000\n'
                'Response: Extensive disaster recovery and nuclear crisis response.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '5',
      coordinates: const GlobeCoordinates(52.50, 158.20),
      label: 'Kamchatka Earthquake (2003)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Kamchatka Earthquake (2003)'),
              content: const Text(
                'Magnitude: 8.3\n'
                'Date: November 18, 2003\n'
                'Depth: 50 km\n'
                'Affected Areas: Kamchatka Peninsula, Russia\n'
                'Tsunami Risk: Minor\n'
                'Casualties: Minimal\n'
                'Response: Local emergency services activated.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '6',
      coordinates: const GlobeCoordinates(18.11, -102.20),
      label: 'Great Mexican Earthquake (1985)',
      labelBuilder: labelBuilder,
      style: pointStyle,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Great Mexican Earthquake (1985)'),
              content: const Text(
                'Magnitude: 8.1\n'
                'Date: September 19, 1985\n'
                'Depth: 15 km\n'
                'Affected Areas: Mexico City\n'
                'Tsunami Risk: No\n'
                'Casualties: Approximately 10,000\n'
                'Response: Major improvements in building codes.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '7',
      coordinates: const GlobeCoordinates(38.18, 117.57),
      label: 'Tangshan Earthquake (1976)',
      labelBuilder: labelBuilder,
      style: pointStyle,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Tangshan Earthquake (1976)'),
              content: const Text(
                'Magnitude: 7.5\n'
                'Date: July 28, 1976\n'
                'Depth: 15 km\n'
                'Affected Areas: Tangshan, China\n'
                'Tsunami Risk: No\n'
                'Casualties: Estimated 240,000\n'
                'Response: Major urban reconstruction efforts.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '8',
      coordinates: const GlobeCoordinates(18.45, -72.53),
      label: 'Haiti Earthquake (2010)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Haiti Earthquake (2010)'),
              content: const Text(
                'Magnitude: 7.0\n'
                'Date: January 12, 2010\n'
                'Depth: 13 km\n'
                'Affected Areas: Port-au-Prince, Haiti\n'
                'Tsunami Risk: No\n'
                'Casualties: Estimated 160,000\n'
                'Response: Large-scale international aid and relief efforts.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '9',
      coordinates: const GlobeCoordinates(37.77, -122.42),
      label: 'San Francisco Earthquake (1906)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('San Francisco Earthquake (1906)'),
              content: const Text(
                'Magnitude: 7.9\n'
                'Date: April 18, 1906\n'
                'Depth: 8 km\n'
                'Affected Areas: San Francisco, California\n'
                'Tsunami Risk: No\n'
                'Casualties: Estimated 3,000\n'
                'Response: Major reforms in earthquake preparedness.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
    Point(
      id: '10',
      coordinates: const GlobeCoordinates(37.04, -121.88),
      label: 'Loma Prieta Earthquake (1989)',
      style: pointStyle,
      labelBuilder: labelBuilder,
      onTap: () {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Loma Prieta Earthquake (1989)'),
              content: const Text(
                'Magnitude: 6.9\n'
                'Date: October 17, 1989\n'
                'Depth: 11 km\n'
                'Affected Areas: San Francisco Bay Area\n'
                'Tsunami Risk: No\n'
                'Casualties: 63\n'
                'Response: Enhanced building codes and emergency preparedness.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        });
      },
    ),
  ];
}
