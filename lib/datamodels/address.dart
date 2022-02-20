class Address {
  late String? placeName;
  late double? latitude;
  late double? longitude;
  late String? placeId;
  late String? placeFormattedAddress;

  Address({
    this.placeId,
    this.latitude,
    this.longitude,
    this.placeName,
    this.placeFormattedAddress,
  });
}
