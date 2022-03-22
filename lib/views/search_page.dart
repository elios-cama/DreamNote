// ignore_for_file: prefer_const_constructors

import 'dart:core';

import 'package:dreamnote/components/dreamCardWidget.dart';
import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:dreamnote/views/dreamDetailPage.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final bool DarkTheme;
  const SearchPage({Key? key, required this.DarkTheme}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseProvider daba = DatabaseProvider.db;
  
  late List<DreamModel> dreams;
  bool isLoading = false;
  
  String keyword ="";

  @override
  void initState() {
    
    super.initState();
    refreshDreams();
  }
  @override
  void dispose(){
    DatabaseProvider.db.close();
    super.dispose();
  }
  Future refreshDreams() async{
    setState(() => isLoading = true);
    this.dreams = await DatabaseProvider.db.readSearchItems(keyword);
    setState(() => isLoading = false);
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<List<DreamModel>> dreamlist;
    return Stack(
      children: [
        widget.DarkTheme ?
        Image.asset(
            "lib/assets/gradient.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ) :
          Image.asset(
            "lib/assets/black_theme.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(
                   margin: EdgeInsets.only(top: 3),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color:widget.DarkTheme? Colors.transparent : Colors.white,
                              
                              borderRadius: BorderRadius.circular(16)),
                  child: TextField(
                    cursorColor: widget.DarkTheme? Colors.white :Colors.black,
                    
                      decoration: InputDecoration(
                          hintText: "Type something",
                          hintStyle: TextStyle(color: widget.DarkTheme?Colors.white :Colors.black),
                          border: InputBorder.none
                          ),
                      onChanged: (value) {
                        setState(() {
                          keyword = value;
                        });
                        refreshDreams();
                        
                      },
                    ),
                ),
              ),
            ),
                
            backgroundColor: Colors.transparent,
            body: Center(
            child: isLoading
            ? CircularProgressIndicator()
            : dreams.isEmpty
                ? Text(
                    'No Dreams with $keyword',
                    style: TextStyle( fontSize: 24, color: Colors.white),
                  )
                : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ), 
                    itemCount: dreams.length,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    
                    itemBuilder: (context, index){
                      final dream = dreams[index];
                    return GestureDetector(
                      onTap: ()async{
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DreamDetailPage(dreamId: dream.id!, darktheme: widget.DarkTheme),
                          ));
                          
                      },
                      child: DreamCardWidget(dream: dreams[index],index: index,),
                    );
                    }),
                )
                  ),
                  
                  )
      ],
    );
  }
}
