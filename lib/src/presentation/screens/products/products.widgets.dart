part of 'products.dart';

class _ProductTile extends StatelessWidget {
  const _ProductTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final images = product.images.where((e) => Uri.tryParse(e) != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: images.isNotEmpty
              ? Image.network(images.first, fit: BoxFit.cover)
              : const SizedBox.expand(),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(product.title, maxLines: 2)),
            const Gap(8),
            Text('${product.price} \u00A4', maxLines: 1),
          ],
        ),
      ],
    );
  }
}
