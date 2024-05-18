part of 'billboard_bloc.dart';

abstract class BillboardEvent extends Equatable {
  const BillboardEvent();
} 

final class FetchBillboard extends BillboardEvent {
  @override
  List<Object> get props => [];
}

