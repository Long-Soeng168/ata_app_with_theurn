import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/garage.dart';
import 'package:ata_app/pages/garages/garage_detail_page.dart';
import 'package:ata_app/pages/garages/garage_post_page.dart';
import 'package:ata_app/services/garage_api.dart';
import 'package:flutter/material.dart';

class GaragesPage extends StatefulWidget {
  @override
  _GaragesPageState createState() => _GaragesPageState();
}

class _GaragesPageState extends State<GaragesPage> {
  List<Garage> garages = [];
  List<Garage> filteredGarages = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGaragesData();
  }

  Future<void> fetchGaragesData() async {
    try {
      final fetchedGarages = await GarageApi.fetchGarages();
      setState(() {
        garages = fetchedGarages;
        filteredGarages = garages;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle error, e.g., show a Snackbar or an error message
    }
  }

  void filterGarages(String query) {
    setState(() {
      filteredGarages = garages.where((garage) {
        final nameLower = garage.name.toLowerCase();
        final locationLower = garage.location.toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower) ||
            locationLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Garages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Garage',
                hintText: "Search...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterGarages,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredGarages.isEmpty
                    ? Center(child: Text('No garage available.'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:
                              2 / 3, // Adjust the aspect ratio as needed
                        ),
                        itemCount: filteredGarages.length,
                        itemBuilder: (context, index) {
                          final garage = filteredGarages[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GarageDetailPage(garage: garage),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: garage.banner != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                            child: Image.network(
                                              '${ApiConfig.baseImageUrl}garages/banner/${garage.banner}',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  'assets/images/image_default.png',
                                                  // Path to your default image
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          )
                                        : const Center(
                                            child: Icon(Icons.image, size: 50)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      garage.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.redAccent,
                                        ),
                                        Expanded(
                                          child: Text(
                                            garage.location,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          Icons.star,
                                          color: index < garage.rate
                                              ? Colors.amber
                                              : Colors.grey,
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
