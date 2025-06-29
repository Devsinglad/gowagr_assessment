import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/public_event_res.dart';
import '../../../utils/assets/colors.dart';
import '../../../utils/assets/fontStyle.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/customSizedBox.dart';

class SingleTypeEventCard extends StatelessWidget {
  const SingleTypeEventCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    var eventData = event.markets.first;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: liteGreyColor,
                  backgroundImage: NetworkImage(event.imageUrl),
                ),
                Expanded(
                  child: Text(
                    event.title,
                    style: AppFontFam.appFontStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 4,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const Spacing(20),

            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomAppButton(
                    isActive: true,
                    title:
                        'Buy Yes - ₦${(eventData.yesBuyPrice * 100).round()}',
                    textColor: primaryColor,
                    broderColor: primaryColor.withValues(alpha: 0.2),
                    color: buyColor.withValues(alpha: 0.05),
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: CustomAppButton(
                    isActive: true,
                    title: 'Buy No - ₦${(eventData.noBuyPrice * 100).round()}',
                    textColor: buttonRed,
                    broderColor: buttonRed.withValues(alpha: 0.2),
                    color: buttonRed.withValues(alpha: 0.05),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacing(10),

            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₦${eventData.yesPriceForEstimate}K",
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: mediumTextColor,
                        ),
                      ),
                      Text(
                        "→",
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: mediumTextColor,
                        ),
                      ),
                      Text(
                        "₦${eventData.yesProfitForEstimate}K",
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₦${eventData.noPriceForEstimate}K",
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: mediumTextColor,
                        ),
                      ),
                      Text(
                        "→",
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: mediumTextColor,
                        ),
                      ),
                      Text(
                        "₦${eventData.noProfitForEstimate}K",
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacing(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.bar_chart, color: mediumTextColor, size: 15),
                    Text(
                      "${(event.totalVolume).round()} Trades",
                      style: AppFontFam.appFontStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: mediumTextColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 3,
                  children: [
                    Text(
                      "Ends ${DateFormat('d MMM').format(event.resolutionDate ?? DateTime.now())}.",
                      style: AppFontFam.appFontStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: mediumTextColor,
                      ),
                    ),
                    Icon(
                      Icons.bookmark_border,
                      color: mediumTextColor,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
