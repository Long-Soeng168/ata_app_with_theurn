import 'package:ata_app/components/my_drawer.dart';
import 'package:ata_app/components/my_slide_show.dart';
import 'package:ata_app/models/product.dart';
import 'package:ata_app/models/slide.dart';
import 'package:ata_app/services/product_api.dart';
import 'package:ata_app/services/slide_api.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ata_app/components/my_product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool isLoadingProduct = true;

  @override
  void initState() {
    super.initState();
    fetchHomeSlides();
    fetchProducts(); // Call fetchProducts to load data
  }

  void fetchProducts() async {
    final response = await ProductApi.fetchProducts();
    setState(() {
      products = response;
    });
    isLoadingProduct = false;
  }

  Future<List<Slide>> homeSlides = Future.value([]);
  bool isLoadingSlide = true;
  void fetchHomeSlides() async {
    final response = await SlideApi.fetchHomeSlides();
    setState(() {
      homeSlides = Future.value(response);
    });
    isLoadingSlide = false;
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
            Icon(
              Icons.image_search_outlined,
              weight: 10,
              color: AppColors.onPrimary,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'ATA',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.translate),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
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
            !isLoadingSlide
                ? MySlideShow(futureSlides: homeSlides)
                : const Center(
                    child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )),
            
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade200, // Start color
                    Colors.purple.shade200, // End color
                  ],
                  begin: Alignment.centerLeft, // Gradient start point
                  end: Alignment.centerRight, // Gradient end point
                ),
              ),
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
                    height: 340,
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
                  childAspectRatio: 0.62,
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
