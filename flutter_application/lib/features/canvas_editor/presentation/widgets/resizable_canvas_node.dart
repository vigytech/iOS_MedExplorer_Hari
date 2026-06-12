import 'package:flutter/material.dart';
import '../../domain/canvas_node.dart';
import '../../../../core/theme/app_theme.dart';

/// Resizable, draggable canvas node widget.
/// Dumb StatefulWidget with local ValueNotifiers for 120Hz gesture safety.
/// Per canvas-interaction-rules.md §2: continuous gesture mutations happen
/// on local ValueNotifiers. Global Riverpod state is updated only on gesture end.
class ResizableCanvasNode extends StatefulWidget {
  final CanvasNode node;
  final Size canvasSize;
  final ValueChanged<({double normX, double normY})> onPositionChanged;
  final ValueChanged<({double widthRatio, double heightRatio})> onSizeChanged;
  final VoidCallback onRemove;
  final bool isManipulateMode;

  const ResizableCanvasNode({
    super.key,
    required this.node,
    required this.canvasSize,
    required this.onPositionChanged,
    required this.onSizeChanged,
    required this.onRemove,
    required this.isManipulateMode,
  });

  @override
  State<ResizableCanvasNode> createState() => _ResizableCanvasNodeState();
}

class _ResizableCanvasNodeState extends State<ResizableCanvasNode> {
  late ValueNotifier<Offset> _position;
  late ValueNotifier<Size> _size;
  bool _isSelected = false;

  static const double _handleSize = 12.0;

  @override
  void initState() {
    super.initState();
    _position = ValueNotifier(Offset(
      widget.node.normalizedX,
      widget.node.normalizedY,
    ));
    _size = ValueNotifier(Size(
      widget.node.widthRatio,
      widget.node.heightRatio,
    ));
  }

  @override
  void didUpdateWidget(ResizableCanvasNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node != widget.node) {
      _position.value = Offset(
        widget.node.normalizedX,
        widget.node.normalizedY,
      );
      _size.value = Size(
        widget.node.widthRatio,
        widget.node.heightRatio,
      );
    }
  }

  @override
  void dispose() {
    _position.dispose();
    _size.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: _position,
      builder: (context, pos, _) {
        return ValueListenableBuilder<Size>(
          valueListenable: _size,
          builder: (context, size, _) {
            final left = pos.dx * widget.canvasSize.width;
            final top = pos.dy * widget.canvasSize.height;
            final width = size.width * widget.canvasSize.width;
            final height = size.height * widget.canvasSize.height;

            return Positioned(
              left: left,
              top: top,
              width: width + (_isSelected ? _handleSize : 0),
              height: height + (_isSelected ? _handleSize : 0),
              child: GestureDetector(
                onTap: widget.isManipulateMode
                    ? () => setState(() => _isSelected = !_isSelected)
                    : null,
                onLongPress: widget.isManipulateMode
                    ? () => _showContextMenu(context)
                    : null,
                onPanUpdate: widget.isManipulateMode && _isSelected
                    ? (details) {
                        final dx =
                            details.delta.dx / widget.canvasSize.width;
                        final dy =
                            details.delta.dy / widget.canvasSize.height;
                        _position.value = Offset(
                          (_position.value.dx + dx)
                              .clamp(0.0, 1.0 - _size.value.width),
                          (_position.value.dy + dy)
                              .clamp(0.0, 1.0 - _size.value.height),
                        );
                      }
                    : null,
                onPanEnd: widget.isManipulateMode && _isSelected
                    ? (_) {
                        widget.onPositionChanged((
                          normX: _position.value.dx,
                          normY: _position.value.dy,
                        ));
                      }
                    : null,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Device image
                    Positioned(
                      left: 0,
                      top: 0,
                      width: width,
                      height: height,
                      child: Container(
                        decoration: _isSelected && widget.isManipulateMode
                            ? BoxDecoration(
                                border: Border.all(
                                  color: AppTheme.accent,
                                  width: 2,
                                ),
                              )
                            : null,
                        child: Image.asset(
                          widget.node.realisticAssetPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Resize handles (only in manipulate mode + selected)
                    if (_isSelected && widget.isManipulateMode) ...[
                      // Bottom-right corner handle
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            final dw =
                                details.delta.dx / widget.canvasSize.width;
                            final dh =
                                details.delta.dy / widget.canvasSize.height;
                            _size.value = Size(
                              (_size.value.width + dw).clamp(0.03, 0.5),
                              (_size.value.height + dh).clamp(0.03, 0.5),
                            );
                          },
                          onPanEnd: (_) {
                            widget.onSizeChanged((
                              widthRatio: _size.value.width,
                              heightRatio: _size.value.height,
                            ));
                          },
                          child: Container(
                            width: _handleSize,
                            height: _handleSize,
                            decoration: BoxDecoration(
                              color: AppTheme.accent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showContextMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Device'),
        content: const Text('Remove this device from the canvas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              widget.onRemove();
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: AppTheme.danger),
            ),
          ),
        ],
      ),
    );
  }
}
