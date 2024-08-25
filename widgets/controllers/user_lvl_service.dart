// import 'package:Refferal/widgets/controllers/daymonthcandle.dart';
// // import 'package:firebase_database/firebase_database.dart';

// class UserLevelService {
//   final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

//   Future<void> saveUserLevel() async {
//     try {
//       await _databaseReference.child('user_level').set({
//         'lvlusr': userlvl.lvlusr,
//         'lvlc': userlvl.lvlc,
//         'chcknumlvl': userlvl.chcknumlvl,
//         'TomanDollar': userlvl.TomanDollar,
//         'FaEn': userlvl.FaEn,
//         'chkAdd_ubjct': userlvl.chkAdd_ubjct,
//       });
//       print('User level saved successfully.');
//     } catch (e) {
//       print('Failed to save user level: $e');
//     }
//   }

//   Future<void> getUserLevel() async {
//     try {
//       DataSnapshot dataSnapshot =
//           (await _databaseReference.child('user_level').once()).snapshot;

//       if (dataSnapshot.value != null) {
//         Map<dynamic, dynamic> values =
//             (dataSnapshot.value as Map<dynamic, dynamic>);

//         userlvl.lvlusr = values['lvlusr'];
//         userlvl.lvlc = values['lvlc'];
//         userlvl.chcknumlvl = values['chcknumlvl'];
//         userlvl.TomanDollar = values['TomanDollar'];
//         userlvl.FaEn = values['FaEn'];
//         userlvl.chkAdd_ubjct = values['chkAdd_ubjct'];
//         print('User level retrieved successfully.');
//       } else {
//         print('No user level data found.');
//       }
//     } catch (e) {
//       print('Failed to retrieve user level: $e');
//     }
//   }
// }
