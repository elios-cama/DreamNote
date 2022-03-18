// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dreamnote/components/purple_button.dart';
import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:dreamnote/views/AddEdit_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DreamDetailPage extends StatefulWidget {
  final int dreamId;

  const DreamDetailPage({
    Key? key,
    required this.dreamId,
  }) : super(key: key);
  @override
  State<DreamDetailPage> createState() => _DreamDetailPageState();
}

class _DreamDetailPageState extends State<DreamDetailPage> {
  late DreamModel dream;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshDreams();
  }

  Future refreshDreams() async {
    setState(() => isLoading = true);

    this.dream = await DatabaseProvider.db.readDream(widget.dreamId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "lib/assets/gradient.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              //backgroundColor: Colors.white.withOpacity(0),
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: PreferredSize(
                  preferredSize: Size.infinite,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LittlePurpleButton(
                            icon: FontAwesomeIcons.penAlt,
                            onpress: () async {
                              if (isLoading) return;

                              await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => AddEditPage(
                                  dream: dream,
                                ),
                              ));

                              refreshDreams();
                            }),
                        Image.asset(
                          'lib/assets/logo_dr.png',
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                        LittlePurpleButton(
                          icon: FontAwesomeIcons.trash,
                          onpress: () async {
                            await DatabaseProvider.db.delete(widget.dreamId);

                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )),
              automaticallyImplyLeading: false,
            ),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                    
                      Text(
                        "Title : ${dream.title}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Edite le : ${DateFormat.yMMMd().format(dream.time)}",
                        
                        style: TextStyle(color: Colors.white38),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Category : ${dream.category}",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Description : ${dream.title}",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
              ),
        ),
      ],
    );
  }
}
