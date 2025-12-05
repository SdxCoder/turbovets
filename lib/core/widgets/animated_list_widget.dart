import 'package:flutter/material.dart';

class AnimatedListWidget<T> extends StatefulWidget {
  const AnimatedListWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.keyExtractor,
    this.reverse = false,
    this.padding,
    this.controller,
    this.animationDuration = const Duration(milliseconds: 500),
    this.slideOffset = const Offset(0, 0.5),
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String Function(T item) keyExtractor;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final Duration animationDuration;
  final Offset slideOffset;

  @override
  State<AnimatedListWidget<T>> createState() => _AnimatedListWidgetState<T>();
}

class _AnimatedListWidgetState<T> extends State<AnimatedListWidget<T>> {
  final Set<String> _seenItemKeys = {};
  List<T> _previousItems = [];

  @override
  void initState() {
    super.initState();
    _previousItems = List.from(widget.items);
    for (final item in widget.items) {
      _seenItemKeys.add(widget.keyExtractor(item));
    }
  }

  @override
  void didUpdateWidget(AnimatedListWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final previousKeys = _previousItems.map(widget.keyExtractor).toSet();
    final currentKeys = widget.items.map(widget.keyExtractor).toSet();
    final newKeys = currentKeys.difference(previousKeys);

    if (newKeys.isNotEmpty) {
      for (final key in newKeys) {
        Future.delayed(widget.animationDuration, () {
          if (mounted) {
            setState(() {
              _seenItemKeys.add(key);
            });
          }
        });
      }

      if (widget.controller != null && widget.controller!.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.controller!.hasClients) {
            widget.controller!.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
            );
          }
        });
      }
    }

    _previousItems = List.from(widget.items);
  }

  bool _isNewItem(T item) {
    final key = widget.keyExtractor(item);
    return !_seenItemKeys.contains(key);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
      reverse: widget.reverse,
      padding: widget.padding,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.reverse
            ? widget.items[widget.items.length - 1 - index]
            : widget.items[index];
        final isNew = _isNewItem(item);

        final child = widget.itemBuilder(context, item, index);

        if (isNew) {
          return _AnimatedListItem(
            key: ValueKey(widget.keyExtractor(item)),
            animationDuration: widget.animationDuration,
            slideOffset: widget.slideOffset,
            child: child,
          );
        }

        return child;
      },
    );
  }
}

class _AnimatedListItem extends StatefulWidget {
  const _AnimatedListItem({
    super.key,
    required this.child,
    required this.animationDuration,
    required this.slideOffset,
  });

  final Widget child;
  final Duration animationDuration;
  final Offset slideOffset;

  @override
  State<_AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<_AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _slideAnimation, child: widget.child);
  }
}
