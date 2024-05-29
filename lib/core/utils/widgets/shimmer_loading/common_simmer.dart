import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/utils/widgets/shimmer_loading/placeholders.dart';
import 'package:shimmer/shimmer.dart';

class CommonSimmer extends ConsumerWidget {
  const CommonSimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.white,
                height: 48,
              ),
              const TitlePlaceholder(width: double.infinity),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              const SizedBox(height: 16.0),
              const TitlePlaceholder(width: 200.0),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              const SizedBox(height: 16.0),
              const TitlePlaceholder(width: 200.0),
              const SizedBox(height: 16.0),
              const ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
