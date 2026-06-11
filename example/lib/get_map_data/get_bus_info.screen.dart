import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:amap_search_fluttify_example/widgets/scrollable_text.widget.dart';
import 'package:flutter/material.dart';

import '../widgets/dimens.dart';

class GetBusInfoScreen extends StatefulWidget {
  const GetBusInfoScreen({super.key});

  @override
  State<GetBusInfoScreen> createState() => _GetBusInfoScreenState();
}

class _GetBusInfoScreenState extends State<GetBusInfoScreen> {
  final _keywordController = TextEditingController(text: '武林广场');
  final _cityController = TextEditingController(text: '杭州');

  String _busStation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('获取公交数据')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _keywordController,
              decoration: const InputDecoration(hintText: '输入公交站点名称'),
            ),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(hintText: '输入城市'),
            ),
            ElevatedButton(
              onPressed: () async {
                final busStation = await AmapSearch.instance.searchBusStation(
                  stationName: _keywordController.text,
                  city: _cityController.text,
                );
                _busStation = await busStation.toFutureString();
                setState(() {});
              },
              child: const Text('搜索'),
            ),
            Expanded(child: ScrollableText(_busStation)),
          ],
        ),
      ),
    );
  }
}
