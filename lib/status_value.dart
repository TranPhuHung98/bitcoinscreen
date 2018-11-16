import 'package:flutter/material.dart';

enum ValueStatus { increase, decrease, none }
enum PercentStatus { increase, decrease, none }

class StatusValueModel {
  final String title;
  final String value;
  final ValueStatus valueStatus;
  final PercentStatus percentStatus;
  StatusValueModel(
      {this.title,
      this.value,
      this.valueStatus: ValueStatus.none,
      this.percentStatus: PercentStatus.none});

  StatusValue initWidget() {
    if (percentStatus == PercentStatus.none &&
        valueStatus == ValueStatus.none) {
      // mean no change
      return StatusValue.averagePriceAndAllocaion(title,value);
    }
    switch (percentStatus) {
      case PercentStatus.increase:
        return StatusValue.increasePercent(title, value);
      case PercentStatus.decrease:
        return StatusValue.decreasePercent(title, value);
      default:
        break;
    }
    switch (valueStatus) {
      case ValueStatus.increase:
        return StatusValue.increaseValue(title, value);
      case ValueStatus.decrease:
        return StatusValue.decreaseValue(title, value);
      default:
        break;
    }
    return StatusValue();
  }
}

///
/// Status up/down, place at below Donut chart
class StatusValue extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  const StatusValue({Key key, this.title, this.subTitle}) : super(key: key);

  static StatusValue averagePriceAndAllocaion(String title, String price) => StatusValue(
        title: Text(
          '$title',
          style: TextStyle(color: Colors.grey),
        ),
        subTitle: title=='AVERAGE PRICE'?Text('\$$price'):Text('$price%'),
      );

  static StatusValue allocation(String title,String percent) => StatusValue(
        title: Text(
          '$title',
          style: TextStyle(color: Colors.grey),
        ),
        subTitle: Text('$percent%'),
      );
  static StatusValue increaseValue(String title, String value) => StatusValue(
        title: Text(
          '$title',
          style: TextStyle(color: Colors.grey),
        ),
        subTitle: Text(
          '▴\$$value',
          style: TextStyle(color: Colors.green),
        ),
      );

  static StatusValue decreaseValue(String title, String value) => StatusValue(
        title: Text(
          '$title',
          style: TextStyle(color: Colors.grey),
        ),
        subTitle: Text(
          '▾-\$$value',
          style: TextStyle(color: Colors.red),
        ),
      );
  static StatusValue decreasePercent(String title, String percent) =>
      StatusValue(
        title: Text(
          '$title',
          style: TextStyle(color: Colors.grey),
        ),
        subTitle: Text(
          '▾$percent%',
          style: TextStyle(color: Colors.red),
        ),
      );
  static StatusValue increasePercent(String title, String percent) =>
      StatusValue(
        title: Text(
          '$title',
          style: TextStyle(color: Colors.grey),
        ),
        subTitle: Text(
          '▴$percent%',
          style: TextStyle(color: Colors.red),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey[400]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          title ?? Container(),
          subTitle ?? Container(),
        ],
      ),
    );
  }
}
