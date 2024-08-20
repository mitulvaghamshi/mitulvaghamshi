import 'package:apis/contact/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class ContactScreen extends StatelessWidget {
  const ContactScreen.builder(this.contacts, {super.key});

  final Iterable<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text('Contacts')),
      SliverSafeArea(
        minimum: const EdgeInsets.all(16),
        sliver: SliverList.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts.elementAt(index);
            return CupertinoListTile(
              leadingSize: 40,
              title: Text(contact.firstName),
              subtitle: Text(contact.email),
              leading: CircleAvatar(child: Text(contact.firstName[0])),
              padding: const EdgeInsets.symmetric(vertical: 8),
              additionalInfo: Text(contact.phone),
            );
          },
        ),
      ),
    ]);
  }
}
