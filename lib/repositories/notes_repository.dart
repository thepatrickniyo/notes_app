import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  Future<List<Note>> fetchNotes() async {
    try {
      if (_currentUserId == null) throw Exception('User not authenticated');

      final querySnapshot = await _firestore
          .collection('notes')
          .where('userId', isEqualTo: _currentUserId)
          // Temporarily commented out while index builds
          // .orderBy('updatedAt', descending: true)
          .get();

      final notes = querySnapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
      
      // Sort in Dart as fallback while index builds
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      
      return notes;
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  Future<void> addNote(String text) async {
    try {
      if (_currentUserId == null) throw Exception('User not authenticated');

      final now = DateTime.now();
      final note = Note(
        id: '',
        title: _extractTitle(text),
        content: text,
        createdAt: now,
        updatedAt: now,
        userId: _currentUserId!,
      );

      await _firestore.collection('notes').add(note.toFirestore());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<void> updateNote(String id, String text) async {
    try {
      if (_currentUserId == null) throw Exception('User not authenticated');

      await _firestore.collection('notes').doc(id).update({
        'title': _extractTitle(text),
        'content': text,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      if (_currentUserId == null) throw Exception('User not authenticated');

      await _firestore.collection('notes').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }

  String _extractTitle(String text) {
    final lines = text.split('\n');
    final firstLine = lines.first.trim();

    if (firstLine.isEmpty) {
      return 'Untitled Note';
    }

    return firstLine.length > 50
        ? '${firstLine.substring(0, 50)}...'
        : firstLine;
  }
}
