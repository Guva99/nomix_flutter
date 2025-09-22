import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nomix/core/entity/auth_data_entity.dart';
import 'package:nomix/core/service/telegram_service/telegram_utils.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';
import 'package:nomix/features/approve_receipts_page/domain/usecases/usecase.dart';

part 'approve_reciepts_event.dart';

part 'approve_reciepts_state.dart';

@lazySingleton
class ApproveReceiptsBloc extends Bloc<ApproveReceiptsEvent, ApproveReceiptsState> {
  final ApproveReceiptsUseCase approveReceiptsUseCase;

  ApproveReceiptsBloc(this.approveReceiptsUseCase) : super(ApproveReceiptsInitial()) {
    on<ApproveReceiptsGetModelEvent>(_onApproveReceiptsGetModelEvent);
    on<ApproveReceiptsEditItemEvent>(_onApproveReceiptsEditItemEvent);
    on<ApproveReceiptsSaveAllEvent>(_onApproveReceiptsSaveAllEvent);
  }

  Future<void> _onApproveReceiptsEditItemEvent(
      ApproveReceiptsEditItemEvent e,
      Emitter<ApproveReceiptsState> emit,
      ) async {
    if (state is! ApproveReceiptsSuccessState) return;
    final old = state as ApproveReceiptsSuccessState;

    final newItems = List<ReceiptItemEntity>.from(old.receiptEntity!.items!);
    newItems[e.index] = e.updatedItem;

    final newReceipt = old.receiptEntity?.copyWith(items: newItems);
    final newEdited  = {...old.editedItemIds, e.index};

    // originalReceipt не трогаем
    emit(ApproveReceiptsSuccessState(
      originalReceipt: old.originalReceipt,
      receiptEntity:   newReceipt,
      editedItemIds:   newEdited,
    ));
  }

  Future<void> _onApproveReceiptsGetModelEvent(
      ApproveReceiptsGetModelEvent event,
      Emitter<ApproveReceiptsState> emit,
      ) async {
    final data = await approveReceiptsUseCase.getlastCheckModel(5392060521);
    // При первом заходе original и текущий — одинаковы
    emit(ApproveReceiptsSuccessState(
      originalReceipt: data,
      receiptEntity:   data,
    ));
  }
  //
  // Future<void> _onApproveReceiptsGetModelEvent(
  //   ApproveReceiptsGetModelEvent event,
  //   Emitter<ApproveReceiptsState> emit,
  // ) async {
  //   final data = await approveReceiptsUseCase.getlastCheckModel(5392060521);
  //
  //   // AuthUserEntity? userEntity = TelegramUtils.getUserInfo();
  //   // if (userEntity?.id != null) {
  //   //   final data = await approveReceiptsUseCase.getlastCheckModel(5392060521);
  //     emit(ApproveReceiptsSuccessState(receiptEntity: data));
  //   // }
  //
  //   // await checkStatusAndGetNewDataSensor(generalResponseData: data, emit: emit, flatData: event.flatData);
  // }

  Future<void> _onApproveReceiptsSaveAllEvent(
    ApproveReceiptsSaveAllEvent event,
    Emitter<ApproveReceiptsState> emit,
  ) async {
    if (state is! ApproveReceiptsSuccessState) return;
    final old = state as ApproveReceiptsSuccessState;
    // await approveReceiptsUseCase.saveReceipt(old.receiptEntity);
    // после удачи можно очистить editedItemIds или переключить экран
    // emit(ApproveReceiptsSuccessState(
    //   receiptEntity: old.receiptEntity,
    //   editedItemIds: const {},
    // ));
  }
}
