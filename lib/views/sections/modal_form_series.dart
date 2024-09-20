import 'package:flutter/material.dart';
import 'package:my_series_list/views/components/input_text.dart';
import 'package:my_series_list/views/components/select_tag.dart';

class ModalFormSeries extends StatelessWidget {
  const ModalFormSeries({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          scrollControlDisabledMaxHeightRatio: 0.9,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "New serie",
                    style: TextStyle(fontSize: 20),
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputText(
                          labelText: "Name",
                          onChanged: (value) {},
                        ),
                        InputText(
                          labelText: "Description",
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {},
                        ),
                        InputText(
                          labelText: "URL",
                          keyboardType: TextInputType.url,
                          onChanged: (value) {},
                        ),
                        SelectTag(
                          labelText: "Tags",
                          onChanged: (value) {},
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: const Text("Save",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
