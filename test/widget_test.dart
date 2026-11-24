
import 'package:flutter_test/flutter_test.dart';
import 'package:bilimhub/app/bilimhub_app.dart';

void main() {
  testWidgets('BilimHub bosh sahifasi ochiladi', (WidgetTester tester) async {
    await tester.pumpWidget(const BilimHubApp());

    expect(find.text('BilimHub'), findsOneWidget);
    expect(find.text('Bosh sahifa'), findsOneWidget);
    expect(find.text('Kashfiyot'), findsOneWidget);
    expect(find.text('Hamjamiyat'), findsOneWidget);
  });
}
