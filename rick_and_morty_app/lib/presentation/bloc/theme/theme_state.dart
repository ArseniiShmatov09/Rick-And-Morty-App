import 'dart:ui';
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  const ThemeState(this.brightness);

  final Brightness brightness;

  @override
  List<Object> get props => [brightness];
}
