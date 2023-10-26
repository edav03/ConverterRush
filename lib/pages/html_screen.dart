import 'package:flutter/material.dart';
import 'package:converterrush/db/pages_data_db.dart';
import 'package:converterrush/entities/PagesData/pages_data.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HTMLScreen extends StatefulWidget {
  const HTMLScreen({super.key});

  @override
  State<HTMLScreen> createState() => _HTMLScreenState();
}

class _HTMLScreenState extends State<HTMLScreen> {
  PageData? pageData;
  int? tableId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      tableId = arguments['id'];
      refreshHtml(tableId!);
    });
  }

  refreshHtml(int tableId) async {
    setState(() => isLoading = true);
    pageData = await PagesDataDB.instance.getPageData(tableId);
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
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : (pageData != null)
                ? buildPage(pageData!)
                : const Text('No existe HTML'),
      ),
    );
  }
}

Widget buildPage(PageData pageData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SingleChildScrollView(
      child: HtmlWidget(
        pageData.htmlContent!,
      ),
    ),
  );
}
