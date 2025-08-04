part of 'approve_reciepts_bloc.dart';

@immutable
sealed class ApproveReceiptsState {
  const ApproveReceiptsState();
}

final class ApproveReceiptsInitial extends ApproveReceiptsState {}

class ApproveReceiptsSuccessState extends ApproveReceiptsState {
  final ReceiptEntity? originalReceipt;  // неизменная, та что из бэка
  final ReceiptEntity? receiptEntity;    // текущая, редактируемая
  final Set<int> editedItemIds;

  ApproveReceiptsSuccessState({
    required this.originalReceipt,
    required this.receiptEntity,
    Set<int>? editedItemIds,
  }) : editedItemIds = editedItemIds ?? {};

  // @override
  // List<Object?> get props => [originalReceipt, receiptEntity, editedItemIds];
}


