import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:core_location_fluttify/core_location_fluttify.dart';
import 'package:flutter/material.dart';

import '../widgets/dimens.dart';

class RouteBusScreen extends StatefulWidget {
  const RouteBusScreen({super.key});

  @override
  State<RouteBusScreen> createState() => _RouteBusScreenState();
}

class _RouteBusScreenState extends State<RouteBusScreen> {
  final _fromLatController = TextEditingController(text: '30.219933');
  final _fromLngController = TextEditingController(text: '120.023728');

  final _toLatController = TextEditingController(text: '30.27065');
  final _toLngController = TextEditingController(text: '120.163117');

  String _routeResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('公交路线规划')),
      body: Padding(
        padding: const EdgeInsets.all(kSpace16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('起点:'),
                const SizedBox(width: kSpace8),
                Flexible(
                  child: TextFormField(
                    controller: _fromLatController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '输入出发点纬度'),
                  ),
                ),
                const SizedBox(width: kSpace8),
                Flexible(
                  child: TextFormField(
                    controller: _fromLngController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '输入出发点经度'),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('终点:'),
                const SizedBox(width: kSpace8),
                Flexible(
                  child: TextFormField(
                    controller: _toLatController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '输入终点纬度'),
                  ),
                ),
                const SizedBox(width: kSpace8),
                Flexible(
                  child: TextFormField(
                    controller: _toLngController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '输入终点经度'),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final routeResult = await AmapSearch.instance.searchBusRoute(
                  from: LatLng(
                    double.parse(_fromLatController.text),
                    double.parse(_fromLngController.text),
                  ),
                  to: LatLng(
                    double.parse(_toLatController.text),
                    double.parse(_toLngController.text),
                  ),
                  city: '杭州',
                );
                routeResult
                    .toFutureString()
                    .then((it) => setState(() => _routeResult = it));
              },
              child: const Text('搜索'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_routeResult),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
