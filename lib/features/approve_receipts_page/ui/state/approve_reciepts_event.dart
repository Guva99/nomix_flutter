part of 'approve_reciepts_bloc.dart';

@immutable
sealed class ApproveReceiptsEvent {
  const ApproveReceiptsEvent();
}

class ApproveReceiptsGetModelEvent extends ApproveReceiptsEvent {
  const ApproveReceiptsGetModelEvent();
}

class ApproveReceiptsEditItemEvent extends ApproveReceiptsEvent {
  final ReceiptItemEntity updatedItem;
  final int index;

  const ApproveReceiptsEditItemEvent({required this.updatedItem, required this.index, });
}

class ApproveReceiptsSaveAllEvent extends ApproveReceiptsEvent {
  const ApproveReceiptsSaveAllEvent();
}