import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:keyboard_attachable/src/controller/keyboard_attachable_controller.dart';

class IOSAttachableController implements KeyboardAttachableController {
  IOSAttachableController({@required TickerProvider vsync})
      : _spring = const SpringDescription(mass: 8, stiffness: 1, damping: 4.5),
        _springVelocity = 10 {
    _controller = AnimationController(vsync: vsync);
  }

  final SpringDescription _spring;
  final double _springVelocity;
  AnimationController _controller;

  @override
  Animation<double> get animation => _controller;

  @override
  TickerFuture forward() {
    final forwardSimulation = SpringSimulation(_spring, 0, 1, _springVelocity);
    return _controller.animateWith(forwardSimulation);
  }

  @override
  TickerFuture reverse() {
    final reverseSimulation = SpringSimulation(_spring, 1, 0, -_springVelocity);
    return _controller.animateWith(reverseSimulation);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
  }
}
