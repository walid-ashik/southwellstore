import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Southwell Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Southwell Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _controller;
  bool isLoading = true;
  Map<String, String> headers = Map();

  @override
  void initState() {
    super.initState();
    headers['header'] = "sssssssssssssssssssssss";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: getDrawer(),
      body: Container(
          child: Stack(
        children: <Widget>[
          Container(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _controller.loadUrl('https://southwellstore.com/',
                    headers: headers);
              },
              onPageStarted: (url) {
                setState(() {
                  isLoading = true;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
                print('header:\n ${headers.toString()}');
              },
            ),
          ),
          isLoading
              ? Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container()
        ],
      )),
    );
  }

  Widget getDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: SizedBox(),
                  fit: FlexFit.tight,
                ),
                Center(
                    child: Text(
                  'Southwell Store',
                  style: TextStyle(fontSize: 22),
                )),
                Flexible(
                  child: SizedBox(),
                  fit: FlexFit.tight,
                  flex: 1,
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        loadUrl('https://southwellstore.com/test');
                      },
                      child: getDrawerMenuWithIcon(Icon(Icons.home), 'Home')),
                  GestureDetector(
                      onTap: () {
                        loadUrl('https://southwellstore.com/shop/');
                      },
                      child: getDrawerMenuWithIcon(
                          Icon(Icons.local_mall), 'All Products')),
                  ExpansionTile(
                    title: Text("Cupboard"),
                    leading: Icon(Icons.dashboard),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: GestureDetector(
                          onTap: () {
                            loadUrl(
                                'https://southwellstore.com/product-category/canned-goods/');
                          },
                          child: ListTile(
                            leading: Icon(Icons.restaurant_menu),
                            title: Text("Canned Goods"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        loadUrl('https://southwellstore.com/contact/');
                      },
                      child: getDrawerMenuWithIcon(
                          Icon(Icons.mail), 'Contact Us')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadUrl(String url) {
    Navigator.of(context).pop();
    _controller.loadUrl(url, headers: headers);
    print('header:\n ${headers.toString()}');
  }

  Widget getDrawerMenuWithImage(String imageAssetsUrl, String menuName) {
    return ListTile(
      dense: true,
      leading: Image.asset(
        imageAssetsUrl,
        height: 32,
        width: 32,
      ),
      title: Text(menuName),
    );
  }

  Widget getDrawerMenuWithIcon(Icon icon, String menuName) {
    return ListTile(
      dense: true,
      leading: icon,
      title: Text(menuName),
    );
  }
}
