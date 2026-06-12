/// Domain result type for the export pipeline.
sealed class ExportResult {
  const ExportResult();
}

class ExportSuccess extends ExportResult {
  final String filePath;
  const ExportSuccess(this.filePath);
}

class ExportFailure extends ExportResult {
  final String message;
  const ExportFailure(this.message);
}
