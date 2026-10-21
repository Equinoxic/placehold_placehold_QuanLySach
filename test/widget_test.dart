import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ql_book_flutter/main.dart';

void main() {
  testWidgets('login and manage books', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Chào mừng trở lại'), findsOneWidget);
    final loginFields = find.byType(TextFormField);
    await tester.enterText(loginFields.at(0), 'wrong');
    await tester.enterText(loginFields.at(1), 'credentials');
    await tester.tap(find.text('Đăng nhập'));
    await tester.pumpAndSettle();
    expect(find.text('Sai tên đăng nhập hoặc mật khẩu'), findsOneWidget);

    await tester.enterText(loginFields.at(0), 'admin');
    await tester.enterText(loginFields.at(1), '123456');
    await tester.tap(find.text('Đăng nhập'));
    await tester.pumpAndSettle();
    expect(find.text('Tủ sách của tôi'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.text('Thêm sách'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Tên sách'),
      'Flutter thực hành',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Tác giả'),
      'Linh Nguyễn',
    );
    await tester.scrollUntilVisible(
      find.text('Lưu sách'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Lưu sách'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Flutter thực hành'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    await tester.tap(find.text('Flutter thực hành'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Đánh dấu đã đọc'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Đánh dấu đã đọc'));
    await tester.pumpAndSettle();
    expect(find.text('Đã đọc'), findsOneWidget);
    expect(find.text('Đánh dấu đã đọc'), findsNothing);

    await tester.tap(find.text('Xóa sách'));
    await tester.pumpAndSettle();
    expect(
      find.text('Bạn có chắc chắn muốn xóa cuốn sách này khỏi tủ sách?'),
      findsOneWidget,
    );
    await tester.tap(find.text('Xóa sách').last);
    await tester.pumpAndSettle();
    expect(find.text('Flutter thực hành'), findsNothing);
    expect(find.text('3'), findsOneWidget);
  });
}
