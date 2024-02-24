import 'package:url_launcher/url_launcher.dart';

class ContactHelper {
  static launchURL(String postUrl) async {
    var url = 'https://www.reddit.com$postUrl';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
