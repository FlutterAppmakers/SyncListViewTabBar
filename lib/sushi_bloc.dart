
import 'package:flutter/material.dart';
import 'package:list_scrollable_tabs/data/sushi_data.dart';
import 'package:list_scrollable_tabs/models/product_category.dart';

const productHeight = 170.0;
const categoryHeight = 60.0;
class SushiBloc with ChangeNotifier {
  List<SushiTabCategory> tabs = [];
  List<SushiItem> items = [];
  late TabController tabController;
  ScrollController scrollController = ScrollController();
  bool _listenToScroll = true;


  void init(TickerProvider tickerProvider) {
    tabController = TabController(vsync: tickerProvider,length: sushiCategory.length);

    double mainOffset = 0.0;
    double endOffset = 0.0;
    for(int i =0; i < sushiCategory.length; i++){
      final category = sushiCategory[i];
      if(i > 0) {
        mainOffset += sushiCategory[i-1].products.length * productHeight;
      }
      if(i < sushiCategory.length -1) {
        endOffset = mainOffset + sushiCategory[i+1].products.length * productHeight;
      } else {
        endOffset = double.infinity;
      }
      items.add(SushiItem(cat: category));
      tabs.add(SushiTabCategory(
          category: category,
          selected: (i ==0),
          mainOffset: categoryHeight * i + mainOffset,
          endOffset: endOffset
      ));

      for(int j =0; j < category.products.length; j++){
        final product = category.products[j];
        items.add(SushiItem(prod: product));
      }
    }
    scrollController.addListener(_onScrollListener);
  }

  void _onScrollListener() {
    if (_listenToScroll) {
      for(int i =0; i < tabs.length; i++){
        final tab = tabs[i];
        if (scrollController.offset >= tab.mainOffset && scrollController.offset <= tab.endOffset
            && !tab.selected){
          onCategorySelected(i, animationRequired: false);
          tabController.animateTo(i);
          break;
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(_onScrollListener);
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void onCategorySelected(int index, {bool animationRequired = true}) async {
    final selectedTabCategory = tabs[index];
    for(int i =0; i < tabs.length; i++){
      final selected = tabs[i].category.name == selectedTabCategory.category.name;
      tabs[i] = tabs[i].copyWith(selected);
    }
    notifyListeners();
    if (animationRequired) {
      _listenToScroll = false;
      await scrollController.animateTo(selectedTabCategory.mainOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
      _listenToScroll = true;
    }

  }

}

class SushiTabCategory {
  const  SushiTabCategory({required this.category, required this.selected, required this.mainOffset, required this.endOffset});
  final ProductCategory category;
  final bool selected;
  final double mainOffset;
  final double endOffset;


  SushiTabCategory copyWith(bool selected) => SushiTabCategory(
    category: category,
    selected: selected,
    mainOffset: mainOffset,
    endOffset: endOffset,
  );

}

class SushiItem {

  final ProductCategory? category;
  final Product? product;

  SushiItem({ProductCategory? cat, Product? prod})
      : category = cat,
        product = prod;

  bool get isCategory => (category != null);
}