import 'dart:typed_data';

import 'package:flutter/material.dart' hide Size;
import 'dart:ui' as ui show Size;

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

      final pointManager =
      await map.annotations.createPointAnnotationManager();

      final polylineManager =
      await map.annotations.createPolylineAnnotationManager();

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

    // ----------------------------------------------------------
    // Safety checks
    // ----------------------------------------------------------

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

      debugPrint(
        'Mapbox managers are not available',
      );

      return;
    }

    // ----------------------------------------------------------
    // Data key
    // ----------------------------------------------------------

    final routeCoordinates =
        data.routeCoordinates ?? [];

    final stoppages =
        data.stoppages ?? [];

    final key =
        '${data.employee?.id}_'
        '${routeCoordinates.length}_'
        '${stoppages.length}';

    // Already loaded
    if (_lastLoadedDataKey == key) {
      debugPrint(
        'Same journey data already loaded',
      );

      return;
    }

    _isUpdatingMap = true;

    try {

      // ========================================================
      // CLEAR OLD ANNOTATIONS
      // ========================================================

      await pointManager.deleteAll();

      await polylineManager.deleteAll();

      // ========================================================
      // ROUTE POINTS
      // ========================================================

      final List<Position> allRoutePoints = [];

      for (final coordinate in routeCoordinates) {

        final latitude = coordinate.latitude;

        final longitude = coordinate.longitude;

        if (latitude == null ||
            longitude == null) {
          continue;
        }

        allRoutePoints.add(
          Position(
            longitude.toDouble(),
            latitude.toDouble(),
          ),
        );
      }

      debugPrint(
        'Valid route points: ${allRoutePoints.length}',
      );

      // ========================================================
      // CAMERA POINTS
      // ========================================================

      final List<Point> cameraPoints = [];

      // ========================================================
      // DRAW ROUTE
      // ========================================================

      if (allRoutePoints.length >= 2) {

        await polylineManager.create(
          PolylineAnnotationOptions(
            geometry: LineString(
              coordinates: allRoutePoints,
            ),

            // Blue route
            lineColor: Colors.blue.value,

            lineWidth: 5.0,

            // Optional
            lineOpacity: 0.9,
          ),
        );

        cameraPoints.addAll(
          allRoutePoints.map(
                (position) => Point(
              coordinates: position,
            ),
          ),
        );

        debugPrint(
          'Route polyline created',
        );
      }

      // ========================================================
      // START LOCATION
      // ========================================================

      Position? startPosition;

      if (allRoutePoints.isNotEmpty) {

        startPosition =
            allRoutePoints.first;

      } else if (
      data.attendance?.loginLatitude != null &&
          data.attendance?.loginLongitude != null
      ) {

        startPosition = Position(
          data.attendance!.loginLongitude!
              .toDouble(),

          data.attendance!.loginLatitude!
              .toDouble(),
        );
      }

      if (startPosition != null) {

        await _addStartEndMarker(
          position: startPosition,
          label: 'Start',
          color: Colors.green,
        );

        cameraPoints.add(
          Point(
            coordinates: startPosition,
          ),
        );
      }

      // ========================================================
      // END LOCATION
      // ========================================================

      if (allRoutePoints.length >= 2) {

        final endPosition =
            allRoutePoints.last;

        await _addStartEndMarker(
          position: endPosition,
          label: 'End',
          color: Colors.red,
        );

        cameraPoints.add(
          Point(
            coordinates: endPosition,
          ),
        );
      }

      // ========================================================
      // STOPPAGE MARKERS
      // ========================================================

      for (
      int index = 0;
      index < stoppages.length;
      index++
      ) {

        final stop = stoppages[index];

        if (
        stop.latitude == null ||
            stop.longitude == null
        ) {
          continue;
        }

        final stopPosition = Position(
          stop.longitude!.toDouble(),
          stop.latitude!.toDouble(),
        );

        await _addNumberedMarker(
          position: stopPosition,
          text: '${index + 1}',
        );

        cameraPoints.add(
          Point(
            coordinates: stopPosition,
          ),
        );
      }

      // ========================================================
      // FIT CAMERA
      // ========================================================

      if (cameraPoints.isNotEmpty) {

        final camera =
        await map.cameraForCoordinates(
          cameraPoints,

          MbxEdgeInsets(
            top: 80,
            left: 50,
            bottom: 50,
            right: 50,
          ),

          null,

          null,
        );

        await map.setCamera(camera);

        debugPrint(
          'Camera fitted to route',
        );
      }

      // ========================================================
      // MARK DATA AS LOADED
      //
      // IMPORTANT:
      // Only set this AFTER successful map update.
      // ========================================================

      _lastLoadedDataKey = key;

      debugPrint(
        'Journey map updated successfully',
      );

    } catch (e, stackTrace) {

      debugPrint(
        'Error updating Mapbox data: $e',
      );

      debugPrint(
        stackTrace.toString(),
      );

      // --------------------------------------------------------
      // IMPORTANT:
      // Don't set _lastLoadedDataKey here.
      // So next attempt can retry.
      // --------------------------------------------------------

    } finally {

      _isUpdatingMap = false;
    }
  }

  // ============================================================
  // START / END MARKER
  // ============================================================

  Future<void> _addStartEndMarker({
    required Position position,
    required String label,
    required Color color,
  }) async {

    final manager =
        _pointAnnotationManager;

    if (manager == null) return;

    await manager.create(
      PointAnnotationOptions(

        geometry: Point(
          coordinates: position,
        ),

        textField: label,

        textColor: color.value,

        textSize: 14.0,

        textOffset: [
          0.0,
          1.2,
        ],

        // Mapbox built-in marker
        iconImage: 'marker-15',

        iconColor: color.value,

        iconSize: 1.5,
      ),
    );
  }

  // ============================================================
  // NUMBERED STOPPAGE MARKER
  // ============================================================

  Future<void> _addNumberedMarker({
    required Position position,
    required String text,
  }) async {

    final manager =
        _pointAnnotationManager;

    if (manager == null) return;

    await manager.create(
      PointAnnotationOptions(

        geometry: Point(
          coordinates: position,
        ),

        textField: text,

        textColor: Colors.white.value,

        textSize: 12.0,

        textOffset: [
          0.0,
          0.0,
        ],

        iconImage: 'circle-15',

        iconColor: Colors.blue.value,

        iconSize: 1.5,
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
      height: 320,

      width: double.infinity,

      decoration:
      BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(
              0.05,
            ),

            blurRadius: 10,
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(16),

        child: MapWidget(
          key: const ValueKey(
            'employeeJourneyMap',
          ),

          styleUri:
          MapboxStyles.MAPBOX_STREETS,

          onMapCreated:
          _onMapCreated,

          onStyleLoadedListener:
          _onStyleLoaded,
        ),
      ),
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