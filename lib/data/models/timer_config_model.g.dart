// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_config_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimerConfigModelCollection on Isar {
  IsarCollection<TimerConfigModel> get timerConfigModels => this.collection();
}

const TimerConfigModelSchema = CollectionSchema(
  name: r'TimerConfigModel',
  id: -3143617905640582829,
  properties: {
    r'breakMinutes': PropertySchema(
      id: 0,
      name: r'breakMinutes',
      type: IsarType.long,
    ),
    r'focusMinutes': PropertySchema(
      id: 1,
      name: r'focusMinutes',
      type: IsarType.long,
    ),
    r'isCustom': PropertySchema(
      id: 2,
      name: r'isCustom',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _timerConfigModelEstimateSize,
  serialize: _timerConfigModelSerialize,
  deserialize: _timerConfigModelDeserialize,
  deserializeProp: _timerConfigModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _timerConfigModelGetId,
  getLinks: _timerConfigModelGetLinks,
  attach: _timerConfigModelAttach,
  version: '3.1.0+1',
);

int _timerConfigModelEstimateSize(
  TimerConfigModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _timerConfigModelSerialize(
  TimerConfigModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.breakMinutes);
  writer.writeLong(offsets[1], object.focusMinutes);
  writer.writeBool(offsets[2], object.isCustom);
  writer.writeString(offsets[3], object.name);
}

TimerConfigModel _timerConfigModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimerConfigModel();
  object.breakMinutes = reader.readLong(offsets[0]);
  object.focusMinutes = reader.readLong(offsets[1]);
  object.id = id;
  object.isCustom = reader.readBool(offsets[2]);
  object.name = reader.readString(offsets[3]);
  return object;
}

P _timerConfigModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timerConfigModelGetId(TimerConfigModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timerConfigModelGetLinks(TimerConfigModel object) {
  return [];
}

void _timerConfigModelAttach(
    IsarCollection<dynamic> col, Id id, TimerConfigModel object) {
  object.id = id;
}

extension TimerConfigModelQueryWhereSort
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QWhere> {
  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }
}

extension TimerConfigModelQueryWhere
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QWhereClause> {
  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameStartsWith(String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterWhereClause>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }
}

extension TimerConfigModelQueryFilter
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QFilterCondition> {
  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      breakMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      breakMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      breakMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      breakMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breakMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      focusMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      focusMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'focusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      focusMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'focusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      focusMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'focusMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      isCustomEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCustom',
        value: value,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension TimerConfigModelQueryObject
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QFilterCondition> {}

extension TimerConfigModelQueryLinks
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QFilterCondition> {}

extension TimerConfigModelQuerySortBy
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QSortBy> {
  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusMinutes', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByFocusMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusMinutes', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TimerConfigModelQuerySortThenBy
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QSortThenBy> {
  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakMinutes', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusMinutes', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByFocusMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusMinutes', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByIsCustomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustom', Sort.desc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TimerConfigModelQueryWhereDistinct
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QDistinct> {
  QueryBuilder<TimerConfigModel, TimerConfigModel, QDistinct>
      distinctByBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakMinutes');
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QDistinct>
      distinctByFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'focusMinutes');
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QDistinct>
      distinctByIsCustom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustom');
    });
  }

  QueryBuilder<TimerConfigModel, TimerConfigModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension TimerConfigModelQueryProperty
    on QueryBuilder<TimerConfigModel, TimerConfigModel, QQueryProperty> {
  QueryBuilder<TimerConfigModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimerConfigModel, int, QQueryOperations> breakMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakMinutes');
    });
  }

  QueryBuilder<TimerConfigModel, int, QQueryOperations> focusMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'focusMinutes');
    });
  }

  QueryBuilder<TimerConfigModel, bool, QQueryOperations> isCustomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustom');
    });
  }

  QueryBuilder<TimerConfigModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
