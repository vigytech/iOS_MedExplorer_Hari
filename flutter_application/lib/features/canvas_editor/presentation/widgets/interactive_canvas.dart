import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/canvas_state_provider.dart';
import '../../../../shared/domain/shared_entities.dart';

class InteractiveCanvas extends HookConsumerWidget {
  final String backgroundAssetPath;
  final bool panEnabled;
  final bool scaleEnabled;
  final GlobalKey canvasBoundaryKey;
  final Widget? overlay;

  const InteractiveCanvas({
    super.key,
    required this.backgroundAssetPath,
    required this.canvasBoundaryKey,
    this.panEnabled = true,
    this.scaleEnabled = true,
    this.overlay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hooks for InteractiveViewer
    final transformationController = useTransformationController();
    final canvasKey = useMemoized(() => GlobalKey());
    
    // Feature State
    final nodes = ref.watch(canvasNodesNotifierProvider);

    return RepaintBoundary(
      key: canvasBoundaryKey,
      child: InteractiveViewer(
        transformationController: transformationController,
        minScale: 0.5,
        maxScale: 4.0,
        constrained: false,
        panEnabled: panEnabled,
        scaleEnabled: scaleEnabled,
        child: DragTarget<DeviceBlueprint>(
          builder: (context, candidateData, rejectedData) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final canvasSize = constraints.biggest;
                return Stack(
                  key: canvasKey,
                  children: [
                    // Static Background Image
                    Image.asset(
                      backgroundAssetPath,
                      fit: BoxFit.contain,
                    ),
                    
                    // Render Dropped Normalized Nodes
                    ...nodes.map((node) => _buildCanvasNode(node, canvasSize)),

                    // Optional overlay (annotation layer)
                    if (overlay != null) overlay!,
                  ],
                );
              },
            );
          },
          onAcceptWithDetails: (DragTargetDetails<DeviceBlueprint> details) {
            _handleDropImplementation(context, ref, details, canvasKey, transformationController);
          },
        ),
      ),
    );
  }

  // Exact Pipeline mapped from canvas-interaction-rules.md
  void _handleDropImplementation(
    BuildContext context, 
    WidgetRef ref, 
    DragTargetDetails<DeviceBlueprint> details,
    GlobalKey canvasKey,
    TransformationController transformController,
  ) {
    // 1. Guard payload
    final DeviceBlueprint payload = details.data;

    // 2. Strip UI offsets using Context
    final RenderBox? canvasBox = canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (canvasBox == null || !canvasBox.hasSize) return;

    final Offset localPos = canvasBox.globalToLocal(details.offset);
    
    // 3. Reverse active InteractiveViewer matrix into child scene space
    final Offset scenePos = transformController.toScene(localPos);
    
    // 4. Extract intrinsic bounds
    final double sceneWidth = canvasBox.size.width; 
    final double sceneHeight = canvasBox.size.height;
    final double normNodeWidth = payload.defaultWidthRatio;
    final double normNodeHeight = payload.defaultHeightRatio;
    
    // 5. Normalize & clamp against bounds
    final double normX = (scenePos.dx / sceneWidth).clamp(0.0, 1.0 - normNodeWidth);
    final double normY = (scenePos.dy / sceneHeight).clamp(0.0, 1.0 - normNodeHeight);

    // 6. Push to Feature State
    ref.read(canvasNodesNotifierProvider.notifier).addNodeFromDrop(
      blueprintId: payload.id,
      realisticAssetPath: payload.realisticPath,
      normX: normX,
      normY: normY,
      widthRatio: normNodeWidth,
      heightRatio: normNodeHeight,
    );
  }

  Widget _buildCanvasNode(CanvasNode node, Size canvasSize) {
    return Positioned(
      // Resolve unitless vectors using actual canvas size, NOT MediaQuery screen size
      left: canvasSize.width * node.normalizedX,
      top: canvasSize.height * node.normalizedY,
      width: canvasSize.width * node.widthRatio,
      height: canvasSize.height * node.heightRatio,
      child: Image.asset(
        node.realisticAssetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}