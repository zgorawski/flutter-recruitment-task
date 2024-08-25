import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recruitment_task/design_system/design_system.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/filters/filters_cubit.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mainPadding,
      child: BlocConsumer<FiltersCubit, FiltersState>(
        listener: (context, state) {
          context.read<HomeCubit>().applyFilters(filters: state.allFilters);
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BigText('Filters'),
              const SizedBox(height: 16),
              _PriceRangeFilter(),
              const SizedBox(height: 16),
              _ShowBestOnlyFilter(),
              const SizedBox(height: 16),
              _ClearFiltersButton(),
            ],
          );
        },
      ),
    );
  }
}
