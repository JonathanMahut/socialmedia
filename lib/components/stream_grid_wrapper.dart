import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/indicators.dart';

typedef ItemBuilder<T> = Widget Function(
  BuildContext context,
  DocumentSnapshot doc,
);

class StreamGridWrapper extends StatelessWidget {
  final Stream<QuerySnapshot<Object?>>? stream;
  final ItemBuilder<DocumentSnapshot> itemBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final EdgeInsets padding;

  const StreamGridWrapper({
    super.key,
    required this.stream,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics = const ClampingScrollPhysics(),
    this.padding = const EdgeInsets.only(bottom: 2.0, left: 2.0),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = snapshot.data!.docs.toList();
          return list.isEmpty
              ? Container(
                  child: const Center(
                    child: Text('No Posts'),
                  ),
                )
              : GridView.builder(
                  padding: padding,
                  scrollDirection: scrollDirection,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 3,
                  ),
                  itemCount: list.length,
                  shrinkWrap: shrinkWrap,
                  physics: physics,
                  itemBuilder: (BuildContext context, int index) {
                    return itemBuilder(context, list[index]);
                  },
                );
        } else {
          return circularProgress(context);
        }
      },
    );
  }
}
