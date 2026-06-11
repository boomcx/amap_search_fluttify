import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:amap_search_fluttify_example/widgets/function_item.widget.dart';
import 'package:amap_search_fluttify_example/widgets/scrollable_text.widget.dart';
import 'package:core_location_fluttify/core_location_fluttify.dart';
import 'package:flutter/material.dart';

import '../widgets/dimens.dart';

class GetPoiScreen extends StatelessWidget {
  const GetPoiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('获取POI数据')),
      body: ListView(
        children: <Widget>[
          FunctionItem(
            label: '关键字检索POI',
            sublabel: 'KeywordPoiScreen',
            target: KeywordPoiScreen(),
          ),
          FunctionItem(
            label: '周边检索POI',
            sublabel: 'AroundPoiScreen',
            target: AroundPoiScreen(),
          ),
          FunctionItem(
            label: '输入提示',
            sublabel: 'InputTipScreen',
            target: InputTipScreen(),
          ),
        ],
      ),
    );
  }
}

class KeywordPoiScreen extends StatefulWidget {
  const KeywordPoiScreen({super.key});

  @override
  State<KeywordPoiScreen> createState() => _KeywordPoiScreenState();
}

class _KeywordPoiScreenState extends State<KeywordPoiScreen> {
  final _keywordController = TextEditingController(text: '肯德基');
  final _cityController = TextEditingController(text: '杭州');
  int _page = 1;

  List<String> _poiTitleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('关键字检索POI')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _keywordController,
              decoration: const InputDecoration(hintText: '输入关键字'),
            ),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(hintText: '输入城市'),
            ),
            ElevatedButton(
              onPressed: () async {
                final poiList = await AmapSearch.instance.searchKeyword(
                  _keywordController.text,
                  city: _cityController.text,
                );

                setState(() {
                  _poiTitleList = poiList.map((it) => it.toString()).toList();
                });
              },
              child: const Text('搜索'),
            ),
            ElevatedButton(
              onPressed: () async {
                final poiList = await AmapSearch.instance.searchKeyword(
                  _keywordController.text,
                  city: _cityController.text,
                  page: ++_page,
                );

                setState(() {
                  _poiTitleList = poiList.map((it) => it.toString()).toList();
                });
              },
              child: const Text('下一页'),
            ),
            Expanded(child: ScrollableText(_poiTitleList.join("\n"))),
          ],
        ),
      ),
    );
  }
}

class AroundPoiScreen extends StatefulWidget {
  const AroundPoiScreen({super.key});

  @override
  State<AroundPoiScreen> createState() => _AroundPoiScreenState();
}

class _AroundPoiScreenState extends State<AroundPoiScreen> {
  final _keywordController = TextEditingController();
  final _typeController = TextEditingController();
  final _latController = TextEditingController(text: '29.08');
  final _lngController = TextEditingController(text: '119.65');
  int _page = 1;

  List<String> _poiTitleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('周边检索POI')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _keywordController,
              decoration: const InputDecoration(hintText: '输入关键字'),
            ),
            TextFormField(
              controller: _typeController,
              decoration: const InputDecoration(hintText: '输入类别'),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _latController,
                    decoration: const InputDecoration(hintText: '输入纬度'),
                  ),
                ),
                SPACE_4_HORIZONTAL,
                Flexible(
                  child: TextField(
                    controller: _lngController,
                    decoration: const InputDecoration(hintText: '输入经度'),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final poiList = await AmapSearch.instance.searchAround(
                  LatLng(
                    double.tryParse(_latController.text) ?? 29.08,
                    double.tryParse(_lngController.text) ?? 119.65,
                  ),
                  keyword: _keywordController.text,
                  type: _typeController.text,
                );

                setState(() {
                  _poiTitleList = poiList.map((it) => it.toString()).toList();
                });
              },
              child: const Text('搜索'),
            ),
            ElevatedButton(
              onPressed: () async {
                final poiList = await AmapSearch.instance.searchAround(
                  LatLng(
                    double.tryParse(_latController.text) ?? 29.08,
                    double.tryParse(_lngController.text) ?? 119.65,
                  ),
                  keyword: _keywordController.text,
                  type: _typeController.text,
                  page: ++_page,
                );

                setState(() {
                  _poiTitleList = poiList.map((it) => it.toString()).toList();
                });
              },
              child: const Text('下一页'),
            ),
            Expanded(child: ScrollableText(_poiTitleList.join("\n"))),
          ],
        ),
      ),
    );
  }
}

class InputTipScreen extends StatefulWidget {
  const InputTipScreen({super.key});

  @override
  State<InputTipScreen> createState() => _InputTipScreenState();
}

class _InputTipScreenState extends State<InputTipScreen> {
  final _keywordController = TextEditingController(text: '肯德基');
  final _cityController = TextEditingController(text: '杭州');

  List<InputTip> _inputTipList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('输入内容自动提示')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _keywordController,
              decoration: const InputDecoration(hintText: '输入关键字'),
            ),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(hintText: '输入所在城市'),
            ),
            ElevatedButton(
              onPressed: () async {
                final inputTipList = await AmapSearch.instance.fetchInputTips(
                  _keywordController.text,
                  city: _cityController.text,
                );

                setState(() => _inputTipList = inputTipList);
              },
              child: const Text('搜索'),
            ),
            Expanded(child: ScrollableText(_inputTipList.join("\n"))),
          ],
        ),
      ),
    );
  }
}
