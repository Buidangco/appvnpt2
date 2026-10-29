import 'package:flutter/foundation.dart';

import '../../app/env.dart';

/// Returns a CORS-safe image URL.
///
/// On Flutter Web, images from hungyentourism.com.vn are blocked by CORS.
/// When the app is running through the local proxy (localhost), this function
/// rewrites the URL to go through the proxy's `/img/` endpoint which adds
/// the required `Access-Control-Allow-Origin` header.
///
/// On mobile/desktop, the original URL is returned unchanged.
String getProxiedImageUrl(String? url) {
  if (url == null || url.isEmpty) return '';
  if (!kIsWeb) return url;

  // Only rewrite URLs from the hungyentourism domain.
  if (!url.contains('hungyentourism.com.vn')) return url;

  // Only rewrite when the app is using the local proxy.
  // If apiBaseUrl still points directly to the server, we can't proxy images.
  final apiBase = Env.apiBaseUrl;
  final usingProxy = apiBase.contains('localhost') ||
      apiBase.contains('127.0.0.1');
  if (!usingProxy) return url;

  // Derive proxy root from apiBaseUrl.
  // e.g. "http://localhost:8787/api/home.asmx" → "http://localhost:8787"
  final proxyBase = apiBase.replaceAll('/api/home.asmx', '');

  // Extract the path component, stripping leading slashes (the API sometimes
  // returns URLs with a double slash like "//updload_ubt/...").
  final uri = Uri.tryParse(url);
  if (uri == null) return url;
  final path = uri.path.replaceAll(RegExp(r'^/+'), '');

  return '$proxyBase/img/$path';
}
