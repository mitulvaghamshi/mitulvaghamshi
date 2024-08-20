import 'package:apis/models/contact.dart';
import 'package:apis/widgets/page_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      future: Contacts.query,
      builder: (contacts) => CustomScrollView(slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text('Contacts')),
        SliverSafeArea(
          minimum: const EdgeInsets.all(16),
          sliver: SliverList.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) => _ContactListItem(
              contact: contacts.elementAt(index),
            ),
          ),
        ),
      ]),
    );
  }
}

@immutable
class _ContactListItem extends StatelessWidget {
  const _ContactListItem({required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leadingSize: 50,
      leadingToTitle: 4,
      padding: const EdgeInsets.all(4),
      leading: CircleAvatar(
        child: Text('${contact.firstName[0]}${contact.lastName[0]}'),
      ),
      title: Text('${contact.firstName} ${contact.lastName}'),
      subtitle: Text(contact.email),
      additionalInfo: CupertinoButton(
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.phone,
          color: CupertinoColors.activeGreen,
        ),
      ),
      trailing: CupertinoButton(
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.mail,
          color: CupertinoColors.activeBlue,
        ),
      ),
    );
  }
}
