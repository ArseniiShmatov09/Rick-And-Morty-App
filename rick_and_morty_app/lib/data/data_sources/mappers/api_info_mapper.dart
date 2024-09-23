import 'package:rick_and_morty_app/data/dto/api_info.dart';
import 'package:rick_and_morty_app/domain/entities/api_info_entity.dart';

class  ApiInfoMapper  {
  ApiInfoEntity toEntity (ApiInfoDTO dto) => ApiInfoEntity (
    count: dto.count,
    pages: dto.pages,
    next: dto.next,
    prev: dto.prev,
  );

  ApiInfoDTO fromEntity (ApiInfoEntity entity) => ApiInfoDTO (
    count: entity.count,
    pages: entity.pages,
    next: entity.next,
    prev: entity.prev,
  );
}