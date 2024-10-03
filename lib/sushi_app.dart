import 'package:flutter/material.dart';
import 'package:list_scrollable_tabs/sushi_bloc.dart';
import 'package:list_scrollable_tabs/widgets/sushi_category_item.dart';
import 'package:list_scrollable_tabs/widgets/sushi_product_item.dart';

const _blackColor = Colors.black87;

class MainSushiApp extends StatelessWidget {
  const MainSushiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
        data: ThemeData.dark(),
        child: const SushiApp()
    );

  }
}

class SushiApp extends StatefulWidget {
  const SushiApp({super.key});

  @override
  State<SushiApp> createState() => _SushiAppState();
}

class _SushiAppState extends State<SushiApp> with SingleTickerProviderStateMixin {
  final _bloc = SushiBloc();


  @override
  void initState() {
    // TODO: implement initState
    _bloc.init(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: _blackColor,
      body: SafeArea(
        child:AnimatedBuilder(
            animation: _bloc,
            builder: (_,__) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: _blackColor,
                    height: 80,
                    child:const  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Category of Sushi",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.favorite, size: 30,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: TabBar(
                      onTap: _bloc.onCategorySelected,
                      controller: _bloc.tabController,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: _bloc.tabs.map((e) => SushiTab(tabCategory: e,)).toList(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          controller: _bloc.scrollController,
                          itemCount: _bloc.items.length,
                          itemBuilder: (context, index) {
                            final item = _bloc.items[index];
                            if(item.isCategory){
                              return SushiCategoryItem(category: item.category,);
                            } else {
                              return SushiProductItem(product: item.product,);
                            }
                          }
                      ),
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
}

class SushiTab extends StatelessWidget {
  const SushiTab({super.key, required this.tabCategory});
  final SushiTabCategory tabCategory;

  @override
  Widget build(BuildContext context) {
    final selected = tabCategory.selected;
    return  Opacity(
      opacity: selected ? 1.0 : 0.5,
      child: Card(
        color: _blackColor,
        elevation: selected ? 6 : 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            tabCategory.category.name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}






