import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';

import '../models/pizza.dart';
import '../models/pizza_data.dart';

class PizzaList extends StatefulWidget {
  final Cart _cart;
  const PizzaList(this._cart,{Key? key}): super(key: key);

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  List<Pizza> _pizzas = [];

  @override
  void initState() {
    _pizzas = PizzaData.buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget('Nos Pizzas', widget._cart),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _pizzas.length,
          itemBuilder: (context, index) {
            return _buildRow(_pizzas[index]);
          }
      ),
    );
  }


  _buildRow(Pizza pizza) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PizzaDetails(pizza, widget._cart),
                    ),
                );
              },
              child: _buildPizzaDetails(pizza),
            ),
            BuyButtonWidget(pizza, widget._cart),
            ],
        ),
    );
  }

  _buildPizzaDetails(Pizza pizza) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza),
        ),
        Image.asset(
          'assets/images/pizzas/${pizza.image}',
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        ),
      ],
    );
  }

  _buildBuyButton() {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.red.shade800)
            ),
            child: Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text("Commander"),
              ],
            ),
            onPressed: (){
              print('Commander une pizza');
            },
          )
        ],
      );
  }
}
