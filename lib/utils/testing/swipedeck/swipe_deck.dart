import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hidden_city/utils/testing/swipedeck/data_holder.dart';

class SwipeDeck extends StatefulWidget {
  final List<Widget> widgets;
  final int startIndex;
  final Widget emptyIndicator;
  final double aspectRatio, cardSpreadInDegrees;
  final Function(int)? onChange;
  final Function? onSwipeRight, onSwipeLeft;

  const SwipeDeck(
      {Key? key,
      required this.widgets,
      this.startIndex = 0,
      this.emptyIndicator = const _NothingHere(),
      this.aspectRatio = 4 / 3,
      this.onChange,
      this.cardSpreadInDegrees = 5.0,
      this.onSwipeRight,
      this.onSwipeLeft})
      : super(key: key);

  @override
  State<SwipeDeck> createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck> {
  final borderRadius = BorderRadius.circular(20.0);
  List<Widget> leftStackRaw = [], rightStackRaw = [];
  Widget? currentWidget, contestantImage, removedImage;
  bool draggingLeft = false, onHold = false, beginDrag = false;
  double transformLevel = 0,
      removeTransformLevel = 0,
      spreadInRadians = defaultSpread;
  Timer? stackTimer, repositionTimer;

  @override
  void dispose() {
    super.dispose();
    stackTimer?.cancel();
    repositionTimer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    if (widget.widgets.isEmpty) {
      return;
    }
    spreadInRadians = widget.cardSpreadInDegrees.clamp(2.0, 10.0) * (pi / 180);
    debugPrint(widget.widgets.length.toString());
    leftStackRaw = widget.widgets.sublist(0, widget.startIndex);
    rightStackRaw =
        widget.widgets.sublist(widget.startIndex + 1, widget.widgets.length);

    currentWidget = widget.widgets[widget.startIndex];
  }

  refreshLHStacks() {
    if (stackTimer != null && stackTimer!.isActive) {
      return;
    }
    onHold = true;
    removeTransformLevel = transformLevel;
    transformLevel = 0;
    double part = removeTransformLevel / 50;
    stackTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (removeTransformLevel >= part) {
        removeTransformLevel -= part;
        setState(() {});
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      stackTimer!.cancel();
      removedImage = const Center();
      removeTransformLevel = max(removeTransformLevel, 0);
      setState(() {
        onHold = false;
      });
    });
  }

  returnToPosition() {
    if (repositionTimer != null && repositionTimer!.isActive) {
      return;
    }
    onHold = true;
    double part = transformLevel / 10;
    repositionTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (transformLevel >= part) {
        transformLevel -= part;
      }
      setState(() {
        contestantImage = const Center();
      });
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      repositionTimer?.cancel();
      transformLevel = max(transformLevel, 0);
      setState(() {
        onHold = false;
        contestantImage = const Center();
      });
    });
  }

  wrapWithContainer(Widget widget, width, height) {
    return SizedBox(
      width: width,
      height: height,
      child: widget,
    );
  }

  postOnChange(index) {
    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          TransformData(spreadRadians: spreadInRadians),
      child: LayoutBuilder(builder: (context, constraints) {
        final imageWidth = constraints.maxWidth / 2;
        final imageHeight = widget.aspectRatio * imageWidth;
        final double centerWidth = constraints.maxWidth / 2;
        if (widget.widgets.isEmpty) {
          return widget.emptyIndicator;
        }
        return GestureDetector(
          onPanDown: (downDetails) {
            if ((centerWidth - downDetails.localPosition.dx).abs() < 50) {
              beginDrag = true;
              setState(() {});
            }
          },
          onPanEnd: (panEnd) {
            beginDrag = false;
            returnToPosition();
          },
          onPanUpdate: (panDetails) {
            if (onHold || currentWidget == null || !beginDrag) {
              return;
            }
            draggingLeft = (centerWidth) > panDetails.localPosition.dx;

            if ((draggingLeft && rightStackRaw.isEmpty) ||
                (!draggingLeft && leftStackRaw.isEmpty)) {
              return;
            }

            transformLevel =
                (centerWidth - panDetails.localPosition.dx).abs() / centerWidth;
            context.read<TransformData>().setTransformDelta(transformLevel);
            context.read<TransformData>().setLeftDrag(draggingLeft);

            bool changed = false;
            if (transformLevel > 0.8) {
              removedImage = currentWidget;
              if (draggingLeft) {
                if (rightStackRaw.isEmpty) {
                  return;
                }

                leftStackRaw.insert(0, currentWidget!);
                currentWidget = rightStackRaw.first;
                rightStackRaw.removeAt(0);

                changed = true;
                if (rightStackRaw.isNotEmpty) {
                  contestantImage = rightStackRaw.last;
                }
              } else {
                if (leftStackRaw.isEmpty) {
                  return;
                }

                rightStackRaw.add(currentWidget!);
                currentWidget = leftStackRaw.last;
                leftStackRaw.removeLast();

                changed = true;
                if (leftStackRaw.isNotEmpty) {
                  contestantImage = leftStackRaw.first;
                }
              }
              if (changed) {
                draggingLeft
                    ? widget.onSwipeLeft?.call()
                    : widget.onSwipeRight?.call();
                postOnChange(rightStackRaw.length);
              }
              refreshLHStacks();
            }
            setState(() {});
          },
          child: Center(
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(
                      removeTransformLevel * (draggingLeft ? -90 : 90), 0),
                  child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.rotationZ(
                          removeTransformLevel * (draggingLeft ? -0.5 : 0.5)),
                      child: SizedBox(
                          width: imageWidth,
                          height: imageHeight,
                          child: removedImage ?? const Center())),
                ),
                if (draggingLeft && beginDrag)
                  for (int i = 0; i < leftStackRaw.length; i++)
                    _WidgetHolder(
                      width: imageWidth,
                      height: imageHeight,
                      image: leftStackRaw[i],
                      index: i,
                      isLeft: true,
                      lastIndex: leftStackRaw.length,
                    ),
                for (int i = 0; i < rightStackRaw.length; i++)
                  _WidgetHolder(
                    width: imageWidth,
                    height: imageHeight,
                    image: rightStackRaw[rightStackRaw.length - 1 - i],
                    index: i,
                    isLeft: false,
                    lastIndex: rightStackRaw.length,
                  ),
                if (!draggingLeft || !beginDrag)
                  for (int i = 0; i < leftStackRaw.length; i++)
                    _WidgetHolder(
                      width: imageWidth,
                      height: imageHeight,
                      image: leftStackRaw[i],
                      index: i,
                      isLeft: true,
                      lastIndex: leftStackRaw.length,
                    ),
                if (currentWidget != null) ...[
                  Transform.translate(
                    offset:
                        Offset(transformLevel * (draggingLeft ? -90 : 90), 0),
                    child: Transform.scale(
                      scale: max(0.8, (1 - transformLevel + 0.2)),
                      alignment: Alignment.center,
                      child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.rotationZ(
                              transformLevel * (draggingLeft ? -0.5 : 0.5)),
                          child: Container(
                            width: imageWidth,
                            height: imageHeight,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.2))
                            ], borderRadius: borderRadius),
                            child: currentWidget,
                          )),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _WidgetHolder extends StatefulWidget {
  final double width, height;
  final Widget image;
  final int index;
  final bool isLeft;
  final int lastIndex;

  const _WidgetHolder(
      {Key? key,
      required this.width,
      required this.height,
      required this.image,
      required this.index,
      this.isLeft = true,
      this.lastIndex = 0})
      : super(key: key);

  @override
  _WidgetHolderState createState() => _WidgetHolderState();
}

class _WidgetHolderState extends State<_WidgetHolder> {
  late Widget childImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    childImage = SizedBox(
        width: widget.width, height: widget.height, child: widget.image);
    TransformData transformData = context.watch<TransformData>();
    double spread = transformData.spreadRadians;
    double finalRotation = (widget.index <= widget.lastIndex - 3)
        ? (3 * spread)
        : ((widget.lastIndex - widget.index) * spread);
    bool isLeft = transformData.isLeftDrag;
    double scaleDifferential = 0.05 * transformData.transformDelta;
    return Transform.scale(
      scale: isLeft
          ? (widget.isLeft ? (1 - scaleDifferential) : 1 + scaleDifferential)
          : (widget.isLeft ? 1 + scaleDifferential : (1 - scaleDifferential)),
      child: Transform(
          alignment: Alignment.bottomCenter,
          transform:
              Matrix4.rotationZ(widget.isLeft ? -finalRotation : finalRotation),
          child: childImage),
    );
  }
}

class _NothingHere extends StatefulWidget {
  const _NothingHere({Key? key}) : super(key: key);

  @override
  __NothingHereState createState() => __NothingHereState();
}

class __NothingHereState extends State<_NothingHere> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Nothing Here!"),
    );
  }
}
