import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/notes_repository.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc({required NotesRepository notesRepository})
    : _notesRepository = notesRepository,
      super(NotesInitial()) {
    on<NotesLoadRequested>(_onNotesLoadRequested);
    on<NotesAddRequested>(_onNotesAddRequested);
    on<NotesUpdateRequested>(_onNotesUpdateRequested);
    on<NotesDeleteRequested>(_onNotesDeleteRequested);
  }

  Future<void> _onNotesLoadRequested(
    NotesLoadRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      final notes = await _notesRepository.fetchNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onNotesAddRequested(
    NotesAddRequested event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await _notesRepository.addNote(event.text);
      emit(const NotesSuccess('Note added successfully'));
      add(NotesLoadRequested());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onNotesUpdateRequested(
    NotesUpdateRequested event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await _notesRepository.updateNote(event.id, event.text);
      emit(const NotesSuccess('Note updated successfully'));
      add(NotesLoadRequested());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onNotesDeleteRequested(
    NotesDeleteRequested event,
    Emitter<NotesState> emit,
  ) async {
    try {
      await _notesRepository.deleteNote(event.id);
      emit(const NotesSuccess('Note deleted successfully'));
      add(NotesLoadRequested());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
