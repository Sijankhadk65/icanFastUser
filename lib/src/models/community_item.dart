import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'community_item.g.dart';

abstract class CommunityItem
    implements Built<CommunityItem, CommunityItemBuilder> {
  @nullable
  String get title;
  @nullable
  String get city;
  @nullable
  String get closeTime;
  @nullable
  String get description;
  @nullable
  String get photoURI;
  @nullable
  String get physicalLocation;

  CommunityItem._();
  factory CommunityItem([updates(CommunityItemBuilder b)]) = _$CommunityItem;

  static Serializer<CommunityItem> get serializer => _$communityItemSerializer;

  Map<String, dynamic> toNewCommunityItemJson() => {
        "title": this.title,
        "city": this.city,
        "closeTime": this.closeTime,
        "description": this.description,
        "photoURI": this.photoURI,
        "physicalLocation": this.physicalLocation
      };
}

CommunityItem parseToCommunityItemModel(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(CommunityItem.serializer, json);
}
