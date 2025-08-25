import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_provider.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_tamplate_storage.dart';

part 'ai_bridge_config_event.dart';
part 'ai_bridge_config_state.dart';

class AiBridgeConfigBloc
    extends Bloc<AiBridgeConfigEvent, AiBridgeConfigState> {
  final AiBridgeProvider aiBridgeProvider;
  final AiBridgeTamplateStorage aiBridgeTemplateStorage;

  AiBridgeConfigBloc({
    required this.aiBridgeProvider,
    required this.aiBridgeTemplateStorage,
  }) : super(const AiBridgeConfigState.initial()) {
    on<AiBridgeConfigStarted>((event, emit) async {
      emit(
        state.copyWith(
          loadStatus: AiTemplateLoadStatus.loading,
        ),
      );

      emit(
        state.copyWith(
          loadStatus: AiTemplateLoadStatus.finished,
          selected: await aiBridgeProvider.getInfo(),
          templates: await aiBridgeTemplateStorage.getAll(),
        ),
      );
    });
    on<AiBridgeConfigClearAllRequested>((event, emit) async {
      await aiBridgeTemplateStorage.clear();
      await aiBridgeProvider.set(const AiTemplate.empty());

      emit(
        state.copyWith(
          selected: const AiTemplate.empty(),
          templates: const [],
        ),
      );
    });
    on<AiBridgeConfigTemplateCreated>((event, emit) async {
      await aiBridgeTemplateStorage.add(event.value);
      await aiBridgeProvider.set(event.value);

      emit(
        state.copyWith(
          selected: event.value,
          templates: [...state.templates, event.value],
        ),
      );
    });
    on<AiBridgeConfigTemplateModified>((event, emit) async {
      await aiBridgeTemplateStorage.replace(
        id: event.newValue.id,
        value: event.newValue,
      );

      if (event.initial == state.selected) {
        await aiBridgeProvider.set(event.newValue);

        emit(
          state.copyWith(
            selected: event.newValue,
          ),
        );
      }

      add(AiBridgeConfigStarted());
    });
    on<AiBridgeConfigTemplateDeleted>((event, emit) async {
      await aiBridgeTemplateStorage.remove(event.value.id);

      if (event.value == state.selected) {
        await aiBridgeProvider.set(const AiTemplate.empty());

        emit(
          state.copyWith(
            selected: const AiTemplate.empty(),
          ),
        );
      }

      add(AiBridgeConfigStarted());
    });
    on<AiBridgeConfigSelectedChanged>((event, emit) async {
      await aiBridgeProvider.set(event.value);

      emit(
        state.copyWith(
          selected: event.value,
        ),
      );
    });
  }
}
