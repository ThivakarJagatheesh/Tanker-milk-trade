import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';

var items1 = [
  'Dairy',
  'CC',
  'Trader',
];

class POSTLIST extends StatefulWidget {
  const POSTLIST({super.key});

  @override
  PostListPageState createState() => PostListPageState();
}

class PostListPageState extends State<POSTLIST> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // OtpFieldController otpController = OtpFieldController();

  String dropdownvalue = 'Dairy';

  // get myController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items1[_selectedIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          debugPrint("Floating button was pressed.");

          // otpController.set(['2', '3', '5', '5', '7']);
          // otpController.setValue('3', 0);
          // otpController.setFocus(1);
        },
      ),
      // appBar: AppBar(
      //     title: const Text(''),
      //     backgroundColor: Colors.lightGreen
      // ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Add PSt",
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.lightGreen,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];
}
