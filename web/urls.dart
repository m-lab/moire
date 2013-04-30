library urls;

import 'package:route/url_pattern.dart';

final root = new UrlPattern(r'(.*)/index.html');
final localeUrl = new UrlPattern(r'./location/');
final allUrls = [root, localeUrl];