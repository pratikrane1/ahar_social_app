import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserSearchResultList extends StatelessWidget {
  UserSearchResultList({
    Key? key,
    required this.searchName,
    required this.snapshot,
  }) : super(key: key);
  String searchName;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    searchName = searchName.toLowerCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchName.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Text('Suggestions'),
              )
            : const SizedBox(),
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
