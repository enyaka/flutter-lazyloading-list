import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List myList = [];
  late final ScrollController _scrollController;

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      myList = List<int>.generate(20, (index) => index);
    });
  }

  void _scrollListener() {
    var maxScroll = _scrollController.position.maxScrollExtent;
    var currentPosition = _scrollController.position.pixels;
    if (currentPosition == maxScroll) {
      fetchMore();
    }
  }

  Future<void> fetchMore() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      myList.addAll(List<int>.generate(20, (index) => index + (myList.length)));
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SingleChildScrollView')),
      body: Center(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(myList[index].toString()),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                );
              }, childCount: myList.length),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const Center(
                child: CircularProgressIndicator(),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
