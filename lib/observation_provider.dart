import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_holding_project/SAMPLE_DATA.dart';
import 'package:flutter/foundation.dart';

import 'main.dart';
import 'observation_model.dart';

class ObservationProvider with ChangeNotifier {
  final List<Observation> _observations = data;

  List<Observation> get observations => _observations;

  ObservationProvider() {
    // Automatically fetch observations from Firestore when the provider is initialized
    // fetchObservations();
  }

  // Fetch all observations from Firestore
  // void fetchObservations() {
  //   FirebaseFirestore.instance.collection('observations').snapshots().listen(
  //     (snapshot) {
  //       _observations = snapshot.docs.map((doc) {
  //         // Convert Firestore document into Observation object
  //         return Observation(
  //           holdingType: stringToHoldingType(doc['holdingType']),
  //           gender: stringToGender(doc['gender']),
  //           ageGroup: stringToAgeGroup(doc['ageGroup']),
  //           distance: stringToDistance(doc['distance']),
  //         );
  //       }).toList();
  //       notifyListeners(); // Notify listeners to rebuild widgets
  //     },
  //   );
  // }

  // // Fetch observations from Firestore when manually triggered
  // Future<void> fetchObservationsFromFirestore() async {
  //   try {
  //     QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection('observations').get();
  //
  //     // Convert the snapshot data to Observation objects
  //     _observations = snapshot.docs.map((doc) {
  //       return Observation(
  //         holdingType: stringToHoldingType(doc['holdingType']),
  //         gender: stringToGender(doc['gender']),
  //         ageGroup: stringToAgeGroup(doc['ageGroup']),
  //         distance: stringToDistance(doc['distance']),
  //       );
  //     }).toList();
  //
  //     notifyListeners(); // Notify listeners to update UI
  //   } catch (e) {
  //     print("Error fetching data from Firestore: $e");
  //   }
  // }

  // Helper methods to convert Firestore strings to enums with default/fallback values
  HoldingType stringToHoldingType(String value) {
    try {
      return HoldingType.values
          .firstWhere((e) => e.toString().split('.').last == value);
    } catch (e) {
      print("Invalid HoldingType: $value, defaulting to noneSelected");
      return HoldingType.noneSelected; // Provide a fallback value
    }
  }

  Gender stringToGender(String value) {
    try {
      return Gender.values
          .firstWhere((e) => e.toString().split('.').last == value);
    } catch (e) {
      print("Invalid Gender: $value, defaulting to noneSelected");
      return Gender.noneSelected; // Provide a fallback value
    }
  }

  AgeGroup stringToAgeGroup(String value) {
    try {
      return AgeGroup.values
          .firstWhere((e) => e.toString().split('.').last == value);
    } catch (e) {
      print("Invalid AgeGroup: $value, defaulting to noneSelected");
      return AgeGroup.noneSelected; // Provide a fallback value
    }
  }

  Distance stringToDistance(String value) {
    try {
      return Distance.values
          .firstWhere((e) => e.toString().split('.').last == value);
    } catch (e) {
      print("Invalid Distance: $value, defaulting to noneSelected");
      return Distance.noneSelected; // Provide a fallback value
    }
  }

  // Save all observations to Firestore
  Future<void> saveToFirestore() async {
    try {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('observations');

      for (Observation observation in _observations) {
        await collection.add(observation
            .toMap()); // Convert each observation to a map and add to Firestore
      }

      // Clear the list after saving
      _observations.clear();
      notifyListeners(); // Notify listeners that the list has been cleared
    } catch (e) {
      if (kDebugMode) {
        print('Failed to save observations: $e');
      }
    }
  }

  // Add a new observation to the list
  void addObservation(Observation observation) {
    _observations.add(observation);
    if (kDebugMode) {
      print('Observation added: ${observation.toMap()}');
    }
    if (kDebugMode) {
      print('Current observations list length: ${_observations.length}');
    }
    notifyListeners(); // Notify listeners when the list changes
  }

  // // Save all observations to Firestore
  // Future<void> saveToFirestore() async {
  //   try {
  //     if (kDebugMode) {
  //       print('Starting to save observations to Firestore...');
  //     }
  //     final CollectionReference collection =
  //         FirebaseFirestore.instance.collection('observations');
  //
  //     for (Observation observation in _observations) {
  //       if (kDebugMode) {
  //         print('Saving observation: ${observation.toMap()}');
  //       }
  //       await collection.add(observation
  //           .toMap()); // Convert each observation to a map and add to Firestore
  //     }

  //     // Clear the list after saving
  //     _observations.clear();
  //     if (kDebugMode) {
  //       print('Observations saved successfully. List cleared.');
  //     }
  //     notifyListeners(); // Notify listeners that the list has been cleared
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Failed to save observations: $e');
  //     }
  //   }
  // }

  // Clear observations (if needed)
  void clearObservations() {
    _observations.clear();
    if (kDebugMode) {
      print('Observations list cleared.');
    }
    notifyListeners(); // Notify listeners when the list is cleared
  }
}
