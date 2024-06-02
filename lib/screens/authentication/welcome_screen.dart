import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class WelcomeScreen extends HookConsumerWidget {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                height: 280,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  'Worm',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                ),
              ),
              //
              // Padding(
              //   padding: const EdgeInsets.only(top: 16, bottom: 8),
              //   child: Text(
              //     'Jumping Dot',
              //     style: TextStyle(color: Colors.black54),
              //   ),
              // ),
              // Container(
              //   child: SmoothPageIndicator(
              //     controller: controller,
              //     count: pages.length,
              //     effect: JumpingDotEffect(
              //       dotHeight: 16,
              //       dotWidth: 16,
              //       jumpScale: .7,
              //       verticalOffset: 15,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16, bottom: 12),
              //   child: Text(
              //     'Scrolling Dots',
              //     style: TextStyle(color: Colors.black54),
              //   ),
              // ),
              // SmoothPageIndicator(
              //     controller: controller,
              //     count: pages.length,
              //     effect: ScrollingDotsEffect(
              //       activeStrokeWidth: 2.6,
              //       activeDotScale: 1.3,
              //       maxVisibleDots: 5,
              //       radius: 8,
              //       spacing: 10,
              //       dotHeight: 12,
              //       dotWidth: 12,
              //     )),
              // Padding(
              //   padding: const EdgeInsets.only(top: 16, bottom: 16),
              //   child: Text(
              //     'Customizable Effect',
              //     style: TextStyle(color: Colors.black54),
              //   ),
              // ),
              // Container(
              //   // color: Colors.red.withOpacity(.4),
              //   child: SmoothPageIndicator(
              //     controller: controller,
              //     count: pages.length,
              //     effect: CustomizableEffect(
              //       activeDotDecoration: DotDecoration(
              //         width: 32,
              //         height: 12,
              //         color: Colors.indigo,
              //         rotationAngle: 180,
              //         verticalOffset: -10,
              //         borderRadius: BorderRadius.circular(24),
              //         // dotBorder: DotBorder(
              //         //   padding: 2,
              //         //   width: 2,
              //         //   color: Colors.indigo,
              //         // ),
              //       ),
              //       dotDecoration: DotDecoration(
              //         width: 24,
              //         height: 12,
              //         color: Colors.grey,
              //         // dotBorder: DotBorder(
              //         //   padding: 2,
              //         //   width: 2,
              //         //   color: Colors.grey,
              //         // ),
              //         // borderRadius: BorderRadius.only(
              //         //     topLeft: Radius.circular(2),
              //         //     topRight: Radius.circular(16),
              //         //     bottomLeft: Radius.circular(16),
              //         //     bottomRight: Radius.circular(2)),
              //         borderRadius: BorderRadius.circular(16),
              //         verticalOffset: 0,
              //       ),
              //       spacing: 6.0,
              //       // activeColorOverride: (i) => colors[i],
              //       inActiveColorOverride: (i) => colors[i],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
