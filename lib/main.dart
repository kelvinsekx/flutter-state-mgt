import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Example App',
      home: App(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

List<CarItem> carItems = [
  CarItem(
      title: 'Boxster',
      count: 1,
      subtitle: '718 Boxster T Porsche',
      url: 'https://oreil.ly/Ws4EX'),
  CarItem(
      title: 'Clarkers',
      count: 1,
      subtitle: '718 Boxster T Porsche',
      url: 'https://oreil.ly/Ws4EX'),
  CarItem(
      title: 'Cayenne',
      count: 1,
      subtitle: 'Cayenne S Porsche',
      url: 'https://oreil.ly/gwvnL'),
];

class CarItem {
  final String title;
  final String subtitle;
  final String url;
  int count;

  CarItem(
      {required this.title,
      required this.subtitle,
      required this.url,
      required this.count});

  static List<CarItem> carItems = [
    CarItem(
        title: 'Boxster',
        count: 1,
        subtitle: '718 Boxster T Porsche',
        url: 'https://oreil.ly/Ws4EX'),
    CarItem(
        title: 'Clarkers',
        count: 1,
        subtitle: '718 Boxster T Porsche',
        url: 'https://oreil.ly/Ws4EX'),
    CarItem(
        title: 'Cayenne',
        count: 1,
        subtitle: 'Cayenne S Porsche',
        url: 'https://oreil.ly/gwvnL'),
  ];
}

var globalState;

class App extends StatefulWidget {
  App({super.key});

  // styles sheet
  static TextStyle titleStyles = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Color(0xdd1c1b1b),
  );

  @override
  State<StatefulWidget> createState() {
    globalState = _AppState();
    return globalState;
  }
}

class _AppState extends State<App> {
  late List<CarItem> items = carItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing'),
        backgroundColor: Colors.blue[300],
        leading: const Icon(Icons.menu),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
              onTap: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailsPage(props: index);
              })),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue[400]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(children: [
                        Text(
                          globalState?.items?[index]?.title ??
                              carItems[index].title,
                          style: App.titleStyles,
                        ),
                        Text(
                          '${globalState?.items?[index]?.count ?? carItems[index].count}',
                          style: App.titleStyles,
                        ),
                        Text('$globalState')
                      ]),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(carItems[index].url),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: carItems.length,
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.props});

  final int props;
  @override
  State<StatefulWidget> createState() {
    return _DetailsPage();
  }
}

class _DetailsPage extends State<DetailsPage> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.props;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Page')),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Text(
                  globalState.items[index].title,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(
                  '${globalState.items[index].count}',
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            var result = carItems.map((e) {
              if (e.title == carItems[index].title) {
                e.count++;
                return e;
              } else {
                return e;
              }
            });
            globalState.setState(() {
              globalState.items = result.toList();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
