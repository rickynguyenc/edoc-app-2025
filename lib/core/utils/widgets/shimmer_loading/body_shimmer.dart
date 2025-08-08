import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'placeholders.dart';

class BodyShimmerWidget extends HookConsumerWidget {
  const BodyShimmerWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 8),
            GridPlaceholder(
              height: 250,
            ),
            GridPlaceholder(
              height: 250,
            ),
            GridPlaceholder(
              height: 250,
            ),
            GridPlaceholder(
              height: 250,
            ),
            GridPlaceholder(
              height: 250,
            ),
            GridPlaceholder(
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
