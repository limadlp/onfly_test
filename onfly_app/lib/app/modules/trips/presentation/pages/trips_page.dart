import 'package:flutter/material.dart';
import 'package:onfly_app/app/modules/trips/presentation/pages/widgets/flight_ticket.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Minhas Viagens', style: OnflyTypography.titleLG),
            const SizedBox(height: 16),
            const FlightTicket(
              flightNumber: 'LA 3477',
              airline: 'LATAM',
              departureCode: 'GRU',
              departureCity: 'São Paulo',
              departureTime: '08:00',
              arrivalCode: 'SDU',
              arrivalCity: 'Rio de Janeiro',
              arrivalTime: '09:45',
              duration: '1h 45m',
              date: 'Quinta-feira, 25 de Novembro de 2025',
              gate: 'Terminal 2 • Portão 15 • Assento 14A',
              isOutbound: true,
            ),
            const SizedBox(height: 16),
            const FlightTicket(
              flightNumber: 'LA 3590',
              airline: 'LATAM',
              departureCode: 'SDU',
              departureCity: 'Rio de Janeiro',
              departureTime: '19:30',
              arrivalCode: 'GRU',
              arrivalCity: 'São Paulo',
              arrivalTime: '21:20',
              duration: '1h 50m',
              date: 'Domingo, 28 de Novembro de 2025',
              gate: 'Terminal 1 • Portão 8 • Assento 22C',
              isOutbound: false,
            ),
          ],
        ),
      ),
    );
  }
}
