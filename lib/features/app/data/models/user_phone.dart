class UserPhone {
  const UserPhone({
    this.mobile,
  });

  final String? mobile;

  factory UserPhone.fromJson(Map<String, dynamic> json) => UserPhone(
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}
