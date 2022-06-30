import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop_ui/pages/add_feedback.dart';
import '../consts.dart';

class FormFeedback extends StatefulWidget {
  const FormFeedback({this.id});
  final String? id;

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FormFeedback> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
      //The entry point for accessing a [FirebaseFirestore].
      FirebaseFirestore firebase = FirebaseFirestore.instance;

      //get collection from firebase, collection is table in mysql
      CollectionReference feedback = firebase.collection('feedback');

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Feedback',
              style: style.copyWith(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: feedback.get(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              var alldata = snapshot.data!.docs;
              return alldata.length != 0 ? ListView.builder(

                // displayed as much as the variable data alldata
                  itemCount: alldata.length,

                  //make custom item with list tile.
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: CircleAvatar(

                        //get first character of name
                        child: Text(alldata[index]['name'][0]),

                      ),
                      title: Text(alldata[index]['name'],
                          style: const TextStyle(fontSize: 20)),
                      subtitle: Text(alldata[index]['comment'],
                          style: const TextStyle(fontSize: 16)),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              //pass data to edit form
                              MaterialPageRoute(builder: (context) =>
                                  AddFeedback(id: snapshot.data!.docs[index].id,)),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward_rounded)),
                    );
                  }) : const Center(
                child: Text('No Data', style: TextStyle(fontSize: 20),),);
            } else {
              return const Center(child: Text("Loading...."));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddFeedback()),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    }
}