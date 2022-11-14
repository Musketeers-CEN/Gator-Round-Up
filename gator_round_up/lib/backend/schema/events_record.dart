import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @BuiltValueField(wireName: 'EventTitle')
  String? get eventTitle;

  @BuiltValueField(wireName: 'EventDate')
  DateTime? get eventDate;

  @BuiltValueField(wireName: 'Users')
  BuiltList<DocumentReference>? get users;

  @BuiltValueField(wireName: 'EventSummary')
  String? get eventSummary;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..eventTitle = ''
    ..users = ListBuilder()
    ..eventSummary = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  EventsRecord._();
  factory EventsRecord([void Function(EventsRecordBuilder) updates]) =
      _$EventsRecord;

  static EventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createEventsRecordData({
  String? eventTitle,
  DateTime? eventDate,
  String? eventSummary,
}) {
  final firestoreData = serializers.toFirestore(
    EventsRecord.serializer,
    EventsRecord(
      (e) => e
        ..eventTitle = eventTitle
        ..eventDate = eventDate
        ..users = null
        ..eventSummary = eventSummary,
    ),
  );

  return firestoreData;
}
