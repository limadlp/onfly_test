import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class CreditCard extends StatelessWidget {
  final String cardNumber;
  final String cardholderName;
  final String expiryDate;
  final String cardType;

  const CreditCard({
    super.key,
    required this.cardNumber,
    required this.cardholderName,
    required this.expiryDate,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.586, // Proporção padrão de um cartão de crédito
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [OnflyColors.secondary, OnflyColors.primary],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cartão Corporativo',
                    style: OnflyTypography.subtitleSM.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  _buildCardLogo(cardType),
                ],
              ),
              const Spacer(),
              Text(
                cardNumber,
                style: OnflyTypography.titleLG.copyWith(
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TITULAR',
                        style: OnflyTypography.subtitleSM.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cardholderName,
                        style: OnflyTypography.bodyLG.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VALIDADE',
                        style: OnflyTypography.subtitleSM.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        expiryDate,
                        style: OnflyTypography.bodyLG.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardLogo(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return Text(
          'VISA',
          style: OnflyTypography.titleMD.copyWith(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        );
      case 'mastercard':
        return SizedBox(
          width: 40,
          height: 24,
          child: Stack(
            children: [
              Positioned(left: 0, child: _buildCircle(const Color(0xFFEB001B))),
              Positioned(
                right: 0,
                child: _buildCircle(const Color(0xFFF79E1B)),
              ),
              Positioned(
                left: 8,
                child: _buildCircle(Colors.deepOrange.withValues(alpha: 0.7)),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
