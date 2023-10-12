import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionsSection extends StatelessWidget {
  const NutritionsSection({
    Key? key,
    required this.nutritionsList,
  }) : super(key: key);
  final List nutritionsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nutritions".tr,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 20),
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 10)),
                itemCount: nutritionsList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        "${nutritionsList[index].name}: ",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        "${nutritionsList[index].amount?.toStringAsFixed(1)}${nutritionsList[index].unit}",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
