final stations = [
  StationModel(name: 'דרך המלך 34', time: '12:15', completed: true),
  StationModel(name: 'שדרות יצחק רבין 121', time: '12:15', completed: true),
  StationModel(name: 'נחל זוהר 23', time: '12:15', completed: false),
  StationModel(name: 'יצחק שדה 90', time: '12:15', completed: false),
  StationModel(name: 'שדרות עלי הכהן 102', time: '12:15', completed: false),
  StationModel(name: 'דרך ציון 90', time: '12:15', completed: false),
];

class StationModel {
  StationModel({required this.name, required this.time, required this.completed});

  final String name;
  final String time;
  final bool completed;
}
