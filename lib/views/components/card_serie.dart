import 'package:flutter/material.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/views/components/chip_tags.dart';
import 'package:my_series_list/views/components/confirm_delete_dialog.dart';

class CardSerie extends StatelessWidget {
  final Series series;
  final void Function(Series)? onDelete;

  const CardSerie({
    super.key,
    required this.series,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(series.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete?.call(series);
      },
      background: _backgroundDelete(),
      confirmDismiss: (direction) {
        return showConfirmDelete(context);
      },
      child: _cardSerie(context),
    );
  }

  Future<bool?> showConfirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ConfirmDeleteDialog(
          textTitle: "Delete ${series.name}",
          textContent: "Are you sure you want to delete this series?",
        );
      },
    );
  }

  Card _cardSerie(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(33, 150, 243, 1),
      child: ListTile(
        title: Text(
          series.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Wrap(
          spacing: 5,
          children: series.tags
              .sublist(
                0,
                series.tags.length > 5 ? 5 : series.tags.length,
              )
              .map((tag) => ChipTag(tag: tag))
              .toList(),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            "/series",
            arguments: {
              "series": series,
            },
          );
        },
      ),
    );
  }

  Card _backgroundDelete() {
    return const Card.filled(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.delete, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}
