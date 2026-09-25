import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _hotels = [];

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  Future<void> _loadHotels() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final response = await Supabase.instance.client.functions.invoke(
        'hotel-search',
        body: {
          'checkIn': '2026-10-15',
          'checkOut': '2026-10-17',
          'adults': 2,
          'rooms': 1,
        },
      );

      final responseData = response.data;

      if (responseData is! Map) {
        throw Exception('Invalid response from hotel search.');
      }

      final data = Map<String, dynamic>.from(responseData);

      if (data['success'] != true) {
        throw Exception(
          data['error']?.toString() ?? 'Hotel search failed.',
        );
      }

      final rawHotels = data['hotels'];

      final hotels = rawHotels is List
          ? rawHotels
              .whereType<Map>()
              .map(
                (hotel) => Map<String, dynamic>.from(hotel),
              )
              .toList()
          : <Map<String, dynamic>>[];

      if (!mounted) return;

      setState(() {
        _hotels = hotels;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        title: const Text('Hotels in Kraków'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Searching for hotels...',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Could not load hotels',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadHotels,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_hotels.isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadHotels,
        child: ListView(
          children: const [
            SizedBox(height: 200),
            Center(
              child: Text(
                'No hotels found',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadHotels,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: _hotels.length,
        itemBuilder: (context, index) {
          return _hotelCard(_hotels[index]);
        },
      ),
    );
  }

  Widget _hotelCard(Map<String, dynamic> hotel) {
    final categoryRaw = hotel['category'];

    final category = categoryRaw is Map
        ? Map<String, dynamic>.from(categoryRaw)
        : <String, dynamic>{};

    final bestRateRaw = hotel['bestRate'];

    final bestRate = bestRateRaw is Map
        ? Map<String, dynamic>.from(bestRateRaw)
        : <String, dynamic>{};

    final name = hotel['name']?.toString() ?? 'Hotel';

    final categoryName =
        category['name']?.toString() ?? '';

    final roomName =
        bestRate['roomName']?.toString() ?? 'Room';

    final boardName =
        bestRate['boardName']?.toString() ?? '';

    final currency =
        hotel['currency']?.toString() ?? '';

    final price =
        bestRate['sellingRate'] ??
        bestRate['netPrice'] ??
        hotel['minNetRate'];

    final priceText =
        price != null ? price.toString() : '-';

    final isNonRefundable =
        bestRate['isNonRefundable'] == true;

    final rateType =
        bestRate['rateType']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.hotel,
                    size: 32,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (categoryName.isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Text(
                          categoryName,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.bed_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(roomName),
                ),
              ],
            ),

            if (boardName.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.restaurant_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(boardName),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 14),
            const Divider(),
            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        isNonRefundable
                            ? 'Non-refundable'
                            : 'Cancellation policy available',
                        style: TextStyle(
                          color: isNonRefundable
                              ? Colors.red.shade700
                              : Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (rateType.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          rateType,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$priceText $currency',
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Test net price',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}