import 'package:animate_do/animate_do.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_ui/auth/login_page.dart';
import 'package:shoes_shop_ui/consts.dart';
import 'package:shoes_shop_ui/pages/add_feedback.dart';
import 'package:shoes_shop_ui/pages/details_page.dart';
import 'package:shoes_shop_ui/models/sparepart_model.dart';
import 'package:shoes_shop_ui/pages/feedback.dart';
import 'package:shoes_shop_ui/pages/my_favorite.dart';
import 'package:shoes_shop_ui/pages/mycart.dart';
import 'package:shoes_shop_ui/pages/scannqrcode.dart';
import 'package:firebase_core/firebase_core.dart';
import '../auth/sign_in.dart';

void main() async {
  //do initialization to use firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(
        //remove the debug banner
          debugShowCheckedModeBanner: false,
          home: MyHomePage()
      )
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  var isloading = false;
  @override
  Widget build(BuildContext context) {
    var _screenheight = .2;
    var _screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Motor Apps',
              style: style.copyWith(color: Colors.black, fontSize: 16),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyCart()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.money,
                      color: bleu,
                      size: 28,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Pembelian',
                      style: style.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: bleu),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyFavorite()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 30),
                child: favouriteitems.isNotEmpty
                    ? Badge(
                        badgeContent: Text(
                          favouriteitems.length.toString(),
                          style: style.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: white),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.black,
                          size: 28,
                        ),
                      )
                    : const Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 28,
                      ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QrCodeScan()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 50),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => signOutGoogle()));
              // },
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 50),
                child: const Icon(
                  Icons.logout_sharp,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TabBar(
                  controller: _controller,
                  unselectedLabelStyle: style.copyWith(fontSize: 12),
                  labelStyle: style.copyWith(fontSize: 12),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: bleu),
                  unselectedLabelColor: Colors.grey.shade800,
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Racing',
                    ),
                    Tab(
                      text: 'Oli',
                    ),
                    Tab(
                      text: 'Lainnya',
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: TabBarView(controller: _controller, children: [
                  _buildlistitem(items: allsparepart),
                  _buildlistitem(items: racinglist),
                  _buildlistitem(items: olilist),
                  _buildlistitem(items: otherlist),
                ]),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormFeedback()),
            );
          },
          child: Icon(Icons.feedback),
        ),
      ),
    );
  }

  Widget _buildlistitem({required List<MotorModel> items}) {
    return ListView.builder(
        // physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return index % 2 == 0
              ? BounceInLeft(
                  duration: const Duration(milliseconds: 1),
                  child: _builditem(myitems: items, index: index))
              : BounceInRight(
                  duration: const Duration(milliseconds: 1),
                  child: _builditem(myitems: items, index: index));
        });
  }

  Widget _builditem({required List<MotorModel> myitems, required int index}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailsPage(
                      item: myitems[index],
                    )));
      },
      child: AspectRatio(
        aspectRatio: 3 / 2.3,
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: myitems[index].color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 10, color: Colors.grey, offset: Offset(0, 10))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    myitems[index].img,
                    fit: BoxFit.cover,
                    width: 130,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          myitems[index].name,
                          style: style.copyWith(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              myitems[index].isselected =
                                  !myitems[index].isselected;
                            });
                            myitems[index].isselected
                                ? favouriteitems.add(myitems[index])
                                : favouriteitems.remove(myitems[index]);
                          },
                          child: Icon(
                            Icons.favorite_sharp,
                            color:
                                myitems[index].isselected ? Colors.red : white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      myitems[index].company,
                      style: style.copyWith(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    const Spacer(),
                    Text(
                      '\Rp ${myitems[index].price}',
                      style: style.copyWith(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
