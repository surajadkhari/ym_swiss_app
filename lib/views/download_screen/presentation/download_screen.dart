import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lmiis/data/datasource/remote/dio/dio_client.dart';
import 'package:lmiis/views/about_us/data/model/about_us_model.dart';

import '../../../utils/AppConstants.dart';
import '../../../utils/colors_resource.dart';
import '../../../utils/dimensions.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  late Future<AboutUsModel> _future;
  @override
  void initState() {
    // TODO: implement initState
    _future = ApiClient().aboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsResource.PRAYMARY_TEXT_COLOR,
          elevation: 0,
          centerTitle: true,
          title: Text(
            style: const TextStyle(
                fontSize: Dimensions.BODY_20,
                fontWeight: Dimensions.FONT_BOLD,
                color: Colors.white),
   AppConstants.download,
          ),
        ),
        body: FutureBuilder<AboutUsModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Html(
                shrinkWrap: true,
                data: snapshot.data!.aboutUs,
                style: {
                  "p": Style(
                    lineHeight: const LineHeight(1.2),
                    fontSize: const FontSize(20.0),
                  ),
                  "body": Style(
                    lineHeight: const LineHeight(1),
                    fontSize: const FontSize(22.0),
                  )
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ));
  }
}
