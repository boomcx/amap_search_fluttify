import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:amap_search_fluttify_example/widgets/function_item.widget.dart';
import 'package:core_location_fluttify/core_location_fluttify.dart';
import 'package:flutter/material.dart';

import '../widgets/dimens.dart';

class GetAddressDescScreen extends StatelessWidget {
  const GetAddressDescScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('获取地址描述数据')),
      body: ListView(
        children: <Widget>[
          FunctionItem(
            label: '地理编码（地址转坐标）',
            sublabel: 'AddressEncodeScreen',
            target: AddressEncodeScreen(),
          ),
          FunctionItem(
            label: '逆地理编码（坐标转地址）',
            sublabel: 'AddressDecodeScreen',
            target: AddressDecodeScreen(),
          ),
        ],
      ),
    );
  }
}

class AddressEncodeScreen extends StatefulWidget {
  const AddressEncodeScreen({super.key});

  @override
  State<AddressEncodeScreen> createState() => _AddressEncodeScreenState();
}

class _AddressEncodeScreenState extends State<AddressEncodeScreen> {
  final _keywordController = TextEditingController(text: '阿里巴巴');
  final _cityController = TextEditingController(text: '杭州');

  List<Geocode> _geocodeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('地理编码（地址转坐标）')),
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
                final geocodeList = await AmapSearch.instance.searchGeocode(
                  _keywordController.text,
                  city: _cityController.text,
                );
                setState(() {
                  _geocodeList = geocodeList;
                });
              },
              child: const Text('搜索'),
            ),
            if (_geocodeList.isNotEmpty) Text(_geocodeList.toString()),
          ],
        ),
      ),
    );
  }
}

class AddressDecodeScreen extends StatefulWidget {
  const AddressDecodeScreen({super.key});

  @override
  State<AddressDecodeScreen> createState() => _AddressDecodeScreenState();
}

class _AddressDecodeScreenState extends State<AddressDecodeScreen> {
  final _latController = TextEditingController(text: '39.9824');
  final _lngController = TextEditingController(text: '116.3053');
  final _radiusController = TextEditingController(text: '200.0');

  ReGeocode? _reGeocode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('逆地理编码（坐标转地址）')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    controller: _latController,
                    decoration: const InputDecoration(hintText: '输入纬度'),
                  ),
                ),
                const SizedBox(width: kSpace8),
                Flexible(
                  child: TextFormField(
                    controller: _lngController,
                    decoration: const InputDecoration(hintText: '输入经度'),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _radiusController,
              decoration: const InputDecoration(hintText: '输入范围半径'),
            ),
            ElevatedButton(
              onPressed: () async {
                final reGeocodeList = await AmapSearch.instance.searchReGeocode(
                  LatLng(
                    double.parse(_latController.text),
                    double.parse(_lngController.text),
                  ),
                  radius: 200.0,
                );
                setState(() {
                  _reGeocode = reGeocodeList;
                });
              },
              child: const Text('搜索'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_reGeocode?.toString() ?? ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
