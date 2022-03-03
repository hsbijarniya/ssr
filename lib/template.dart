import 'package:ssr/ssr.dart';

extension Template on ServerSideRendering {
  static Map parseTemplate(String template) {
    // not yet implemented
    return {};
  }

  static processTemplate(String template) {
    return ServerSideRendering.process(parseTemplate(template));
  }
}
