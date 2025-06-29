import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/public_event_res.dart';
import '../../../utils/assets/colors.dart';
import '../../../utils/assets/fontStyle.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/customSizedBox.dart';

class CombineTypeEventCard extends StatelessWidget {
  const CombineTypeEventCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: liteGreyColor,
                  backgroundImage: NetworkImage(event.imageUrl),
                ),
                const SizedBox(width: 10),
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

            /// Markets List
            ...event.markets.asMap().entries.map((entry) {
              var marketData = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        marketData.title,
                        style: AppFontFam.appFontStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: mediumTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomAppButton(
                              width: 158,
                              isActive: true,
                              title:
                                  'Yes ₦${(marketData.yesBuyPrice * 100).round()}',
                              textColor: primaryColor,
                              broderColor: primaryColor.withValues(alpha: 0.2),
                              color: buyColor.withValues(alpha: 0.05),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomAppButton(
                              width: 158,
                              isActive: true,
                              title:
                                  'No ₦${(marketData.noBuyPrice * 100).round()}',
                              textColor: buttonRed,
                              broderColor: buttonRed.withValues(alpha: 0.2),
                              color: buttonRed.withValues(alpha: 0.05),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const Spacing(10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.signal_cellular_alt,
                      color: mediumTextColor,
                      size: 15,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "₦${(event.totalVolume)}M",
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
                  children: [
                    Text(
                      "Ends ${DateFormat('d MMM').format(event.resolutionDate ?? DateTime.now())}.",
                      style: AppFontFam.appFontStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: mediumTextColor,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.favorite_border,
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
