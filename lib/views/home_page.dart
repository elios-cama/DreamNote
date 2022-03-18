// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dreamnote/components/dreamCardWidget.dart';
import 'package:dreamnote/components/purple_button.dart';
import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:dreamnote/views/AddEdit_page.dart';
import 'package:dreamnote/views/dreamDetailPage.dart';
import 'package:dreamnote/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        backgroundColor : Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.infinite,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LittlePurpleButton(
                    icon: FontAwesomeIcons.moon,
                    onpress: (){}
                  ),
                  Image.asset(
                    'lib/assets/logo_dr.png',
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                  LittlePurpleButton(
                    icon: FontAwesomeIcons.search,
                    onpress: (){},
                  ),
                ],
              ),
            )),
        automaticallyImplyLeading: false,
      ),
        ),
        body: Container(
            
            child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : dreams.isEmpty
                    ? Text(
                        'No Dreams yet',
                        style: TextStyle( fontSize: 24, color: Colors.white),
                      )
                    : GridView.builder(
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
                            builder: (context) => DreamDetailPage(dreamId: dream.id!,),
                            ));
                            refreshDreams();
                        },
                        child: DreamCardWidget(dream: dreams[index],index: index,),
                      );
                      })
                      )
          ),
          
    
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF7F5FFF),
            onPressed: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditPage(),
                          ),
                        );
            },
            child: Icon(
              FontAwesomeIcons.plus,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFFDEDDFF),
            selectedIconTheme: IconThemeData(color: Color(0xFF7F5FFF)),
            unselectedIconTheme: IconThemeData(color: Color(0xFFB081F7)),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            /*currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),*/
            
            elevation: 15,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cloud,),
                label: 'Notes',
                ),
                BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.chartPie, ),
                label: 'Friends',
                ),
               
                
            ], 
          ),
      ),],
       
    );
  }
}