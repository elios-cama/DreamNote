import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<DreamModel> dreams;
  bool isLoading = false;

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
    this.dreams = await DatabaseProvider.db.readAllDreams();
    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DreamNote")),
      
    );
  }
}