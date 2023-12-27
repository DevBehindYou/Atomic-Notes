// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotesBulder extends StatelessWidget {
  final String tittle;
  final String note;
  final String when;
  VoidCallback editFunction;
  final Function(BuildContext)? deleteFunction;

  NotesBulder({
    required this.tittle,
    required this.note,
    required this.when,
    required this.editFunction,
    required this.deleteFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: const Color(0xff3e3d4d),
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: editFunction,
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 5, top: 7),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tittle section
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade200),
                child: Text(
                  "Tittle: $tittle",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.0,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  note,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(
                height: 10,
                indent: 10,
                endIndent: 10,
                color: Colors.grey.shade400,
              ),

              // date + time
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300,
                      ),
                      child: Text(
                        "Created: $when",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
