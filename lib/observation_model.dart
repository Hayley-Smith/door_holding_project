// Data Model
import 'main.dart';

class Observation {
  final HoldingType holdingType;
  final Gender gender;
  final AgeGroup ageGroup;
  final Distance distance;

  Observation({
    required this.holdingType,
    required this.gender,
    required this.ageGroup,
    required this.distance,
  });

  // Convert observation to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'holdingType': holdingType.toString().split('.').last,
      'gender': gender.toString().split('.').last,
      'ageGroup': ageGroup.toString().split('.').last,
      'distance': distance.toString().split('.').last,
    };
  }
}
