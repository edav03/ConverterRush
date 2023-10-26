import 'dart:io';
import 'dart:math';

import 'package:converterrush/config/themes/color_schemes.dart';
import 'package:converterrush/db/pages_data_db.dart';
import 'package:converterrush/entities/PagesData/pages_data.dart';
import 'package:converterrush/widgets/custom_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<PageData> pagesData = [];
  bool isLoading = false;
  final buttonBackgroundColor = defaultLightTheme.surfaceTint;
  final buttonTextColor = defaultDarkTheme.onSecondaryContainer;

  @override
  void initState() {
    super.initState();
    refreshHtml();
  }

  refreshHtml() async {
    setState(() => isLoading = true);
    pagesData.addAll(await PagesDataDB.instance.getAllPagesData());
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          (pagesData.isEmpty)
              ? const Center(
                  child: Text('No existe contenido en la base de datos'),
                )
              : Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: pagesData.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: CustomContainer(
                            placeHolder: 'Pagina ${pagesData[index].id}',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                'htmlScreen',
                                arguments: {'id': pagesData[index].id},
                              );
                            },
                            backgroundColor: buttonBackgroundColor,
                            textColor: buttonTextColor,
                            minimumSize:
                                MaterialStateProperty.all(const Size(150, 90)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: CustomContainer(
              placeHolder: 'Subir archivo...',
              onPressed: () {
                pickFile(pagesData);
                setState(() {});
              },
              backgroundColor: defaultLightTheme.onSecondaryContainer,
              textColor: defaultLightTheme.onSecondary,
              minimumSize: MaterialStateProperty.all(const Size(150, 90)),
            ),
          ),
        ],
      ),
    );
  }

  void pickFile(List<PageData> pagesData) async {
    int newId = Random().nextInt(10000);
    try {
      // FilePickerResult? result = await FilePicker.platform
      //     .pickFiles(allowMultiple: false, allowedExtensions: ['txt']);
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result != null) {
        File file = File(result.files.single.path!);
        String contents = await file.readAsString();
        if (pagesData.isEmpty) {
          newId = 0;
        } else {
          List<int> ids = pagesData.map((pageData) => pageData.id).toList()
            ..sort();
          newId = ids.last + 1;
        }
        PageData pageData = PageData(id: newId, htmlContent: contents);
        PagesDataDB.instance.create(pageData);
        refreshHtml();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error al subir el archivo'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Aceptar"),
              ),
            ],
          );
        },
      );
    }
  }
}
