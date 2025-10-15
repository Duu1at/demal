import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AvatarController {
  AvatarController({required this.vsync}) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addStatusListener(_animationStatusListener);
  }

  final TickerProvider vsync;
  late final AnimationController _animationController;
  OverlayEntry? overlayEntry;
  bool visible = true;
  GoRouter? _goRouter;
  VoidCallback? _onRemove;

  AnimationController get animationController => _animationController;

  void setRouterIfNeeded(
    BuildContext context,
    bool expand,
    VoidCallback routeListener,
  ) {
    if (_goRouter == null && expand) {
      _goRouter = GoRouter.of(context);
      _goRouter?.routerDelegate.addListener(routeListener);
    }
  }

  void removeRouterListener(VoidCallback routeListener) {
    if (_goRouter != null) {
      _goRouter?.routerDelegate.removeListener(routeListener);
      _goRouter = null;
    }
  }

  void attachRemoveCallback(VoidCallback onRemove) => _onRemove = onRemove;

  void _animationStatusListener(AnimationStatus status) async {
    if (status == AnimationStatus.reverse) {
      await Future.delayed(const Duration(milliseconds: 300));
      _removeOverlayInternal();
    }
  }

  void insertOverlay(BuildContext context, OverlayEntry entry) {
    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(entry);
    overlayEntry = entry;
  }

  void _removeOverlayInternal() {
    if (overlayEntry != null) {
      try {
        overlayEntry?.remove();
      } catch (_) {}
      overlayEntry = null;
      visible = true;
      _onRemove?.call();
    }
  }

  void removeOverlay() {
    _removeOverlayInternal();
  }

  void dispose(VoidCallback? routeListener) {
    _removeOverlayInternal();
    removeRouterListener(routeListener ?? () {});
    try {
      _animationController.removeStatusListener(_animationStatusListener);
      _animationController.dispose();
    } catch (_) {}
  }
}
