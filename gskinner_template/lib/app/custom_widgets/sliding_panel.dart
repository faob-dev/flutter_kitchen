import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SlidingPanel extends SingleChildRenderObjectWidget {
  SlidingPanel({
    Key key,
    @required this.child,
  }) : super(key: key, child: child);

  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SlidingPanelRender(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, SlidingPanelRender renderObject) {
    renderObject..scrollable = Scrollable.of(context);
  }
}

class SlidingPanelRender extends RenderShiftedBox {
  SlidingPanelRender({
    @required ScrollableState scrollable,
    RenderBox child,
  })  : assert(scrollable != null),
        _scrollable = scrollable,
        super(child);

  ScrollableState _scrollable;

  set scrollable(ScrollableState val) {
    assert(val != null);
    if (val == _scrollable) {
      return;
    }

    if (attached) {
      _scrollable.position?.removeListener(markNeedsLayout);
      val.position?.addListener(markNeedsLayout);
    }

    _scrollable = val;
    markNeedsLayout();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position?.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position?.removeListener(markNeedsLayout);
    super.detach();
  }

  RenderObject _scrollBox;

  RenderObject get scrollBox {
    if (_scrollBox == null) {
      _scrollBox = _scrollable.context.findRenderObject();
    }
    return _scrollBox;
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BoxParentData) child.parentData = BoxParentData();
  }

  @override
  void performLayout() {
    child.layout(constraints.loosen(), parentUsesSize: true);

    double parentHeight = constraints.maxHeight;
    double childHeight = child.size.height;

    assert(parentHeight >= childHeight);

    double remainingExtent = parentHeight - childHeight;
    double localScrollOffset =
        localToGlobal(Offset.zero, ancestor: scrollBox).dy;

    double childOffsetX = 0.0;
    double childOffsetY = max(
      0.0,
      min(remainingExtent,
          max(-localScrollOffset, -localScrollOffset + remainingExtent)),
    );

    final childParentData = child.parentData as BoxParentData;
    childParentData.offset = Offset(childOffsetX, childOffsetY);

    size = constraints.biggest;
  }
}
