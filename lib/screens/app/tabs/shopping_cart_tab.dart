import 'package:cupertino_store/components/cupertino_text_input.dart';
import 'package:cupertino_store/components/shopping_cart_item.dart';
import 'package:cupertino_store/models/app/app_state_model.dart';
import 'package:cupertino_store/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const double _kDateTimePickerHeight = 216;

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() {
    return _ShoppingCartTabState();
  }
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String? name;
  String? email;
  String? location;
  String? pin;
  DateTime? dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  Widget _buildInputPadding(Widget input) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: input,
    );
  }

  Widget _buildNameField() {
    return _buildInputPadding(
      CupertinoTextInput(
        icon: CupertinoIcons.person_solid,
        placeholder: 'Name',
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        onChanged: (newName) {
          setState(() {
            name = newName;
          });
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return _buildInputPadding(
      CupertinoTextInput(
        icon: CupertinoIcons.mail_solid,
        placeholder: 'Email',
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        onChanged: (newEmail) {
          setState(() {
            email = newEmail;
          });
        },
      ),
    );
  }

  Widget _buildLocationField() {
    return _buildInputPadding(
      CupertinoTextInput(
        icon: CupertinoIcons.location_solid,
        placeholder: 'Location',
        textCapitalization: TextCapitalization.words,
        onChanged: (newLocation) {
          setState(() {
            location = newLocation;
          });
        },
      ),
    );
  }

  Widget _buildDateAndTimePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 19, 24),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.clock,
                    color: CupertinoColors.lightBackgroundGray,
                    size: 28,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Delivery time',
                    style: Styles.deliveryTimeLabel,
                  ),
                ],
              ),
              Text(
                DateFormat.yMMMd().add_jm().format(dateTime!),
                style: Styles.deliveryTime,
              ),
            ],
          ),
          Container(
            height: _kDateTimePickerHeight,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: dateTime,
              onDateTimeChanged: (newDateTime) {
                setState(() {
                  dateTime = newDateTime;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildProductInCart(AppStateModel model, int productIndex) {}

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        final productIndex = index - 4;

        switch (index) {
          case 0:
            return _buildNameField();
          case 1:
            return _buildEmailField();
          case 2:
            return _buildLocationField();
          case 3:
            return _buildDateAndTimePicker(context);
          default:
            if (model.productsInCart.length > productIndex) {
              final productsIds = model.productsInCart.keys.toList();
              final productsQuantities = model.productsInCart.values.toList();

              return ShoppingCartItem(
                index: productIndex,
                product: model.getProductById(productsIds[productIndex]),
                quantity: productsQuantities[productIndex],
                lastItem: productIndex == model.productsInCart.length - 1,
                formatter: _currencyFormat,
              );
            } else if (model.productsInCart.keys.length == productIndex &&
                model.productsInCart.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Shipping '
                            '${_currencyFormat.format(model.shippingCost)}',
                            style: Styles.productRowItemPrice,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tax ${_currencyFormat.format(model.tax)}',
                            style: Styles.productRowItemPrice,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Total ${_currencyFormat.format(model.totalCost)}',
                            style: Styles.productRowTotal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            ),
          ],
        );
      },
    );
  }
}
