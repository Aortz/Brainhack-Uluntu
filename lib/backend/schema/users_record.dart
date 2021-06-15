import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..displayName = ''
    ..email = ''
    ..phoneNumber = ''
    ..photoUrl = ''
    ..uid = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;
}

Map<String, dynamic> createUsersRecordData({
  DateTime createdTime,
  String displayName,
  String email,
  String phoneNumber,
  String photoUrl,
  String uid,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..createdTime = createdTime
          ..displayName = displayName
          ..email = email
          ..phoneNumber = phoneNumber
          ..photoUrl = photoUrl
          ..uid = uid));

UsersRecord get dummyUsersRecord {
  final builder = UsersRecordBuilder()
    ..createdTime = dummyTimestamp
    ..displayName = dummyString
    ..email = dummyString
    ..phoneNumber = dummyString
    ..photoUrl = dummyImagePath
    ..uid = dummyString;
  return builder.build();
}

List<UsersRecord> createDummyUsersRecord({int count}) =>
    List.generate(count, (_) => dummyUsersRecord);
