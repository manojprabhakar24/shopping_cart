import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


import '../models/CatalogModel.dart';
import '../models/cartModel.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(index)),
          )
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  late final int index;

  _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context
        .select<CatalogModel, Item>((catalog) => catalog.getByPosition(index));
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 45,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
                  item.name,
                  style: textTheme,
                )),
            SizedBox(
              width: 20,
            ),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart =
    context.select<CartModel, bool>((cart) => cart.items.contains(item));

    return TextButton(
        onPressed: isInCart
            ? null
            : () {
          var cart = context.read<CartModel>();
          cart.add(item);
        },
        child: isInCart
            ? Icon(
          Icons.check,
          semanticLabel: 'ADDED',
        )
            : Text('ADD'));
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        'Catalog',
        style: Theme.of(context).textTheme.displayLarge,
      ),
      floating: true,
      actions: [
        IconButton(
            onPressed: () => context.go('/cart'),
            icon: Icon(Icons.shopping_cart))
      ],
    );
  }
}