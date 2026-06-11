import 'package:flutter/material.dart';

const SPACE_NORMAL = SizedBox(width: 8, height: 8);
const kDividerTiny = Divider(height: 1);

class ContinuousSetting extends StatefulWidget {
  const ContinuousSetting({
    super.key,
    required this.head,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
  });

  final String head;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  State<ContinuousSetting> createState() => _ContinuousSettingState();
}

class _ContinuousSettingState extends State<ContinuousSetting> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.head, style: Theme.of(context).textTheme.titleMedium),
          SPACE_NORMAL,
          Slider(
            value: _value,
            min: widget.min,
            max: widget.max,
            onChanged: (_) {},
            onChangeEnd: (value) {
              setState(() {
                _value = value;
                widget.onChanged(value);
              });
            },
          ),
          kDividerTiny,
        ],
      ),
    );
  }
}

class DiscreteSetting extends StatelessWidget {
  const DiscreteSetting({
    super.key,
    required this.head,
    required this.options,
    required this.onSelected,
  });

  final String head;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PopupMenuButton<String>(
          onSelected: onSelected,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(head, style: Theme.of(context).textTheme.titleMedium),
          ),
          itemBuilder: (context) {
            return options
                .map((value) => PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList();
          },
        ),
        kDividerTiny,
      ],
    );
  }
}

class ColorSetting extends StatelessWidget {
  const ColorSetting({
    super.key,
    required this.head,
    required this.onSelected,
  });

  final String head;
  final ValueChanged<Color?> onSelected;

  @override
  Widget build(BuildContext context) {
    return DiscreteSetting(
      head: head,
      options: const ['绿色', '红色', '黄色'],
      onSelected: (value) {
        Color? color;
        switch (value) {
          case '绿色':
            color = Colors.green.withValues(alpha: 0.6);
          case '红色':
            color = Colors.red.withValues(alpha: 0.6);
          case '黄色':
            color = Colors.yellow.withValues(alpha: 0.6);
        }

        onSelected(color);
      },
    );
  }
}

class BooleanSetting extends StatefulWidget {
  const BooleanSetting({
    super.key,
    required this.head,
    required this.onSelected,
    this.selected = false,
  });

  final String head;
  final ValueChanged<bool> onSelected;
  final bool selected;

  @override
  State<BooleanSetting> createState() => _BooleanSettingState();
}

class _BooleanSettingState extends State<BooleanSetting> {
  late bool _selected;

  @override
  void initState() {
    super.initState();

    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: Text(widget.head),
          value: _selected,
          onChanged: (selected) {
            setState(() {
              _selected = selected;
              widget.onSelected(selected);
            });
          },
        ),
        kDividerTiny,
      ],
    );
  }
}

class TextSetting extends StatelessWidget {
  final String leadingString;
  final String hintString;

  const TextSetting({
    super.key,
    required this.leadingString,
    required this.hintString,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(leadingString),
      title: TextFormField(
        decoration: InputDecoration(
          hintText: hintString,
        ),
      ),
    );
  }
}
