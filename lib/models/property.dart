class Property {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  static List<Property> getProperties() {
    return [
      Property(
        id: '1',
        title: 'Luxury Apartment in City Center',
        description: 'A beautiful and spacious apartment located in the heart of the city.',
        price: '\$1,200,000',
        imageUrl: 'assets/images/download.jpeg',
      ),
      Property(
        id: '2',
        title: 'Cozy House in Suburbs',
        description: 'A charming 3-bedroom house with a large backyard.',
        price: '\$350,000',
        imageUrl: 'assets/images/download (1).jpeg',
      ),
      Property(
        id: '3',
        title: 'Modern Studio Near Beach',
        description: 'A stylish studio apartment just a few steps away from the beach.',
        price: '\$800,000',
        imageUrl: 'assets/images/download (2).jpeg',
      ),
      Property(
        id: '4',
        title: 'Spacious Villa with Pool',
        description: 'A luxurious villa with a private pool and garden.',
        price: '\$2,500,000',
        imageUrl: 'assets/images/download (3).jpeg',
      ),
      Property(
        id: '5',
        title: 'Charming Cottage in the Woods',
        description: 'A peaceful cottage surrounded by nature, perfect for a weekend getaway.',
        price: '\$250,000',
        imageUrl: 'assets/images/download (4).jpeg',
      ),
      Property(
        id: '6',
        title: 'Penthouse with City View',
        description: 'A stunning penthouse offering breathtaking views of the city skyline.',
        price: '\$3,000,000',
        imageUrl: 'assets/images/download (5).jpeg',
      ),
      Property(
        id: '7',
        title: 'Affordable Apartment for Rent',
        description: 'A budget-friendly 2-bedroom apartment available for rent.',
        price: '\$1,500/month',
        imageUrl: 'assets/images/download (6).jpeg',
      ),
      Property(
        id: '8',
        title: 'Luxury Beachfront Condo',
        description: 'A high-end condo with ocean views and all the amenities you need.',
        price: '\$1,800,000',
        imageUrl: 'assets/images/download (7).jpeg',
      ),
      Property(
        id: '9',
        title: 'Renovated Historic Home',
        description: 'A beautifully restored historic home with modern amenities.',
        price: '\$650,000',
        imageUrl: 'assets/images/download (8).jpeg',
      ),
      Property(
        id: '10',
        title: 'Large Ranch in Countryside',
        description: 'A spacious ranch with plenty of land and a rustic farmhouse.',
        price: '\$1,200,000',
        imageUrl: 'assets/images/download (9).jpeg',
      ),
    ];
  }
}
