import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_response.freezed.dart';
part 'category_response.g.dart';

@freezed
abstract class RatingResponse with _$RatingResponse {
  const factory RatingResponse({required double rate, required int count}) =
      _RatingResponse;

  factory RatingResponse.empty() => const RatingResponse(rate: 0.0, count: 0);

  factory RatingResponse.fromJson(Map<String, dynamic> json) =>
      _$RatingResponseFromJson(json);
}
