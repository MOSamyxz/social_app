import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/home_fab.dart';
import 'package:chatapp/pages/profile/profile_screen.dart';
import 'package:chatapp/pages/search/widget/media_post_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    Key? key,
    required this.user,
    required this.snapshot,
  }) : super(key: key);

  final UsersModel user;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFAB(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
      ),
      body: isShowUsers
          ? _buildUserSearchResults(widget.user)
          : SearchPostListBuilder(snapshot: widget.snapshot, user: widget.user),
    );
  }

  Widget _buildUserSearchResults(UsersModel user) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where(
            'userName',
            isGreaterThanOrEqualTo: searchController.text,
            isLessThanOrEqualTo: '${searchController.text}\uf8ff',
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var user = UsersModel.fromMap(
                snapshot.data!.docs[index].data() as Map<String, dynamic>);
            return InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    profileUser: user,
                  ),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.imageUrl),
                  radius: 16,
                ),
                title: Text(user.userName),
              ),
            );
          },
        );
      },
    );
  }
}
