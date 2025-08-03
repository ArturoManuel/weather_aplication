import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../controllers/search_controller.dart';
import '../../controllers/weather_controller.dart';

class CitySearchWidget extends StatefulWidget {
  final VoidCallback? onCitySelected;
  
  const CitySearchWidget({super.key, this.onCitySelected});

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  final SearchController searchController = Get.put(SearchController());
  final WeatherController weatherController = Get.find();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Campo de búsqueda
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF16213E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: textController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Buscar ciudad...',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark ? Colors.blue[300] : Colors.blue[600],
                ),
                suffixIcon: Obx(() => searchController.isSearching
                  ? Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isDark ? Colors.blue[300] : Colors.blue[600],
                      ),
                    )
                  : textController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        onPressed: () {
                          textController.clear();
                          searchController.clearSearch();
                          focusNode.unfocus();
                        },
                      )
                    : const SizedBox.shrink(),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
              onChanged: searchController.searchCities,
            ),
          ),
          
          // Resultados de búsqueda
          Obx(() {
            if (searchController.searchResults.isEmpty) {
              return const SizedBox.shrink();
            }
            
            return Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF16213E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchController.searchResults.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: isDark ? Colors.grey[700] : Colors.grey[200],
                ),
                itemBuilder: (context, index) {
                  final city = searchController.searchResults[index];
                  
                  return ListTile(
                    leading: Icon(
                      Icons.location_city,
                      color: isDark ? Colors.blue[300] : Colors.blue[600],
                      size: 20,
                    ),
                    title: Text(
                      city.name,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '${city.region}, ${city.country}',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                      size: 16,
                    ),
                    onTap: () {
                      // Seleccionar ciudad
                      weatherController.changeCity(city.name);
                      textController.clear();
                      searchController.clearSearch();
                      focusNode.unfocus();
                      widget.onCitySelected?.call();
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}