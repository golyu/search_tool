import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/CodeBean.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'tell call'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<CodeBean> smartDataList;

  _MyHomePageState() {
    this.initSmart();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
//      this._launchURL();
    });
  }

  // 初始化smart卡的代码
  void initSmart() {
    smartDataList = new List();
    smartDataList.add(new CodeBean.smart("*888#", CodeBean.TYPE_SEARCH, "查询话费", "哈哈哈"));
    smartDataList.add(new CodeBean.smart("*087*0#", CodeBean.TYPE_CLOSE, "停用流量", "哈哈"));
    smartDataList.add(new CodeBean.smart("*087*101#", CodeBean.TYPE_OPEN, "1\$换500M流量 30天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*087*300#", CodeBean.TYPE_OPEN, "3\$换2G流量 30天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*087*500#", CodeBean.TYPE_OPEN, "5\$换4G流量 30天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*087*1000#", CodeBean.TYPE_OPEN, "10\$换8.5G流量 30天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*087*888#", CodeBean.TYPE_SEARCH, "查询087套餐", "哈哈"));
    smartDataList.add(new CodeBean.smart("*700*100#", CodeBean.TYPE_OPEN, "1\$换125\$(=5GB流量) 7天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*700*200#", CodeBean.TYPE_OPEN, "2\$换10G流量 7天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*700*800#", CodeBean.TYPE_OPEN, "8\$换40G流量 30天", "哈哈"));
    smartDataList.add(new CodeBean.smart("*700*888#", CodeBean.TYPE_SEARCH, "查询换购的余额和终止日期", "哈哈"));
    smartDataList.add(new CodeBean.smart("*656*100#", CodeBean.TYPE_OPEN, "1\$换30\$ 7天,网速快,自动续费", "哈哈"));
    smartDataList.add(new CodeBean.smart("*656*0#", CodeBean.TYPE_SEARCH, "查询流量656套餐", "哈哈"));
    smartDataList.add(new CodeBean.smart("*1333#", CodeBean.TYPE_OPEN, "1\$换333\$,7天,网速慢,自动续费", "哈哈"));
    smartDataList.add(new CodeBean.smart("*1333*888#", CodeBean.TYPE_SEARCH, "查询1333套餐", "哈哈"));
    smartDataList.add(new CodeBean.smart("*203#", CodeBean.TYPE_OPEN, "开通超长待机", "哈哈"));
    print(smartDataList);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
        child: ListView.builder(
          itemCount: smartDataList.length,
          itemBuilder: (BuildContext context, int index) {
            return CodeCard(smartDataList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CodeCard extends StatelessWidget {
  CodeBean codeBean;

  CodeCard(this.codeBean);

  void _launchURL(String code) async {
    var url = 'tel:$code';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          this._launchURL(codeBean.code);
          print(codeBean.description);
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Text(codeBean.type == 1 ? '查询' : codeBean.type == 2 ? "开通" : "关闭"),
              ),
            ],
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              codeBean.title,
              maxLines: 2,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.deepPurple, fontSize: 16.0),
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  "说明:",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  codeBean.description,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
          trailing: Text(
            "跳转拨号",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
