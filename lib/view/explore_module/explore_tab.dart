import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gowagr_assessment/utils/assets/fontStyle.dart';
import 'package:gowagr_assessment/widgets/customSizedBox.dart';
import 'package:gowagr_assessment/widgets/custom_textField.dart';
import 'package:provider/provider.dart';

import '../../provider/event_provider.dart';
import '../../utils/assets/colors.dart';
import 'component/combine_type_event_card.dart';
import 'component/single_type_event_card.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final scrollController = ScrollController();
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context.read<ExploreViewModel>().loadMoreEvents(context);
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ExploreViewModel>().searchEvents(query, context);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    _debounce?.cancel();
    _searchController.dispose();

    super.dispose();
  }

  String _getCategoryKey(String label) {
    if (label == 'Entertainment  🎶') {
      return 'Entertainment';
    } else if (label == 'Sports  ⚽️') {
      return 'Sports';
    } else {
      return label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          children: [
            CustomTextFormField(
              controller: _searchController,
              hintText: 'Search for a market',
              fillColor: backGroundColor,
              prefixIcon: const Icon(Icons.search_outlined, color: hintColor),
              borderSide: BorderSide(color: Color(0xff032B69), width: 0.4),
              onchange: (value) {
                onSearchChanged(value ?? '');
              },
            ),
            Spacing(20),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.categories.length,
                itemBuilder: (context, index) {
                  final category = viewModel.categories[index];
                  final isSelected =
                      _getCategoryKey(category.label) ==
                      viewModel.selectedCategory;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (category.label == 'Trending' &&
                              category.iconData != null) ...[
                            Icon(
                              category.iconData,
                              size: 20,
                              color: isSelected ? Colors.white : secondaryColor,
                            ),
                            const SizedBox(width: 8),
                          ],

                          Text(category.label),

                          if (category.label != 'Trending' &&
                              category.iconData != null) ...[
                            const SizedBox(width: 8),
                            Icon(
                              category.iconData,
                              size: 20,
                              color: isSelected ? Colors.white : secondaryColor,
                            ),
                          ],
                        ],
                      ),
                      selected: isSelected,
                      showCheckmark: false,
                      onSelected: (_) {
                        viewModel.changeCategory(
                          _getCategoryKey(category.label),
                          context,
                        );
                      },
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : secondaryColor,
                      ),
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                    ),
                  );
                },
              ),
            ),

            Spacing(30),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (viewModel.isLoading && viewModel.events.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (viewModel.isError && viewModel.events.isEmpty) {
                    return Center(
                      child: Text(
                        'Failed to load events.\nPlease check your connection.',
                        textAlign: TextAlign.center,
                        style: AppFontFam.appFontStyle.copyWith(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  if (viewModel.events.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No events found',
                            style: AppFontFam.appFontStyle.copyWith(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try a different search or category.',
                            style: AppFontFam.appFontStyle.copyWith(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await viewModel.refresh(context);
                    },
                    backgroundColor: Colors.white,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount:
                          viewModel.events.length + (viewModel.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < viewModel.events.length) {
                          return viewModel.events[index].type == 'SINGLE_MARKET'
                              ? SingleTypeEventCard(
                                  event: viewModel.events[index],
                                )
                              : CombineTypeEventCard(
                                  event: viewModel.events[index],
                                );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
