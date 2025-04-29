class ImtCalculation {
  int? id;
  final double weight;
  final double height;
  final double imt;
  final String interpretation;
  final int timestamp; 

  ImtCalculation({
    this.id,
    required this.weight,
    required this.height,
    required this.imt,
    required this.interpretation,
    required this.timestamp, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight': weight,
      'height': height,
      'imt': imt,
      'interpretation': interpretation,
      'timestamp': timestamp, 
    };
  }

  factory ImtCalculation.fromMap(Map<String, dynamic> map) {
    return ImtCalculation(
      id: map['id'],
      weight: map['weight'],
      height: map['height'],
      imt: map['imt'],
      interpretation: map['interpretation'],
      timestamp: map['timestamp'], 
    );
  }

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);
}