import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/models/ai_bridge_template_create_step.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/models/ai_bridge_template_model_loading.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/models/ai_bridge_template_model_option.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/models/local_ip_addresses.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/usecase/load_local_ip_address_usecase.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/usecase/load_model_usecase.dart';
import 'package:uuid/v4.dart';

part 'ai_bridge_template_create_state.dart';

class AiBridgeTemplateCreateCubit extends Cubit<AiBridgeTemplateCreateState> {
  final AiTemplate initial;

  AiBridgeTemplateCreateCubit(this.initial)
    : super(AiBridgeTemplateCreateState.initial());

  Future init() async {
    emit(
      state.copyWith(
        api: initial.apiKey,
        model: initial.model,
        bridgeType: initial.type,
        url: initial.uri,
        localIp: await LoadLocalIpAddressUsecase.invoke(),
      ),
    );
  }

  AiTemplate createTemplate() {
    final id = initial.id;

    final isEdit = id != '';

    return AiTemplate(
      id: isEdit ? id : UuidV4().generate(),
      uri: state.url.trim(),
      model: state.model.trim(),
      type: state.bridgeType,
      apiKey: state.bridgeType.isRemote ? state.api.trim() : '',
    );
  }

  void setApi(String value) {
    emit(
      state.copyWith(api: value),
    );
  }

  void setModel(String value) {
    emit(
      state.copyWith(model: value),
    );
  }

  void setUrl(String value) {
    emit(
      state.copyWith(url: value),
    );
  }

  void setConnectionType(AiBridgeType value) {
    emit(
      state.copyWith(bridgeType: value),
    );
  }

  void previousStep() => _setStepWith(offset: -1);

  void nextStep() => _setStepWith(offset: 1);

  void _setStepWith({required int offset}) {
    final values = AiBridgeTemplateCreateStep.values;

    final index = values.indexOf(state.step);

    final step = values[index + offset];

    _setStep(step);
  }

  Future _setStep(AiBridgeTemplateCreateStep value) async {
    emit(
      state.copyWith(step: value),
    );

    if (value.isModel) {
      emit(
        state.copyWith(
          modelLoading: AiBridgeTemplateModelLoading.loading,
        ),
      );

      final models = await LoadModelUsecase.invoke(state.url);

      emit(
        state.copyWith(
          modelLoading: AiBridgeTemplateModelLoading.loaded,
          models: models,
        ),
      );
    }
  }
}
