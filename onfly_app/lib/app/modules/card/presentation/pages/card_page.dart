import 'package:flutter/material.dart';
import 'package:onfly_app/app/modules/card/presentation/pages/widgets/credit_card.dart';
import 'package:onfly_app/app/modules/card/presentation/pages/widgets/transaction_item.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Meu Cartão', style: OnflyTypography.titleLG),
            const SizedBox(height: 16),
            const CreditCard(
              cardNumber: '•••• •••• •••• 4242',
              cardholderName: 'JOHN DOE',
              expiryDate: '12/25',
              cardType: 'mastercard',
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Últimas Transações',
                      style: OnflyTypography.titleMD.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TransactionItem(
                      title: 'Restaurante Oliveira',
                      date: '15/11/2023',
                      amount: 'R\$ 125,00',
                    ),
                    const Divider(),
                    const TransactionItem(
                      title: 'Uber',
                      date: '14/11/2023',
                      amount: 'R\$ 87,50',
                    ),
                    const Divider(),
                    const TransactionItem(
                      title: 'Hotel Business Plaza',
                      date: '10/11/2023',
                      amount: 'R\$ 450,00',
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
}
