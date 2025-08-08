import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/utils/widgets/shimmer_loading/placeholders.dart';
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
      ),
    );
  }
}
