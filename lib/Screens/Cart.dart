import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/cartModel.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: _cartItems(),
                )),
            Divider(
              height: 4,
              color: Colors.black,
            ),
            _cartTotal()
          ],
        ),
      ),
    );
  }
}

class _cartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;

    var cart = context.watch<CartModel>();

    return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.done),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              cart.remove(cart.items[index]);
            },
          ),
          title: Text(
            cart.items[index].name,
            style: itemNameStyle,
          ),
        ));
  }
}

class _cartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle =
    Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 50);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          children: [_cartList()],
        ),
      ),
    );
  }
}

class _cartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
          child: Row(children: [
            Consumer<CartModel>(
                builder: (context, cart, child) => Text('\$${cart.totalPrice}')),
            SizedBox(
              width: 24,
            ),
            FilledButton(onPressed: () {}, child: Text('BUY'))
          ])),
    );
  }
}