import '../models/document_model.dart';

class DocumentService {
  static final List<DocumentModel> _documents = [];

  List<DocumentModel> getAllDocuments() => List.unmodifiable(_documents);

  List<DocumentModel> getDocumentsForProject(String projectId) {
    return _documents.where((d) => d.projectId == projectId).toList();
  }

  List<DocumentModel> getDocumentsByType(DocumentType type) {
    return _documents.where((d) => d.type == type).toList();
  }

  void addDocument(DocumentModel doc) {
    _documents.insert(0, doc);
  }

  void updateDocument(DocumentModel doc) {
    final index = _documents.indexWhere((d) => d.id == doc.id);
    if (index != -1) {
      _documents[index] = doc;
    }
  }

  void deleteDocument(String id) {
    _documents.removeWhere((d) => d.id == id);
  }

  int get totalDocuments => _documents.length;

  double get totalSizeMb =>
      _documents.fold(0, (sum, d) => sum + d.sizeKb) / 1024;
}
