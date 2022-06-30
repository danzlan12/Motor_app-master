import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoes_shop_ui/pages/feedback.dart';
import 'package:shoes_shop_ui/pages/myhomepage.dart';

class AddFeedback extends StatefulWidget {
  //constructor have one parameter, optional paramter
  //if have id we will show data and run update method
  //else run add data
  const AddFeedback({this.id});

  final String? id;

  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  //set form key
  final _formKey = GlobalKey<FormState>();

  //set texteditingcontroller variable
  var nameController = TextEditingController();
  var commentController = TextEditingController();
  //inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? feedback;

  void getData() async {
    //get users collection from firebase
    //collection is table in mysql
    feedback = firebase.collection('feedback');

    //if have id
    if (widget.id != null) {
      //get users data based on id document
      var data = await feedback!.doc(widget.id).get();

      //we get data.data()
      //so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;

      //set state to fill data controller from data firebase
      setState(() {
        nameController = TextEditingController(text: item['name']);
        commentController =
            TextEditingController(text: item['comment']);
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback Motor Apps"),
          actions: [
            //if have data show delete button
            widget.id != null
                ? IconButton(
                onPressed: () {
                  //method to delete data based on id
                  feedback!.doc(widget.id).delete();

                  //back to main page
                  // '/' is home
                  Navigator.pop(context, true);
                },
                icon: Icon(Icons.delete))
                : SizedBox()
          ],
        ),
        //this form for add and edit data
        //if have id passed from main, field will show data
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16.0), children: [
            SizedBox(height: 10,),
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.person, size: 30,),
            ),
            Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Feedback',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                  hintText: "Feedback",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Isi Feedback';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //if id not null run add data to store data into firebase
                  //else update data based on id
                  if (widget.id == null) {
                    feedback!.add({
                      'name': nameController.text,
                      'comment': commentController.text,
                    });
                  }
                  else {
                    feedback!.doc(widget.id).update({
                      'name': nameController.text,
                      'comment': commentController.text,
                    });
                  }
                  //snackbar notification
                  final snackBar = SnackBar(content: Text('Data saved successfully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //back to main page
                  //home page => '/'
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      const MyHomePage()), (Route<dynamic> route) => false);
                }

              },
            )
          ]),
        ));
  }
}