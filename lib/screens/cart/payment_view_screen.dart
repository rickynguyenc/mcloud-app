import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/app_dio.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/providers/order_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

@RoutePage()
class PaymentViewScreen extends HookConsumerWidget {
  final String linkOnePay;
  late final WebViewController _controller;
  PaymentViewScreen({required this.linkOnePay});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
      // #enddocregion platform_features
      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              // Navigator.pop(context);
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                debugPrint('blocking navigation to ${request.url}');
                return NavigationDecision.prevent;
              }
              debugPrint('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange change) async {
              if ((change.url ?? '').contains('vpc_Message=Approved')) {
                const _extra = <String, dynamic>{};
                final queryParameters = <String, dynamic>{};
                final _headers = <String, dynamic>{};
                final Map<String, dynamic>? _data = null;
                final _dio = ref.read(dioProvider);
                await _dio.fetch<dynamic>(Options(
                  method: 'GET',
                  headers: _headers,
                  extra: _extra,
                )
                    .compose(
                      _dio.options,
                      change.url ?? '',
                      queryParameters: queryParameters,
                      data: _data,
                    )
                    .copyWith(baseUrl: ''));
              }
              if ((change.url ?? '').contains('/payment/checkout')) {
                Uri uri = Uri.parse(change.url!);
                String? orderInfo = uri.queryParameters['vpc_OrderInfo'];
                final idOrder = orderInfo?.substring(3);
                if (idOrder != null) {
                  AutoRouter.of(context).replace(DetailOrderRoute(orderId: int.parse(idOrder)));
                }
              }
              debugPrint('url change to ${change.url}');
            },
          ),
        )
        ..addJavaScriptChannel(
          'Toaster',
          onMessageReceived: (JavaScriptMessage message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          },
        )
        ..loadRequest(Uri.parse(linkOnePay));

      // #docregion platform_features
      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
      }
      // #enddocregion platform_features

      _controller = controller;
      return null;
    }, []);
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: WebViewWidget(controller: _controller),
        ),
      ),
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        }
        return true;
      },
    );
  }
}
