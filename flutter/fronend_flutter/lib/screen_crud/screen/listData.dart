import 'package:flutter/material.dart';
import 'package:fronend_flutter/API/Api_handel.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:fronend_flutter/screen_crud/model/users.dart';
import 'package:provider/provider.dart';

class List_data extends StatelessWidget {
  const List_data({super.key});

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: fetchUsers(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       print("jogin list load");
    //        return CircularProgressIndicator();
    //     }
    //     if (snapshot.hasError) {
    //       print("jogin list err");
    //       return Text("Error: ${snapshot.error}");
    //     }

    //     print("jogin list data");

    //     final users = snapshot.data??[];

    //     print("ds ${users.length}");

    //     return ListView.builder(
    //       itemCount: users.length,
    //       itemBuilder: (context, index) {
    //         Users user = Users(
    //           userId: users[index].userId,
    //           address: users[index].address,
    //           name: users[index].name,
    //         );
    //         return ListTile(
    //           title: Text(user.name),
    //           subtitle: Text(user.address),
    //         );
    //       },
    //     );
    //   },
    // );

    return Consumer<data_provider>(
      builder: (context, value, child) {
        if (value.err != "") {
          return Text(value.err);
        }
        if (value.isLoading == true) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: value.listUs.length,
          itemBuilder: (context, index) {
            Users user = Users(
              userId: value.listUs[index].userId,
              address: value.listUs[index].address,
              name: value.listUs[index].name,
            );
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.address),
              onTap: () {
                //context.read<data_provider>().setSelectedUserId(user.userId);
                print("user: id:${user.userId} name ${user.name}, address:name ${user.address}");
                context.read<data_provider>().changData_user(user);
              },
            );
          },
        );
      },
    );
  }
}
