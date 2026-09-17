import 'package:flutter/material.dart' hide Size;
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/constants/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'package:hrms_app/feature/model/managerModel/employee_tracking_model.dart';
import 'package:hrms_app/feature/provider/managerProvider/manager_employee_tracking_provider.dart';

class EmployeeJourneyScreen extends StatefulWidget {
  final String employeeId;

  const EmployeeJourneyScreen({
    super.key,
    required this.employeeId,
  });

  @override
  State<EmployeeJourneyScreen> createState() =>
      _EmployeeJourneyScreenState();
}

class _EmployeeJourneyScreenState
    extends State<EmployeeJourneyScreen> {

  // ============================================================
  // MAPBOX
  // ============================================================

  MapboxMap? _mapboxMap;

  PointAnnotationManager? _pointAnnotationManager;

  PolylineAnnotationManager? _polylineAnnotationManager;

  bool _isMapReady = false;

  bool _isUpdatingMap = false;

  String? _lastLoadedDataKey;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    MapboxOptions.setAccessToken(
      AppStrings.MAPBOX_ACCESS_TOKEN,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Provider.of<ManagerEmployeeTrackingProvider>(
        context,
        listen: false,
      ).fetchEmployeeJourney(
        widget.employeeId,
        '2026-09-16',
      );
    });
  }

  // ============================================================
  // MAP CREATED
  // ============================================================

  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;

    debugPrint('Mapbox map created');
  }

  // ============================================================
  // STYLE LOADED
  // ============================================================

  Future<void> _onStyleLoaded(
      StyleLoadedEventData data,
      ) async {
    debugPrint('Mapbox style loaded');

    final map = _mapboxMap;

    if (map == null) {
      debugPrint('Mapbox instance is null');
      return;
    }

    try {
      // --------------------------------------------------------
      // IMPORTANT:
      // Always create fresh managers after style loaded
      // --------------------------------------------------------

      _isMapReady = false;

      _pointAnnotationManager = null;
      _polylineAnnotationManager = null;

      // Create the polyline layer first, then the point layer — Mapbox
      // stacks each new annotation layer above the previous ones, so
      // creating points last keeps the numbered/S/E markers drawn on
      // top of the route line instead of being hidden underneath it.
      final polylineManager =
      await map.annotations.createPolylineAnnotationManager();

      final pointManager =
      await map.annotations.createPointAnnotationManager();

      if (!mounted) return;

      _pointAnnotationManager = pointManager;
      _polylineAnnotationManager = polylineManager;

      // --------------------------------------------------------
      // BOTH MANAGERS READY
      // --------------------------------------------------------

      _isMapReady = true;

      debugPrint('Mapbox annotation managers ready');

      _checkAndUpdateData();

    } catch (e, stackTrace) {
      debugPrint(
        'Error creating Mapbox annotation managers: $e',
      );

      debugPrint(
        stackTrace.toString(),
      );
    }
  }

  // ============================================================
  // CHECK API DATA
  // ============================================================

  void _checkAndUpdateData() {
    if (!_isMapReady) {
      debugPrint('Map is not ready yet');
      return;
    }

    final provider =
    Provider.of<ManagerEmployeeTrackingProvider>(
      context,
      listen: false,
    );

    final trackingData = provider.trackingData?.data;

    if (trackingData == null) {
      debugPrint('Journey data is null');
      return;
    }

    _updateMapData(trackingData);
  }

  // ============================================================
  // UPDATE MAP DATA
  // ============================================================

  Future<void> _updateMapData(
      JourneyData data,
      ) async {
    if (!_isMapReady) {
      debugPrint('Map not ready');
      return;
    }

    if (_isUpdatingMap) {
      debugPrint('Map update already running');
      return;
    }

    final pointManager = _pointAnnotationManager;
    final polylineManager = _polylineAnnotationManager;
    final map = _mapboxMap;

    if (pointManager == null ||
        polylineManager == null ||
        map == null) {
      debugPrint('Mapbox managers are not available');
      return;
    }

    final routeCoordinates = data.routeCoordinates ?? [];
    final stoppages = data.stoppages ?? [];

    final key =
        '${data.employee?.id}_${routeCoordinates.length}_${stoppages.length}';

    if (_lastLoadedDataKey == key) {
      debugPrint('Same journey data already loaded');
      return;
    }

    _isUpdatingMap = true;

    try {
      // ============================================================
      // CLEAR OLD DATA
      // ============================================================

      await pointManager.deleteAll();
      await polylineManager.deleteAll();

      // ============================================================
      // CONVERT API LAT/LNG -> MAPBOX POSITION (FULL PATH)
      // ============================================================
      //
      // `route_coordinates` is the raw GPS breadcrumb trail and often
      // contains many consecutive pings at the exact same lat/long
      // (e.g. while the employee is stationary). We keep every point
      // for the polyline (accurate path), but collapse consecutive
      // duplicates into a single "unique waypoint" so numbered pins
      // only show up once per distinct place visited.

      final List<Position> allRoutePoints = [];
      final List<Position> uniqueWaypoints = [];

      for (final coordinate in routeCoordinates) {
        final latitude = coordinate.latitude;
        final longitude = coordinate.longitude;

        if (latitude == null || longitude == null) {
          continue;
        }

        final pos = Position(
          longitude.toDouble(),
          latitude.toDouble(),
        );
        allRoutePoints.add(pos);

        final lastWaypoint =
        uniqueWaypoints.isEmpty ? null : uniqueWaypoints.last;

        final isSameAsLast = lastWaypoint != null &&
            lastWaypoint.lat == pos.lat &&
            lastWaypoint.lng == pos.lng;

        if (!isSameAsLast) {
          uniqueWaypoints.add(pos);
        }
      }

      debugPrint(
        'Valid route points: ${allRoutePoints.length}, '
            'unique waypoints: ${uniqueWaypoints.length}',
      );

      // ============================================================
      // CAMERA POINTS
      // ============================================================

      final List<Point> cameraPoints = [];

      // ============================================================
      // DRAW BLUE POLYLINE
      // ============================================================

      if (allRoutePoints.length >= 2) {
        await polylineManager.create(
          PolylineAnnotationOptions(
            geometry: LineString(
              coordinates: allRoutePoints,
            ),
            lineColor: const Color(0xFF1976F3).value,
            lineWidth: 5.0,
            lineOpacity: 0.95,
          ),
        );

        cameraPoints.addAll(
          allRoutePoints.map(
                (position) => Point(
              coordinates: position,
            ),
          ),
        );
      }

      // ============================================================
      // START / END POSITIONS
      // ============================================================

      Position? startPosition;

      if (allRoutePoints.isNotEmpty) {
        startPosition = allRoutePoints.first;
      } else if (
      data.attendance?.loginLatitude != null &&
          data.attendance?.loginLongitude != null) {
        startPosition = Position(
          data.attendance!.loginLongitude!.toDouble(),
          data.attendance!.loginLatitude!.toDouble(),
        );
      }

      final Position? endPosition =
      allRoutePoints.length >= 2 ? allRoutePoints.last : null;

      // ============================================================
      // ROUTE WAYPOINTS (BLUE NUMBERED CIRCLES 1, 2, 3...)
      // ============================================================
      //
      // Skip any waypoint sitting at (or very near) the Start/End
      // location — those already get the dedicated green/red pins,
      // so numbering them again would just stack a blue circle on
      // top of it (this is what caused Start/End to show a numbered
      // blue circle instead of the S/E pin).

      bool overlapsStartOrEnd(Position pos) {
        if (startPosition != null &&
            _isNearPosition(pos, startPosition)) {
          return true;
        }
        if (endPosition != null &&
            _isNearPosition(pos, endPosition)) {
          return true;
        }
        return false;
      }

      if (stoppages.isNotEmpty) {
        // Preferred: backend-analyzed stoppages (has duration/arrival info).
        int number = 1;

        for (final stop in stoppages) {
          if (stop.latitude == null || stop.longitude == null) continue;

          final stopPosition = Position(
            stop.longitude!.toDouble(),
            stop.latitude!.toDouble(),
          );

          if (overlapsStartOrEnd(stopPosition)) continue;

          await _addNumberedPinMarker(
            position: stopPosition,
            text: '${number++}',
            color: const Color(0xFF1976F3),
          );

          cameraPoints.add(Point(coordinates: stopPosition));
        }
      } else if (uniqueWaypoints.length > 2) {
        // Fallback: no `stoppages` from the API — number every distinct
        // place visited in `route_coordinates` instead.
        final middleWaypoints = uniqueWaypoints
            .sublist(1, uniqueWaypoints.length - 1)
            .where((pos) => !overlapsStartOrEnd(pos))
            .toList();

        for (int i = 0; i < middleWaypoints.length; i++) {
          final stopPosition = middleWaypoints[i];

          await _addNumberedPinMarker(
            position: stopPosition,
            text: '${i + 1}',
            color: const Color(0xFF1976F3),
          );

          cameraPoints.add(Point(coordinates: stopPosition));
        }
      }

      // ============================================================
      // START LOCATION (GREEN PIN) — drawn after the numbered
      // waypoints so it always renders on top of them.
      // ============================================================

      if (startPosition != null) {
        await _addLocationPopupMarker(
          position: startPosition,
          title: 'Start',
          time: _formatTime(data.attendance?.loginAt),
          location: data.attendance?.loginLocationName ?? 'N/A',
          color: const Color(0xFF16A34A),
        );

        cameraPoints.add(Point(coordinates: startPosition));
      }

      // ============================================================
      // END / CURRENT LOCATION (RED PIN) — drawn last so it always
      // renders on top of everything else.
      // ============================================================

      if (endPosition != null) {
        String endTime = '--:--';
        if (data.attendance?.logoutAt != null) {
          endTime = _formatTime(data.attendance?.logoutAt);
        } else if (stoppages.isNotEmpty) {
          endTime = _formatTime(stoppages.last.departedAt);
        }

        await _addLocationPopupMarker(
          position: endPosition,
          title: 'End',
          time: endTime,
          location: routeCoordinates.last.locationName ?? 'N/A',
          color: const Color(0xFFDC2626),
          isEnd: true,
        );

        cameraPoints.add(Point(coordinates: endPosition));
      }

      // ============================================================
      // FIT CAMERA
      // ============================================================

      if (cameraPoints.isNotEmpty) {
        final camera = await map.cameraForCoordinates(
          cameraPoints,
          MbxEdgeInsets(
            top: 100,
            left: 50,
            bottom: 100,
            right: 50,
          ),
          null,
          null,
        );

        await map.setCamera(camera);

        debugPrint('Camera fitted to route');
      }

      _lastLoadedDataKey = key;

    } catch (e, stackTrace) {
      debugPrint('Error updating Mapbox data: $e');
      debugPrint(stackTrace.toString());
    } finally {
      _isUpdatingMap = false;
    }
  }

  // ============================================================
  // MARKER GENERATORS
  // ============================================================

  // Treats two points within ~55m of each other as the "same" stop —
  // GPS pings rarely land on the exact same lat/long twice.
  bool _isNearPosition(
      Position a,
      Position b, {
        double toleranceDegrees = 0.0005,
      }) {
    return (a.lat - b.lat).abs() < toleranceDegrees &&
        (a.lng - b.lng).abs() < toleranceDegrees;
  }

  Future<void> _addNumberedPinMarker({
    required Position position,
    required String text,
    required Color color,
  }) async {
    final manager = _pointAnnotationManager;
    if (manager == null) return;

    final markerImage = await _createNumberedCircleImage(
      text: text,
      backgroundColor: color,
    );

    await manager.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: position),
        image: markerImage,
        iconAnchor: IconAnchor.CENTER,
        iconSize: 1.0,
      ),
    );
  }

  // ------------------------------------------------------------
  // Draws a solid, high-contrast circle (white ring + colored
  // fill + bold white number) as a PNG so numbered waypoints are
  // clearly visible on the map, instead of relying on the tiny
  // default sprite icons.
  // ------------------------------------------------------------

  final Map<String, Uint8List> _numberedMarkerCache = {};

  Future<Uint8List> _createNumberedCircleImage({
    required String text,
    required Color backgroundColor,
    double size = 90,
  }) async {
    final cacheKey = '$text-${backgroundColor.value}';

    final cached = _numberedMarkerCache[cacheKey];
    if (cached != null) return cached;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final radius = size / 2;
    final center = Offset(radius, radius);

    // White outer ring for contrast against any map background.
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = Colors.white,
    );

    // Colored fill.
    canvas.drawCircle(
      center,
      radius - 6,
      Paint()..color = backgroundColor,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.42,
          fontWeight: FontWeight.w800,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );

    final picture = recorder.endRecording();

    final image = await picture.toImage(
      size.toInt(),
      size.toInt(),
    );

    final byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    final bytes = byteData!.buffer.asUint8List();

    _numberedMarkerCache[cacheKey] = bytes;

    return bytes;
  }

  Future<void> _addLocationPopupMarker({
    required Position position,
    required String title,
    required String time,
    required String location,
    required Color color,
    bool isEnd = false,
  }) async {
    final manager = _pointAnnotationManager;
    if (manager == null) return;

    // 1. Add the solid circle pin (green for Start, red for End) with
    // a bold white letter in the middle.
    final markerImage = await _createNumberedCircleImage(
      text: isEnd ? 'E' : 'S',
      backgroundColor: color,
    );

    await manager.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: position),
        image: markerImage,
        iconAnchor: IconAnchor.CENTER,
        iconSize: 1.0,
      ),
    );

    // 2. Add the info box as a text field
    await manager.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: position),
        textField: "$title\n$time\n$location",
        textColor: const Color(0xFF1F2937).value,
        textSize: 9.0,
        textMaxWidth: 12.0,
        textJustify: TextJustify.LEFT,
        textAnchor: isEnd ? TextAnchor.TOP_LEFT : TextAnchor.TOP_RIGHT,
        textOffset: isEnd ? [1.5, 0.0] : [-1.5, 0.0],

        textHaloColor: Colors.white.value,
        textHaloWidth: 2.0,
      ),
    );
  }

  // ============================================================
  // FORMAT TIME
  // ============================================================

  String _formatTime(
      String? dateTimeStr,
      ) {

    if (
    dateTimeStr == null ||
        dateTimeStr.isEmpty
    ) {
      return '--:--';
    }

    try {

      final dt =
      DateTime.parse(dateTimeStr);

      return DateFormat(
        'hh:mm a',
      ).format(dt);

    } catch (e) {

      return dateTimeStr;
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
      BuildContext context,
      ) {

    return Consumer<
        ManagerEmployeeTrackingProvider>(
      builder: (
          context,
          provider,
          child,
          ) {

        // ------------------------------------------------------
        // LOADING
        // ------------------------------------------------------

        if (provider.isLoading) {

          return const Scaffold(
            backgroundColor:
            Color(0xFFF3F4F6),

            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF7C3AED),
              ),
            ),
          );
        }

        // ------------------------------------------------------
        // TRACKING DATA
        // ------------------------------------------------------

        final tracking =
            provider.trackingData?.data;

        final employee =
            tracking?.employee;

        final attendance =
            tracking?.attendance;

        final summary =
            tracking?.journeySummary;

        final session =
            tracking?.session;

        final stoppages =
            tracking?.stoppages ?? [];

        // ------------------------------------------------------
        // AFTER BUILD -> UPDATE MAP
        // ------------------------------------------------------

        if (
        tracking != null &&
            _isMapReady &&
            _lastLoadedDataKey == null
        ) {

          WidgetsBinding.instance
              .addPostFrameCallback((_) {

            if (!mounted) return;

            _checkAndUpdateData();
          });
        }

        // ------------------------------------------------------
        // UI
        // ------------------------------------------------------

        return Scaffold(
          body: Container(
            width: double.infinity,

            height: double.infinity,

            decoration:
            const BoxDecoration(

              image: DecorationImage(
                image: AssetImage(
                  AppImagesPng
                      .dashboardBackground,
                ),

                fit: BoxFit.cover,
              ),
            ),

            child: SafeArea(
              child: Column(
                children: [

                  // ==================================================
                  // HEADER
                  // ==================================================

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),

                    child: Row(
                      children: [

                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),

                          onPressed: () =>
                              Navigator.pop(context),
                        ),

                        const Text(
                          'Employee Journey',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // CONTENT
                  // ==================================================

                  Expanded(
                    child: SingleChildScrollView(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),

                      child: Column(
                        children: [

                          _buildEmployeeInfoCard(
                            employee,
                            attendance,
                            summary,
                            session,
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          _buildMapCard(),

                          const SizedBox(
                            height: 16,
                          ),

                          _buildJourneyDetailsCard(
                            attendance,
                            stoppages,
                            tracking?.date,
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // EMPLOYEE INFO CARD
  // ============================================================

  Widget _buildEmployeeInfoCard(
      EmployeeInfo? employee,
      AttendanceInfo? attendance,
      JourneySummary? summary,
      SessionInfo? session,
      ) {

    return Column(
      children: [

        Container(
          padding:
          const EdgeInsets.all(16),

          decoration:
          const BoxDecoration(
            color: Colors.white,

            borderRadius:
            BorderRadius.only(
              topLeft:
              Radius.circular(16),
              topRight:
              Radius.circular(16),
            ),
          ),

          child: Column(
            children: [

              Row(
                children: [

                  const CircleAvatar(
                    radius: 26,

                    backgroundImage:
                    AssetImage(
                      AppImagesPng
                          .persionIcon,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          employee?.name ??
                              'N/A',

                          style:
                          const TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Color(0xFF1F2937),
                          ),
                        ),

                        Text(
                          employee
                              ?.designation
                              ?.name ??
                              'N/A',

                          style:
                          const TextStyle(
                            fontSize: 13,
                            color:
                            Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),

                    decoration:
                    BoxDecoration(
                      border: Border.all(
                        color:
                        const Color(
                          0xFFE5E7EB,
                        ),
                      ),

                      borderRadius:
                      BorderRadius.circular(
                        8,
                      ),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons
                              .calendar_today_outlined,
                          size: 14,
                          color:
                          Color(0xFF6B7280),
                        ),

                        const SizedBox(
                          width: 6,
                        ),

                        Text(
                          attendance
                              ?.attendanceDate ??
                              '--',

                          style:
                          const TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  vertical: 16,
                ),

                decoration:
                BoxDecoration(
                  color:
                  const Color(0xFFF9FAFB),

                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),

                child: Row(
                  children: [

                    _buildInfoItem(
                      'Login Time',
                      _formatTime(
                        attendance?.loginAt,
                      ),
                    ),

                    _buildVerticalDivider(),

                    _buildInfoItem(
                      'Distance Travelled',
                      "${session?.totalDistanceKm?.toStringAsFixed(1) ?? '0.0'} km",
                    ),

                    _buildVerticalDivider(),

                    _buildInfoItem(
                      'Total Stop',
                      "${summary?.totalStoppages ?? 0}",
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              const Text(
                'Current Location',

                style: TextStyle(
                  color:
                  Color(0xFF10B981),
                  fontWeight:
                  FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,

          padding:
          const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),

          decoration:
          const BoxDecoration(
            color:
            Color(0xFFDCFCE7),

            borderRadius:
            BorderRadius.only(
              bottomLeft:
              Radius.circular(16),
              bottomRight:
              Radius.circular(16),
            ),
          ),

          child: Text(
            attendance?.loginLocationName ??
                'Location not available',

            textAlign:
            TextAlign.center,

            style: const TextStyle(
              color:
              Color(0xFF065F46),
              fontSize: 12,
              fontWeight:
              FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INFO ITEM
  // ============================================================

  Widget _buildInfoItem(
      String label,
      String value,
      ) {

    return Expanded(
      child: Column(
        children: [

          Text(
            label,

            style:
            const TextStyle(
              fontSize: 11,
              color:
              Color(0xFF6B7280),
              fontWeight:
              FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            value,

            style:
            const TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.w900,
              color:
              Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _buildVerticalDivider() {

    return Container(
      height: 30,
      width: 1,
      color:
      const Color(0xFFE5E7EB),
    );
  }

  // ============================================================
  // MAP CARD
  // ============================================================

  Widget _buildMapCard() {
    return Container(
      height: 380,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            MapWidget(
              key: const ValueKey('employeeJourneyMap'),
              styleUri: MapboxStyles.MAPBOX_STREETS,
              onMapCreated: _onMapCreated,
              onStyleLoadedListener: _onStyleLoaded,
            ),

            // Zoom Controls
            Positioned(
              right: 12,
              top: 12,
              child: Column(
                children: [
                  _buildZoomButton(
                    icon: Icons.add,
                    onPressed: () async {
                      final camera = await _mapboxMap?.getCameraState();
                      if (camera != null) {
                        _mapboxMap?.setCamera(
                          CameraOptions(
                            zoom: camera.zoom + 1,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildZoomButton(
                    icon: Icons.remove,
                    onPressed: () async {
                      final camera = await _mapboxMap?.getCameraState();
                      if (camera != null) {
                        _mapboxMap?.setCamera(
                          CameraOptions(
                            zoom: camera.zoom - 1,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            Positioned(
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLegendItem(Icons.location_on, Colors.green, 'Start'),
                    const SizedBox(height: 4),
                    _buildLegendItem(Icons.location_on, Colors.red, 'End'),
                    const SizedBox(height: 4),
                    _buildLegendItem(Icons.circle, const Color(0xFF3B82F6), 'Route Point'),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 2,
                          color: const Color(0xFF3B82F6),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Route',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF1F2937)),
        onPressed: onPressed,
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildLegendItem(IconData icon, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // ============================================================
  // JOURNEY DETAILS
  // ============================================================

  Widget _buildJourneyDetailsCard(
      AttendanceInfo? attendance,
      List<StoppageInfo> stoppages,
      String? date,
      ) {

    String formattedDate = '';

    if (date != null) {

      try {

        formattedDate =
            DateFormat(
              'd MMM yyyy',
            ).format(
              DateTime.parse(date),
            );

      } catch (_) {

        formattedDate = date;
      }
    }

    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(20),

      decoration:
      BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            'Journey Details ($formattedDate)',

            style:
            const TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight.w800,
              color:
              Color(0xFF7C3AED),
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          _buildTimelineItem(
            '1',
            _formatTime(
              attendance?.loginAt,
            ),
            'Attendance Check-in',
            attendance
                ?.loginLocationName ??
                'N/A',
            const Color(0xFF10B981),

            isLast:
            stoppages.isEmpty,
          ),

          ...List.generate(
            stoppages.length,
                (index) {

              final stop =
              stoppages[index];

              return _buildTimelineItem(
                (index + 2).toString(),

                _formatTime(
                  stop.arrivedAt,
                ),

                'Stoppage / Client Visit',

                stop.locationName ??
                    'Unknown Location',

                const Color(0xFF7C3AED),

                subLocation:
                '${stop.durationMinutes ?? 0}m duration',

                isVisit: true,

                isLast:
                index ==
                    stoppages.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TIMELINE
  // ============================================================

  Widget _buildTimelineItem(
      String index,
      String time,
      String title,
      String location,
      Color color, {
        bool isLast = false,
        bool isVisit = false,
        bool isLocation = false,
        String? subLocation,
      }) {

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Column(
            children: [

              Container(
                width: 30,
                height: 30,

                decoration:
                BoxDecoration(
                  color: isLocation
                      ? Colors.transparent
                      : color,

                  shape:
                  BoxShape.circle,
                ),

                alignment:
                Alignment.center,

                child: isLocation

                    ? Icon(
                  Icons.location_on,
                  color: color,
                  size: 30,
                )

                    : Text(
                  index,

                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              if (!isLast)
                Expanded(
                  child:
                  Container(
                    width: 1.5,
                    color:
                    const Color(
                      0xFFE5E7EB,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Container(
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration:
                      BoxDecoration(
                        color:
                        const Color(
                          0xFFF3F4F6,
                        ),

                        borderRadius:
                        BorderRadius
                            .circular(
                          6,
                        ),

                        border:
                        Border.all(
                          color:
                          const Color(
                            0xFFE5E7EB,
                          ),
                        ),
                      ),

                      child: Text(
                        time,

                        style:
                        const TextStyle(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w700,
                          color:
                          Color(
                            0xFF1F2937,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 16,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          Text(
                            title,

                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                              FontWeight
                                  .w800,

                              color: isVisit
                                  ? const Color(
                                0xFF3B82F6,
                              )
                                  : const Color(
                                0xFF1F2937,
                              ),

                              decoration:
                              isVisit
                                  ? TextDecoration
                                  .underline
                                  : null,
                            ),
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          Text(
                            location,

                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                              isVisit
                                  ? FontWeight
                                  .w800
                                  : FontWeight
                                  .w500,

                              color: isVisit
                                  ? const Color(
                                0xFF1C2263,
                              )
                                  : const Color(
                                0xFF6B7280,
                              ),
                            ),
                          ),

                          if (subLocation !=
                              null)

                            Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                top: 2,
                              ),

                              child: Text(
                                subLocation,

                                style:
                                const TextStyle(
                                  fontSize: 12,
                                  color:
                                  Color(
                                    0xFF60A5FA,
                                  ),
                                  decoration:
                                  TextDecoration
                                      .underline,
                                  fontWeight:
                                  FontWeight
                                      .w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                if (!isLast)
                  Container(
                    margin:
                    const EdgeInsets
                        .only(
                      bottom: 20,
                    ),

                    child: CustomPaint(
                      size: const ui.Size(
                        double.infinity,
                        1,
                      ),

                      painter:
                      HorizontalDashedLinePainter(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// DASHED LINE
// ================================================================

class HorizontalDashedLinePainter
    extends CustomPainter {

  @override
  void paint(
      Canvas canvas,
      ui.Size size,
      ) {

    final paint = Paint()
      ..color =
      const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    final max = size.width;

    const dashWidth = 4.0;

    const dashSpace = 4.0;

    double startX = 0;

    while (startX < max) {

      canvas.drawLine(
        Offset(startX, 0),
        Offset(
          startX + dashWidth,
          0,
        ),
        paint,
      );

      startX +=
          dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(
      CustomPainter oldDelegate,
      ) =>
      false;
}