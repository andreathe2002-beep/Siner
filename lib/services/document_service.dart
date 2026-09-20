import '../models/document_model.dart';

class DocumentService {
  static final List<DocumentModel> _documents = [
    DocumentModel(
      id: 'd1',
      projectId: 'p1',
      title: 'Protocolo de muestreo andino v2.pdf',
      type: DocumentType.protocol,
      fileType: 'pdf',
      sizeKb: 2450,
      uploadedById: 'u1',
      version: '2.1',
      tags: ['Protocolo', 'Muestreo', 'Campo'],
      createdAt: DateTime(2026, 3, 5),
      updatedAt: DateTime(2026, 8, 20),
    ),
    DocumentModel(
      id: 'd2',
      projectId: 'p1',
      title: 'Inventario_species_norte.xlsx',
      type: DocumentType.dataset,
      fileType: 'xlsx',
      sizeKb: 8900,
      uploadedById: 'u3',
      version: '1.3',
      tags: ['Dataset', 'Biodiversidad'],
      createdAt: DateTime(2026, 7, 15),
      updatedAt: DateTime(2026, 9, 10),
    ),
    DocumentModel(
      id: 'd3',
      projectId: 'p2',
      title: 'CardioNet-architecture.pdf',
      type: DocumentType.paper,
      fileType: 'pdf',
      sizeKb: 3200,
      uploadedById: 'u1',
      version: '1.0',
      tags: ['IA', 'Arquitectura', 'CNN'],
      createdAt: DateTime(2026, 5, 1),
      updatedAt: DateTime(2026, 5, 1),
    ),
    DocumentModel(
      id: 'd4',
      projectId: 'p2',
      title: 'Dataset_cardiovida_v2.zip',
      type: DocumentType.dataset,
      fileType: 'zip',
      sizeKb: 512000,
      uploadedById: 'u5',
      version: '2.0',
      tags: ['Dataset', 'Imágenes', 'Cardiovascular'],
      createdAt: DateTime(2026, 6, 30),
      updatedAt: DateTime(2026, 9, 15),
    ),
    DocumentModel(
      id: 'd5',
      projectId: 'p2',
      title: 'Presentación congreso AMIA 2026.pptx',
      type: DocumentType.presentation,
      fileType: 'pptx',
      sizeKb: 15600,
      uploadedById: 'u3',
      version: '1.2',
      tags: ['Congreso', 'Presentación'],
      createdAt: DateTime(2026, 9, 1),
      updatedAt: DateTime(2026, 9, 12),
    ),
    DocumentModel(
      id: 'd6',
      projectId: 'p4',
      title: 'Catálogo tradiciones orales.pdf',
      type: DocumentType.report,
      fileType: 'pdf',
      sizeKb: 12400,
      uploadedById: 'u2',
      version: '1.0',
      tags: ['Cultura', 'Catálogo'],
      createdAt: DateTime(2026, 4, 10),
      updatedAt: DateTime(2026, 7, 5),
    ),
    DocumentModel(
      id: 'd7',
      projectId: 'p5',
      title: 'Tesis nanomateriales_final.pdf',
      type: DocumentType.paper,
      fileType: 'pdf',
      sizeKb: 8900,
      uploadedById: 'u1',
      version: '3.0',
      tags: ['Tesis', 'Nanotecnología'],
      createdAt: DateTime(2026, 5, 28),
      updatedAt: DateTime(2026, 5, 28),
    ),
    DocumentModel(
      id: 'd8',
      projectId: 'p3',
      title: 'Propuesta energías renovables.pdf',
      type: DocumentType.report,
      fileType: 'pdf',
      sizeKb: 4200,
      uploadedById: 'u2',
      version: '1.1',
      tags: ['Propuesta', 'Energía'],
      createdAt: DateTime(2026, 8, 25),
      updatedAt: DateTime(2026, 9, 1),
    ),
  ];

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
