import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:valdir_finance/src/resources/repository.dart';
import 'package:valdir_finance/src/utils/validator.dart';
import 'package:valdir_finance/src/utils/values/strings.dart';

import '../bloc.dart';

class AuthenticationBloc implements Bloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _displayName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();

  // get data
  Observable<String> get email => _email.stream.transform(_validateEmail);
  Observable<String> get displayName => _email.stream.transform(_validateDisplayName);
  Observable<String> get password => _email.stream.transform(_validatePassword);
  Observable<bool>   get signInStatus => _isSignedIn.stream;

  // change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeDisplayName => _displayName.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(bool)   get showProgressBar => _isSignedIn.sink.add;

  final _validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    // validate email
    if(Validator.validateEmail(email)) {
      sink.add(email);
    } else {
      sink.addError(StringConstants.emailValidateMessage);
    }
  });

  final _validateDisplayName = StreamTransformer<String, String>.fromHandlers(handleData: (displayName, sink) {
    // validate email
    if(Validator.validateDisplayName(displayName)) {
      sink.add(displayName);
    } else {
      sink.addError(StringConstants.displayNameValidateMessage);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    // validate email
    if(Validator.validatePassword(password)) {
      sink.add(password);
    } else {
      sink.addError(StringConstants.passwordValidateMessage);
    }
  });

  bool validateEmailAndPassword() {
    if(_email.value != null &&
      _email.value.isNotEmpty &&
      Validator.validateEmail(_email.value) &&
      _password.value != null &&
      _password.value.isNotEmpty &&
      Validator.validatePassword(_password.value)) {
      return true;
    }
    return false;
  }

  bool validateDisplayName() {
    return _displayName.value != null && _displayName.value.isNotEmpty && Validator.validateDisplayName(_displayName.value);
  }

  // firebase methods
  Future<int> loginUser() async {
    showProgressBar(true);
    int response = await _repository.loginWithEmailAndPassword(_email.value, _password.value);
    showProgressBar(false);
    return response;
  }

  Future<int> registerUser() async {
    showProgressBar(true);
    int response = await _repository.signUpWithEmailAndPassword(_email.value, _password.value, _displayName.value);
    showProgressBar(false);
    return response;
  }

  @override
  void dispose() async {
    await _email.drain();
    _email.close();
    await _displayName.drain();
    _displayName.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
  }

}