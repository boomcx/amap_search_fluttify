import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:flutter/material.dart';

import '../widgets/dimens.dart';

class GetWeatherInfoScreen extends StatefulWidget {
  const GetWeatherInfoScreen({super.key});

  @override
  State<GetWeatherInfoScreen> createState() => _GetWeatherInfoScreenState();
}

class _GetWeatherInfoScreenState extends State<GetWeatherInfoScreen> {
  final _keywordController = TextEditingController(text: '杭州');

  String _district = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('获取天气数据')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _keywordController,
              decoration: const InputDecoration(hintText: '输入地区'),
            ),
            ElevatedButton(
              onPressed: () async {
                final district = await AmapSearch.instance
                    .searchDistrict(_keywordController.text);
                _district = district.toString();
                setState(() {});
              },
              child: const Text('搜索'),
            ),
            Expanded(child: SingleChildScrollView(child: Text(_district))),
          ],
        ),
      ),
    );
  }
}
