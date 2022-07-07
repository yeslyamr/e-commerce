// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$myPublicationsAtom =
      Atom(name: '_ProfileStore.myPublications', context: context);

  @override
  ObservableMap<DocumentReference<Object?>, Product> get myPublications {
    _$myPublicationsAtom.reportRead();
    return super.myPublications;
  }

  @override
  set myPublications(ObservableMap<DocumentReference<Object?>, Product> value) {
    _$myPublicationsAtom.reportWrite(value, super.myPublications, () {
      super.myPublications = value;
    });
  }

  late final _$deletePublicationAsyncAction =
      AsyncAction('_ProfileStore.deletePublication', context: context);

  @override
  Future<void> deletePublication({required DocumentReference<Object?> docRef}) {
    return _$deletePublicationAsyncAction
        .run(() => super.deletePublication(docRef: docRef));
  }

  late final _$fetchMyPublicationsAsyncAction =
      AsyncAction('_ProfileStore.fetchMyPublications', context: context);

  @override
  Future<void> fetchMyPublications() {
    return _$fetchMyPublicationsAsyncAction
        .run(() => super.fetchMyPublications());
  }

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void deleteAllPublication() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.deleteAllPublication');
    try {
      return super.deleteAllPublication();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
myPublications: ${myPublications}
    ''';
  }
}
