import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_app/net/api_methods.dart';
import 'package:crypto_app/ui/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    bitcoin = await getPrice('bitcoin');
    ethereum = await getPrice('ethereum');
    tether = await getPrice('tether');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double getValue(String id, double amount) {
      if (id == 'bitcoin') {
        return bitcoin * amount;
      } else if (id == 'ethereum') {
        return ethereum * amount;
      } else {
        return tether * amount;
      }
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance //Adding a path to firestore.
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Coins')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Coin Name: ${document.id}'),
                      Text(
                          'Amount owned: ₹${getValue(document.id, document['Amount']).toStringAsFixed(2)}'),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.monetization_on),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(),
            ),
          );
        },
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
