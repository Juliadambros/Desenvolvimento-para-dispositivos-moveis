import 'dart:io';

import 'package:apk_agenda_contatos/database/helper/contact_helper.dart';
import 'package:apk_agenda_contatos/database/model/contact_model.dart';
import 'package:apk_agenda_contatos/view/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper contactHelper = ContactHelper();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    //Contact c = Contact(
    //name: "Júlia Dambrós",
    //email: "57023740017@unicentro.edu.br",
    //phone: "46991206619",
    //img: null,
    //);
    //contactHelper.saveContact(c);

    contactHelper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda de Contatos"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        _showContactPage(contact: contacts[index]);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null
                        ? FileImage(File(contacts[index].img!))
                        : AssetImage("assets/imgs/avatar.png")
                              as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacts[index].name ?? "",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contacts[index].email ?? "",
                      style: TextStyle(
                        fontSize: 16.0,
                    ),),
                    Text(
                      contacts[index].phone ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactPage({Contact? contact}) async{
    final updatedContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact,)));
    if(updatedContact != null){
      setState(() {
        contactHelper.getAllContacts().then((list){
          setState(() {
            contacts = list;
          });
        });
      });
    }
  }
}
