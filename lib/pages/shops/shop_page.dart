import 'package:ata_app/components/my_category_tile.dart';
import 'package:ata_app/components/my_drawer.dart';
import 'package:ata_app/components/my_slide_show.dart';
import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/category.dart';
import 'package:ata_app/models/product.dart';
import 'package:ata_app/models/slide.dart';
import 'package:ata_app/services/category_api.dart';
import 'package:ata_app/services/product_api.dart';
import 'package:ata_app/services/slide_api.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ata_app/components/my_product_tile.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Products Data
  List<Product> products = [];
  bool isLoadingProduct = true;

  void fetchProducts() async {
    final result = await ProductApi.fetchProducts();
    setState(() {
      products = result;
    });
    isLoadingProduct = false;
  }

  // Categories Data
  List<Category> categories = [];
  bool isLoadingCategory = true;
  void fetchCategories() async {
    final result = await CategoryApi.fetchCategories();
    setState(() {
      categories = result;
    });
    isLoadingCategory = false;
  }

  Future<List<Slide>> homeSlides = Future.value([]);
  bool isLoadingSlide = true;

  void fetchHomeSlides() async {
    final result = await SlideApi.fetchHomeSlides();
    setState(() {
      homeSlides = Future.value(result);
    });
    isLoadingSlide = false;
  }

  

  @override
  void initState() {
    super.initState();
    fetchHomeSlides();
    fetchProducts();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        foregroundColor: AppColors.onPrimary,
        centerTitle: false,
        title: const Row(
          children: [
            Text(
              'Shop',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slide Show
            !isLoadingSlide
                ? MySlideShow(futureSlides: homeSlides)
                : const Center(
                    child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),

            // Categories
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                    child: Text('Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 160,
                    child: isLoadingCategory // Check if loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8.0),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(5),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return MyCategoryTile(category: category,);
                            },
                          ),
                  ),
                ],
              ),
            ),

            // Recomment Products
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                    child: Text('Recommended',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 300,
                    child: isLoadingProduct // Check if loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10.0),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(5),
                            itemCount: products.length,
                            itemBuilder: (context, index) =>
                                MyProductTile(product: products[index]),
                          ),
                  ),
                ],
              ),
            ),

            // New Products
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
              child: Text('New Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents the grid from scrolling separately
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.67,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    MyProductTile(product: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
