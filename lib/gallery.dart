import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  Stream<QuerySnapshot> stream_ordering() {
    return FirebaseFirestore.instance.collection("user_picture").snapshots();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: stream_ordering(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView(
                    children: [
                      for(int i = 0; i<snapshot.data!.docs[0]['url'].length; i++)
                        RotationTransition(
                            turns: new AlwaysStoppedAnimation(90 / 360),
                            child: Image.network(
                                snapshot.data!.docs[0]['url'][i],
                                fit : BoxFit.cover
                            ),
                        ),
                    ]

                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(color: Colors.blue));
                }
              }
            )
          ),
        ]
      ),
      ),
    );
  }
}
