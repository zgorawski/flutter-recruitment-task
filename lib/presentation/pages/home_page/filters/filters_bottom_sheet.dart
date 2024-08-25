import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_recruitment_task/design_system/design_system.dart';
import 'package:flutter_recruitment_task/models/product_filters.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/filters/filters_cubit.dart';
import 'package:flutter_recruitment_task/presentation/pages/home_page/home_cubit.dart';
import 'package:flutter_recruitment_task/presentation/widgets/big_text.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Padding(
          padding: mainPadding,
          child: BlocConsumer<FiltersCubit, FiltersState>(
            listener: (context, state) {
              context.read<HomeCubit>().applyFilters(filters: state.allFilters);
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BigText('Filters'),
                  const SizedBox(height: 16),
                  _PriceRangeFilterWidget(state.priceRangeFilter),
                  const SizedBox(height: mainGap),
                  _ShowBestOfferFilter(state.bestOnlyFilter),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PriceRangeFilterWidget extends HookWidget {
  const _PriceRangeFilterWidget(this.priceRangeFilter);

  final PriceRangeFilter? priceRangeFilter;

  @override
  Widget build(BuildContext context) {
    final fromTextEditingController =
        useTextEditingController(text: priceRangeFilter?.priceRange.from.toStringAsFixed(2));
    final toTextEditingController = useTextEditingController(text: priceRangeFilter?.priceRange.to.toStringAsFixed(2));
    final validationMessage = useState<String?>(null);

    void onTextsChange() {
      final from = double.tryParse(fromTextEditingController.text);
      final to = double.tryParse(toTextEditingController.text);

      validationMessage.value = _validatePriceRange(from, to);

      if (validationMessage.value != null) {
        return;
      }

      if (from == null && to == null) {
        context.read<FiltersCubit>().clearPriceRange();
      } else {
        context.read<FiltersCubit>().setPriceRange((from: from ?? 0, to: to ?? double.infinity));
      }
    }

    useEffect(() {
      fromTextEditingController.addListener(onTextsChange);
      toTextEditingController.addListener(onTextsChange);
      return () {
        fromTextEditingController.removeListener(onTextsChange);
        toTextEditingController.removeListener(onTextsChange);
      };
    }, [fromTextEditingController, toTextEditingController]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Price range:'),
        const SizedBox(height: mainGap),
        Row(
          children: [
            if (priceRangeFilter != null)
              Checkbox(
                value: true,
                onChanged: (_) {
                  fromTextEditingController.text = '';
                  toTextEditingController.text = '';
                },
              ),
            Flexible(
              child: _PriceTextField(
                labelText: 'From',
                controller: fromTextEditingController,
              ),
            ),
            const SizedBox(width: mainGap),
            Flexible(
              child: _PriceTextField(
                labelText: 'To',
                controller: toTextEditingController,
              ),
            ),
          ],
        ),
        if (validationMessage.value != null) Text(validationMessage.value!, style: const TextStyle(color: Colors.red)),
      ],
    );
  }

  String? _validatePriceRange(double? from, double? to) {
    if (from != null && to != null && from > to) {
      return 'From must be less than to';
    } else {
      return null;
    }
  }
}

class _PriceTextField extends TextField {
  _PriceTextField({
    String? labelText,
    required super.controller,
  }) : super(
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d{1,10}([,.]\d{0,2})?')),
          ],
        );
}

class _ShowBestOfferFilter extends StatelessWidget {
  const _ShowBestOfferFilter(this.bestOfferFilter);

  final BestOfferFilter? bestOfferFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: bestOfferFilter != null, onChanged: (value) => context.read<FiltersCubit>().setShowBestOnly(value!)),
        const SizedBox(width: mainGap),
        const Expanded(child: Text('Show best only'))
      ],
    );
  }
}
