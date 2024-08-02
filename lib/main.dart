import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StateModel(),
      child: MaterialApp(
        title: 'Example App',
        home: App(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class StateModel with ChangeNotifier {
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

  void increment(int carItemId) {
    var result = carItems.map((e) {
      if (e.title == carItems[carItemId].title) {
        e.count++;
        return e;
      } else {
        return e;
      }
    });
    carItems = result.toList();
    notifyListeners();
  }
}

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
}

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
    return _AppState();
  }
}

class _AppState extends State<App> {
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
                          context.watch<StateModel>().carItems[index].title,
                          style: App.titleStyles,
                        ),
                        Text(
                          '${context.watch<StateModel>().carItems[index].count}',
                          style: App.titleStyles,
                        ),
                      ]),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          context.watch<StateModel>().carItems[index].url),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: context.watch<StateModel>().carItems.length,
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
                  context.watch<StateModel>().carItems[index].title,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(
                  '${context.watch<StateModel>().carItems[index].count}',
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
          context.read<StateModel>().increment(index);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
