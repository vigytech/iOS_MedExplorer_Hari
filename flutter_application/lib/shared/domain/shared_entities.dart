/// Cross-feature entity re-exports. Other features import from HERE,
/// never reaching directly into another feature's domain/ folder.
///
/// This barrel prevents architecture violations where feature A
/// imports directly from feature B's internal domain layer.
library shared_entities;

export '../../features/device_catalog/domain/device_blueprint.dart';
export '../../features/canvas_editor/domain/canvas_node.dart';
