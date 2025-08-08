import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class DataGridShimmer extends HookConsumerWidget {
  const DataGridShimmer({super.key});
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
