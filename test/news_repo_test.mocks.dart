// Mocks generated by Mockito 5.0.15 from annotations
// in news_app/test/news_repo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:convert' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:postor/src/postor.dart' as _i3;
import 'package:postor/src/postor_file.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

class _FakeStreamedResponse_1 extends _i1.Fake implements _i2.StreamedResponse {
}

/// A class which mocks [Postor].
///
/// See the documentation for Mockito's code generation for more information.
class MockPostor extends _i1.Mock implements _i3.Postor {
  MockPostor() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl =>
      (super.noSuchMethod(Invocation.getter(#baseUrl), returnValue: '')
          as String);
  @override
  _i4.Future<_i2.Response> get(String? endpoint,
          {Map<String, dynamic>? parameters,
          Map<String, String>? headers,
          Duration? timeLimit,
          _i3.ResponseTimeoutCallback? onTimeout,
          _i2.Client? testClient}) =>
      (super.noSuchMethod(
              Invocation.method(#get, [
                endpoint
              ], {
                #parameters: parameters,
                #headers: headers,
                #timeLimit: timeLimit,
                #onTimeout: onTimeout,
                #testClient: testClient
              }),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> post(String? endpoint,
          {Map<String, dynamic>? parameters,
          Map<String, String>? headers,
          Object? body,
          _i5.Encoding? encoding,
          Duration? timeLimit,
          _i3.ResponseTimeoutCallback? onTimeout,
          _i2.Client? testClient}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [
                endpoint
              ], {
                #parameters: parameters,
                #headers: headers,
                #body: body,
                #encoding: encoding,
                #timeLimit: timeLimit,
                #onTimeout: onTimeout,
                #testClient: testClient
              }),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.Response> put(String? endpoint,
          {Map<String, dynamic>? parameters,
          Map<String, String>? headers,
          Object? body,
          _i5.Encoding? encoding,
          Duration? timeLimit,
          _i3.ResponseTimeoutCallback? onTimeout,
          _i2.Client? testClient}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [
                endpoint
              ], {
                #parameters: parameters,
                #headers: headers,
                #body: body,
                #encoding: encoding,
                #timeLimit: timeLimit,
                #onTimeout: onTimeout,
                #testClient: testClient
              }),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.StreamedResponse> send(_i2.BaseRequest? request,
          {Duration? timeLimit,
          _i3.StreamedResponseTimeoutCallback? onTimeout,
          void Function()? onCancel,
          _i2.Client? testClient}) =>
      (super.noSuchMethod(
              Invocation.method(#send, [
                request
              ], {
                #timeLimit: timeLimit,
                #onTimeout: onTimeout,
                #onCancel: onCancel,
                #testClient: testClient
              }),
              returnValue:
                  Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_1()))
          as _i4.Future<_i2.StreamedResponse>);
  @override
  _i4.Future<_i2.Response> multiPart(String? endpoint,
          {String? method = r'POST',
          Map<String, String>? fields,
          Map<String, _i6.PFile<Object>>? files,
          Duration? timeLimit,
          _i3.ResponseTimeoutCallback? onTimeout,
          _i2.Client? testClient}) =>
      (super.noSuchMethod(
              Invocation.method(#multiPart, [
                endpoint
              ], {
                #method: method,
                #fields: fields,
                #files: files,
                #timeLimit: timeLimit,
                #onTimeout: onTimeout,
                #testClient: testClient
              }),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  void cancel(String? url) =>
      super.noSuchMethod(Invocation.method(#cancel, [url]),
          returnValueForMissingStub: null);
  @override
  void cancelAll() => super.noSuchMethod(Invocation.method(#cancelAll, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
