import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';

void main() {
  group('ApiInfoModel', () {
    test('should create with required fields', () {
      final model = ApiInfoModel(count: 20, pages: 2);

      expect(model.count, 20);
      expect(model.pages, 2);
      expect(model.next, '');
      expect(model.prev, '');
    });

    test('props should contain all fields', () {
      final model = ApiInfoModel(count: 20, pages: 2, next: 'nextUrl', prev: 'prevUrl');
      expect(model.props, [20, 2, 'nextUrl', 'prevUrl']);
    });
  });
}
