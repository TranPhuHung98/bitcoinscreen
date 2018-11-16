import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:test_candlechart/status_value.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

List<List<CircularStackEntry>> _quarterlyProfitPieData(double percent) {
  return [
    <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(percent, Colors.orange[300]),
          CircularSegmentEntry(100.0 - percent, Colors.grey[350]),
        ],
      ),
    ],
  ];
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _chartSize = const Size(200.0, 200.0);
  final bitcoinPrice = '5,542.40';
  var color = Colors.purple[900];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Bitcoin'),
          backgroundColor: color,
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '\$110,497.46',
                  style: TextStyle(color: Colors.blue, fontSize: 24.0),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                child: Text(
                  '0.36529659 BTC',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            padding: EdgeInsets.only(bottom: 0.0),
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  AnimatedCircularChart(
                    size: _chartSize,
                    initialChartData: _quarterlyProfitPieData(67.47)[0],
                    chartType: CircularChartType.Pie,
                  ),
                  CircleAvatar(
                    child: Image.asset('image/bitcoin.png'),
                    radius: 60.0,
                  )
                ],
              ),
            ),
          )),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => statusData[index].initWidget(),
              childCount: statusData.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(right: 15.0, left: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: RaisedButton(
                          child: Text(
                            'BUY BTC',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: color,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: RaisedButton(
                          child: Text(
                            'SELL BTC',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: color,
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 30.0,
              color: Colors.black,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Text(
                    'BITCOIN PRICE',
                    style: TextStyle(fontSize: 20.0),
                  )),
                  Container(
                      child: Text(
                    '\$$bitcoinPrice',
                    style: TextStyle(color: color, fontSize: 24.0),
                  ))
                ],
              ),
            ),
          )
        ]));
  }

  var statusData = [
    StatusValueModel(title: 'AVERAGE PRICE', value: 6280.65),
    StatusValueModel(title: 'ALLOCATION', value: 67.47),
    StatusValueModel(
        title: 'TOTAL RETURN',
        valueStatus: ValueStatus.decrease,
        value: 269.68),
    StatusValueModel(
        title: 'TOTAL RETURN',
        percentStatus: PercentStatus.decrease,
        value: 11.75),
  ];
}
