import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/BillboardRepository/models/response.dart';
import 'package:quadrant_app/repositories/BillboardRepository/billboard_repository.dart';

part 'billboard_event.dart';
part 'billboard_state.dart';

class BillboardBloc extends Bloc<BillboardEvent, BillboardState> {
  BillboardBloc({
    required BillboardRepository billboardRepository,
  })  : _billboardRepository = billboardRepository,
        super(BillboardLoading()) {
    on<FetchBillboard>(_onGetBillboards);
  }

  final BillboardRepository _billboardRepository;

  Future<void> _onGetBillboards(
    FetchBillboard event,
    Emitter<BillboardState> emit,
  ) async {
    emit(BillboardLoading());
    try {
      final response = await _billboardRepository.fetchBillboardImages();
      emit(BillboardLoaded(billboards: response));
    } catch (_) {
      emit(BillboardError());
    }
  }
}
