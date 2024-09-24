import 'package:rick_and_morty_app/data/entities/api_info.dart';
import 'package:rick_and_morty_app/domain/models/api_info_model.dart';

class  ApiInfoMapper  {
  ApiInfoModel toModel (ApiInfoEntity entity) => ApiInfoModel (
    count: entity.count,
    pages: entity.pages,
    next: entity.next,
    prev: entity.prev,
  );

  ApiInfoEntity fromModel (ApiInfoModel model) => ApiInfoEntity (
    count: model.count,
    pages: model.pages,
    next: model.next,
    prev: model.prev,
  );
}