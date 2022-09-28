// import 'package:flutter/_widgets.dart';

// extension ColorX on Color {
//   Color percentage(String value) {
//     final redString = this.red.toRadixString(16).padLeft(2, '0');
//     final greenString = this.green.toRadixString(16).padLeft(2, '0');
//     final blueString = this.blue.toRadixString(16).padLeft(2, '0');
//     final opacityString = _getOpacityString(value);
//     final hexString = '$opacityString$redString$greenString$blueString';
//     return Color(int.parse(hexString, radix: 16));
//   }

//   String _getOpacityString(String value) {
//     late String _code;
//     switch (value) {
//       case '0':
//         _code = '00';
//         break;
//       case '5':
//         _code = '0D';
//         break;
//       case '10':
//         _code = '1A';
//         break;
//       case '15':
//         _code = '26';
//         break;
//       case '20':
//         _code = '33';
//         break;
//       case '25':
//         _code = '40';
//         break;
//       case '30':
//         _code = '4D';
//         break;
//       case '35':
//         _code = '59';
//         break;
//       case '40':
//         _code = '66';
//         break;
//       case '45':
//         _code = '73';
//         break;
//       case '50':
//         _code = '80';
//         break;
//       case '55':
//         _code = '8C';
//         break;
//       case '60':
//         _code = '99';
//         break;
//       case '65':
//         _code = 'A6';
//         break;
//       case '70':
//         _code = 'B3';
//         break;
//       case '75':
//         _code = 'BF';
//         break;
//       case '80':
//         _code = 'CC';
//         break;
//       case '85':
//         _code = 'D9';
//         break;
//       case '90':
//         _code = 'E6';
//         break;
//       case '95':
//         _code = 'F2';
//         break;
//       case '100':
//         _code = 'FF';
//         break;
//       default:
//         _code = '00';
//     }
//     return _code;
//   }
// }
