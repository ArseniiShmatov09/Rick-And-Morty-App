import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/data/entities/api_info.dart';
import 'package:rick_and_morty_app/data/data_sources/mappers/api_info_mapper.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';

void main() {
  final mapper = ApiInfoMapper();

  test('should map ApiInfoEntity -> ApiInfoModel', () {
    final entity = ApiInfoEntity(count: 10, pages: 2, next: 'next', prev: 'prev');

    final model = mapper.toModel(entity);

    expect(model.count, 10);
    expect(model.pages, 2);
    expect(model.next, 'next');
    expect(model.prev, 'prev');
  });

  test('should map ApiInfoModel -> ApiInfoEntity', () {
    final model = ApiInfoModel(count: 5, pages: 1, next: null, prev: null);

    final entity = mapper.fromModel(model);

    expect(entity.count, 5);
    expect(entity.pages, 1);
    expect(entity.next, isNull);
    expect(entity.prev, isNull);
  });
}
