const GOOGLE_API_KEY = 'AIzaSyAXg5WMcfP4G7M5KIIkXz4nGM2QlbbDfyg';

class LocationService {
  static String generateLocationPreviewImage(
      String name, double latitude, double longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&maptype=terrain&markers=color:red%7Clabel:C%7C$latitude,-$longitude&key=$GOOGLE_API_KEY";
  }
}
