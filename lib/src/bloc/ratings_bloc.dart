import '../models/rating.dart';
import '../resources/repository.dart';

import 'package:rxdart/rxdart.dart';

class RatingsBloc {
  final _repo = Repository();

  final BehaviorSubject<List<Rating>> _ratingsSubject =
      BehaviorSubject<List<Rating>>();
  Stream<List<Rating>> get ratings => _ratingsSubject.stream;
  Function(List<Rating>) get changeRatings => _ratingsSubject.sink.add;

  final BehaviorSubject<String> _ratingCommentSubject =
      BehaviorSubject<String>();
  Stream<String> get ratingComment => _ratingCommentSubject.stream;
  Function(String) get changeRatingComment => _ratingCommentSubject.sink.add;

  final BehaviorSubject<double> _ratingValueSubject = BehaviorSubject<double>();
  Stream<double> get ratingValue => _ratingValueSubject.stream;
  Function(double) get changeRatingValue => _ratingValueSubject.sink.add;

  final BehaviorSubject<bool> _isSavingSubject = BehaviorSubject<bool>();
  Stream<bool> get isSaving => _isSavingSubject.stream;
  Function(bool) get changeSavingStatus => _isSavingSubject.sink.add;

  getRatings(String vendorName) {
    _repo.getRatings(vendorName).listen((ratings) {
      changeRatings(ratings);
    });
  }

  Future<void> saveRating(String vendorName, Map<String, dynamic> user) =>
      _repo.saveRating(
        vendorName,
        {
          "rating": _ratingValueSubject.value,
          "createdAt": DateTime.now().toIso8601String(),
          "comment": _ratingCommentSubject.value,
          "user": user,
        },
      );

  Stream<bool> canSubmitRating() =>
      Rx.combineLatest2(ratingValue, ratingComment, (a, b) => true);

  dispose() {
    _ratingsSubject.close();
    _ratingCommentSubject.close();
    _ratingValueSubject.close();
    _isSavingSubject.close();
  }
}
