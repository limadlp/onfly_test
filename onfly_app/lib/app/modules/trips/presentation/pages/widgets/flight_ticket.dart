import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class FlightTicket extends StatelessWidget {
  final String flightNumber;
  final String airline;
  final String departureCode;
  final String departureCity;
  final String departureTime;
  final String arrivalCode;
  final String arrivalCity;
  final String arrivalTime;
  final String duration;
  final String date;
  final String gate;
  final bool isOutbound;

  const FlightTicket({
    super.key,
    required this.flightNumber,
    required this.airline,
    required this.departureCode,
    required this.departureCity,
    required this.departureTime,
    required this.arrivalCode,
    required this.arrivalCity,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.gate,
    required this.isOutbound,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(height: 2, color: OnflyColors.primary),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildFlightInfo(),
                const SizedBox(height: 24),
                _buildFlightDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: OnflyColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isOutbound ? Icons.flight_takeoff : Icons.flight_land,
                color: OnflyColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOutbound ? 'Voo de Ida' : 'Voo de Volta',
                  style: OnflyTypography.titleMD,
                ),
                Text(
                  'Confirmado',
                  style: OnflyTypography.bodyMD.copyWith(
                    color: OnflyColors.gray500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(flightNumber, style: OnflyTypography.titleMD),
            Text(
              airline,
              style: OnflyTypography.bodyMD.copyWith(
                color: OnflyColors.gray500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFlightInfo() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(departureCode, style: OnflyTypography.titleLG),
              const SizedBox(height: 4),
              Text(
                departureCity,
                style: OnflyTypography.bodyLG.copyWith(
                  color: OnflyColors.gray600,
                ),
              ),
              const SizedBox(height: 4),
              Text(departureTime, style: OnflyTypography.bodyLG),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Divider(thickness: 1, height: 1, indent: 20, endIndent: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  duration,
                  style: OnflyTypography.bodySM.copyWith(
                    color: OnflyColors.gray500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(arrivalCode, style: OnflyTypography.titleLG),
              const SizedBox(height: 4),
              Text(
                arrivalCity,
                style: OnflyTypography.bodyLG.copyWith(
                  color: OnflyColors.gray600,
                ),
              ),
              const SizedBox(height: 4),
              Text(arrivalTime, style: OnflyTypography.bodyLG),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFlightDetails() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 16,
              color: OnflyColors.gray500,
            ),
            const SizedBox(width: 8),
            Text(
              date,
              style: OnflyTypography.bodyLG.copyWith(
                color: OnflyColors.gray600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: OnflyColors.gray500),
            const SizedBox(width: 8),
            Text(
              gate,
              style: OnflyTypography.bodyLG.copyWith(
                color: OnflyColors.gray600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
