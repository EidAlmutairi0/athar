const GOOGLE_API_KEY = 'AIzaSyAXg5WMcfP4G7M5KIIkXz4nGM2QlbbDfyg';

class LocationService {
  static String generateLocationPreviewImage(
      String name, double latitude, double longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap &markers=color:brown%7Clabel:$name%7$latitude,$longitude&key=$GOOGLE_API_KEY";
  }
}
