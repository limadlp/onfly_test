import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';
import 'package:onfly_app/app/core/extensions/number_formatter.dart';

class ExpensesChart extends StatefulWidget {
  final Map<String, double> expensesByCategory;

  const ExpensesChart({super.key, required this.expensesByCategory});

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  late final List<Map<String, dynamic>> _chartData;
  int touchedIndex = -1;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  // Use exatamente as 4 cores desejadas
  final List<Color> _palette = [
    OnflyColors.primary,
    OnflyColors.secondary,
    OnflyColors.success,
    OnflyColors.warning,
  ];

  @override
  void initState() {
    super.initState();
    _chartData = _createChartData(widget.expensesByCategory);
  }

  List<Map<String, dynamic>> _createChartData(Map<String, double> data) {
    if (data.isEmpty) return [];

    final total = data.values.fold(0.0, (sum, e) => sum + e);
    final chartData = <Map<String, dynamic>>[];

    int colorIndex = 0;
    data.forEach((category, amount) {
      final percentage = amount / total * 100;
      chartData.add({
        'category': category,
        'value': amount,
        'percentage': percentage,
        'color': _palette[colorIndex % _palette.length],
      });
      colorIndex++;
    });

    return chartData;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chartData.isEmpty) {
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            borderData: FlBorderData(show: false),
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    _removeOverlay();
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;

                  if (touchedIndex < 0 || touchedIndex >= _chartData.length) {
                    touchedIndex = -1;
                    _removeOverlay();
                    return;
                  }

                  final category =
                      _chartData[touchedIndex]['category'] as String;
                  final amount = (_chartData[touchedIndex]['value']).toString();

                  final renderBox = context.findRenderObject() as RenderBox;
                  final position = renderBox.localToGlobal(Offset.zero);

                  _showOverlay(
                    context,
                    category,
                    amount,
                    Offset(
                      position.dx + renderBox.size.width / 2,
                      position.dy + renderBox.size.height / 2,
                    ),
                  );
                });
              },
            ),
            sections: _showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(_chartData.length, (i) {
      final isTouched = (i == touchedIndex);
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final percentage = _chartData[i]['percentage'] as double;
      final color = _chartData[i]['color'] as Color;

      return PieChartSectionData(
        color: color,
        value: percentage,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }

  void _showOverlay(
    BuildContext context,
    String category,
    String value,
    Offset position,
  ) {
    _removeOverlay();
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: position.dx,
            top: position.dy,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      double.parse(value).toBRL(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
