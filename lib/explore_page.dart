import 'package:example/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
import 'package:flutter_earth_globe/globe_coordinates.dart';
import 'package:flutter_earth_globe/point.dart';
import 'package:flutter_earth_globe/point_connection.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String? _selectedSurface;
  GlobeCoordinates? _hoverCoordinates;
  GlobeCoordinates? _clickCoordinates;
  String? _selectedSeismicEvent; // Start without a preselected value
  Map<String, dynamic>?
      _selectedEventData; // To hold the selected event details

  late FlutterEarthGlobeController _controller;

  final List<String> _textures = [
    'assets/2k_earth-day.jpg',
    'assets/2k_earth-night.jpg',
    'assets/2k_mars.jpg',
    'assets/2k_moon.jpg',
  ];

  final List<Map<String, dynamic>> _seismicEvents = [
    {
      'name': 'Nakamura 1979 - SM - 1971/107',
      'type': 'SM - Shallow Moonquake',
      'date': '1971/107',
      'time': '07:00:55',
      'epicenter': '48°, 35°',
      'magnitude': 2.8,
      'depth': 'N/A',
      'detectedBy': 'Apollo Sites: 12, 14',
      'coordinates': const GlobeCoordinates(10.0, 20.0)
    },
    {
      'name': 'Nakamura 1979 - SM - 1971/140',
      'type': 'SM - Shallow Moonquake',
      'date': '1971/140',
      'time': '08:00:12',
      'epicenter': '52°, 38°',
      'magnitude': 3.1,
      'depth': 'N/A',
      'detectedBy': 'Apollo Sites: 12',
      'coordinates': const GlobeCoordinates(15.0, 25.0)
    },
    {
      'name': 'Nakamura 1979 - SM - 1972/002',
      'type': 'SM - Shallow Moonquake',
      'date': '1972/002',
      'time': '06:30:45',
      'epicenter': '44°, 32°',
      'magnitude': 2.6,
      'depth': 'N/A',
      'detectedBy': 'Apollo Sites: 12, 15',
      'coordinates': const GlobeCoordinates(30.0, -10.0)
    },
    // Add more events as needed
  ];

  List<Point> points = [];
  List<PointConnection> connections = [];

  Widget pointLabelBuilder(
      BuildContext context, Point point, bool isHovering, bool visible) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: isHovering
              ? Colors.blueAccent.withOpacity(0.8)
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 2)
          ]),
      child: Text(point.label ?? '',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white)),
    );
  }

  Widget connectionLabelBuilder(BuildContext context,
      PointConnection connection, bool isHovering, bool visible) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: isHovering
              ? Colors.blueAccent.withOpacity(0.8)
              : Colors.blueAccent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 2)
          ]),
      child: Text(
        connection.label ?? '',
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  initState() {
    _controller = FlutterEarthGlobeController(
        rotationSpeed: 0.05,
        zoom: 0.5,
        isRotating: false,
        isBackgroundFollowingSphereRotation: true,
        background: Image.asset('assets/2k_stars.jpg').image,
        surface: Image.asset('assets/2k_earth-day.jpg').image);
    points = getPoints(context);
    _controller.onLoaded = () {
      setState(() {
        _selectedSurface = _textures[0];
      });
    };

    for (var point in points) {
      _controller.addPoint(point);
    }

    super.initState();
  }

  void _onEventSelected(String? newValue) {
    setState(() {
      _selectedSeismicEvent = newValue;

      // Find the selected event based on the name
      final selectedEvent = _seismicEvents
          .firstWhere((event) => event['name'] == newValue, orElse: () => {});

      // Update the selected event data
      if (selectedEvent.isNotEmpty) {
        _selectedEventData = selectedEvent;
        // Focus on the coordinates of the selected event
        _controller.focusOnCoordinates(
          selectedEvent['coordinates'],
          animate: true,
        );
      } else {
        _selectedEventData = null;
      }
    });
  }

  Widget getDividerText(String text) => Card(
        color: Colors.black12.withOpacity(0.8),
        child: SizedBox(
          width: 250,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.black38,
                  height: 2,
                ),
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.black38,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
      );

  getTextures() {
    return ListView(
      shrinkWrap: true,
      children: _textures
          .map((texture) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Card(
                  color: _selectedSurface == texture
                      ? Colors.grey[800]
                      : Colors.black12.withOpacity(0.8),
                  child: InkWell(
                    onTap: () {
                      _controller.loadSurface(Image.asset(texture).image);
                      setState(() {
                        _selectedSurface = texture;
                        for (var point in points) {
                          _controller.removePoint(point.id);
                        }
                        if (texture.contains('mars')) {
                          points = getMarsQuakes(context);
                        } else if (texture.contains('moon')) {
                          points = getMoonQuakes(context);
                        } else {
                          points = getPoints(
                              context); // Load Earth points by default
                        }

                        // Add the new points to the controller
                        for (var point in points) {
                          _controller.addPoint(point);
                        }
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(texture, width: 100),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          texture
                              .replaceFirst('assets/', '')
                              .split('.')[0]
                              .replaceAll('_', ' ')
                              .split(' ')[1]
                              .toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget getListAction(String label, Widget child, {Widget? secondary}) {
    return FittedBox(
      child: Card(
        color: Colors.black12.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  child
                ],
              ),
              secondary ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftSideContent() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: 220,
      child: ListView(
        shrinkWrap: true,
        children: [
          getListAction(
            'Rotate',
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                    value: _controller.isRotating,
                    onChanged: (value) {
                      if (value) {
                        _controller.startRotation();
                      } else {
                        _controller.stopRotation();
                      }
                      setState(() {});
                    }),
                IconButton(
                    onPressed: () {
                      _controller.resetRotation();
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
          ),
          getListAction('Rotation speed', Container(),
              secondary: Slider(
                  activeColor: Colors.white,
                  value: _controller.rotationSpeed,
                  onChanged: _controller.isRotating
                      ? (value) {
                          _controller.rotationSpeed = value;
                          setState(() {});
                        }
                      : null)),
          getListAction('Zoom', Container(),
              secondary: Slider(
                  activeColor: Colors.white,
                  min: _controller.minZoom,
                  max: _controller.maxZoom,
                  value: _controller.zoom,
                  divisions: 8,
                  onChanged: (value) {
                    _controller.setZoom(value);
                    setState(() {});
                  })),
          getDividerText('Quake Points'),
          ...points
              .map((e) => getListAction(
                  e.label ?? '',
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        activeColor: Colors.white,
                        value: _controller.points
                            .where((element) => element.id == e.id)
                            .isNotEmpty,
                        onChanged: (value) {
                          if (value == true) {
                            _controller.addPoint(e);
                          } else {
                            _controller.removePoint(e.id);
                          }
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            _controller.focusOnCoordinates(e.coordinates,
                                animate: true);
                          },
                          icon: const Icon(Icons.location_on))
                    ],
                  ),
                  secondary: _controller.points
                          .where((element) => element.id == e.id)
                          .isNotEmpty
                      ? Row(
                          children: [
                            Slider(
                                activeColor: Colors.white,
                                value: e.style.size / 30,
                                onChanged: (value) {
                                  value = value * 30;
                                  _controller.updatePoint(e.id,
                                      style: e.style.copyWith(size: value));
                                  e.style = e.style.copyWith(size: value);
                                  setState(() {});
                                }),
                          ],
                        )
                      : null))
              .toList(),
        ],
      ),
    );
  }

  Widget getLeftSide() {
    if (MediaQuery.of(context).size.width < 800) {
      return IconButton.filled(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu));
    } else {
      return leftSideContent();
    }
  }

  Widget rightSideContent() {
    return SizedBox(
      width: 220,
      height: MediaQuery.of(context).size.height - 10,
      child: getTextures(),
    );
  }

  Widget getRightSide() {
    if (MediaQuery.of(context).size.width < 800) {
      return IconButton.filled(
          onPressed: () {
            _key.currentState?.openEndDrawer();
          },
          icon: const Icon(Icons.menu));
    } else {
      return rightSideContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width < 500
        ? ((MediaQuery.of(context).size.width / 3.8) - 20)
        : 120;
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
      primary: true,
      extendBodyBehindAppBar: true,
      drawer: MediaQuery.of(context).size.width < 800
          ? Container(
              color: Colors.black12.withOpacity(0.8),
              child: leftSideContent(),
            )
          : null,
      endDrawer: MediaQuery.of(context).size.width < 800
          ? Container(
              color: Colors.black12.withOpacity(0.8),
              child: rightSideContent(),
            )
          : null,
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          FlutterEarthGlobe(
            onZoomChanged: (zoom) {
              setState(() {});
            },
            onTap: (coordinates) {
              setState(() {
                _clickCoordinates = coordinates;
              });
            },
            onHover: (coordinates) {
              if (coordinates == null) return;

              setState(() {
                _hoverCoordinates = coordinates;
              });
            },
            controller: _controller,
            radius: radius,
          ),
          Positioned(top: 10, left: 10, child: getLeftSide()),
          Positioned(top: 10, right: 10, child: getRightSide()),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                SizedBox(
                  width: 250,
                  child: Card(
                    color: Colors.black12.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Select a Seismic Event',
                            style: TextStyle(color: Colors.white),
                          ),
                          DropdownButton<String>(
                            dropdownColor: Colors.grey[850],
                            value: _selectedSeismicEvent,
                            isExpanded: true,
                            hint: const Text(
                              'Select a Seismic Event',
                              style: TextStyle(color: Colors.white),
                            ),
                            items: _seismicEvents
                                .map((event) => DropdownMenuItem<String>(
                                      value: event['name'],
                                      child: Text(
                                        event['name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: _onEventSelected,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Display seismic event details in the bottom right when an event is selected
          if (_selectedEventData != null)
            Positioned(
              bottom: 30,
              right: 30,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Seismic Event:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedEventData = null;
                              });
                            },
                            icon: const Icon(Icons.clear))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Type: ${_selectedEventData!['type']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Date of detection: ${_selectedEventData!['date']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Time of detection: ${_selectedEventData!['time']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Epicentre: ${_selectedEventData!['epicenter']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Magnitude: ${_selectedEventData!['magnitude']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Depth: ${_selectedEventData!['depth']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Detected by: ${_selectedEventData!['detectedBy']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
