class Booking {
  final int bookingId;
  final int babysitterId;
  final int tutorId;
  final String bookingChild;
  final int bookingEstimatedTime;
  final String bookingTimeStart;
  final String bookingTimeEnd;
  final String bookingDate;
  final bool bookingStatus;
  final int bookingCompleted;
  final bool bookingPaid;
  final double bookingAmount;

  Booking({
    required this.bookingId,
    required this.babysitterId,
    required this.tutorId,
    required this.bookingChild,
    required this.bookingEstimatedTime,
    required this.bookingTimeStart,
    required this.bookingTimeEnd,
    required this.bookingDate,
    required this.bookingStatus,
    required this.bookingCompleted,
    required this.bookingPaid,
    required this.bookingAmount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['bookingId'] as int? ?? 0,
      babysitterId: json['babysitterId'] as int? ?? 0,
      tutorId: json['tutorId'] as int? ?? 0,
      bookingChild: json['bookingChild'] as String? ?? '',
      bookingEstimatedTime: json['bookingEstimatedTime'] as int? ?? 0,
      bookingTimeStart: json['bookingTimeStart'] as String? ?? '',
      bookingTimeEnd: json['bookingTimeEnd'] as String? ?? '',
      bookingDate: json['bookingDate'] as String? ?? '',
      bookingStatus: json['bookingStatus'] as bool? ?? false,
      bookingCompleted: json['bookingCompleted'] as int? ?? 0,
      bookingPaid: json['bookingPaid'] as bool? ?? false,
      bookingAmount: json['bookingAmount'] as double? ?? 0.0,
    );
  }
}