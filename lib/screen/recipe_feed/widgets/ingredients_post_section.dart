import 'package:flutter/material.dart';

class IngredientsPostSection extends StatelessWidget {
  const IngredientsPostSection({
    Key? key,
    required this.ingredients,
  }) : super(key: key);
  final List ingredients;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Elements",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 20),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, index) {
                return const SizedBox(height: 10);
              },
              primary: false,
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                return Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Expanded(
                      child: Text(
                        '${ingredients[index]}',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 15, height: 1.6),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
