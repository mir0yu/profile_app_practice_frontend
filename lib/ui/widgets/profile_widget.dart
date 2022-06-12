import 'package:flutter/cupertino.dart';
import 'package:profile/bloc/user/user_cubit.dart';
import 'package:profile/constants/locator.dart';
import 'package:profile/constants/paths.dart';
import 'package:profile/constants/storage.dart';
import 'package:profile/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key,}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  late UserModel user;
  late String userAvatar;
  late String userFirstName;
  late String userLastName;
  late String userAge;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUser("me");
    super.initState();
  }

  void refresh() {
    setState(() {
      BlocProvider.of<UserCubit>(context).getUser("me");
      // print(BlocProvider.of<UserCubit>(context).state.user.username);
      // print(user.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      print(state);
      if (state is UsersLoading || state is GetUserLoading || state is UserUpdating) {
        return const Scaffold(
          body: CupertinoActivityIndicator(),
        );
      }
      if (state is GetUserLoaded || state is UserUpdated){
        user = BlocProvider.of<UserCubit>(context).state.user;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   // bottomOpacity: 0.5,
          //   centerTitle: true,
          //   title: const Text(
          //     "Animeet",
          //     style: TextStyle(
          //         color: Color.fromRGBO(255, 46, 99, 1),
          //         fontSize: 30,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: 'Inter'),
          //   ),
          //   elevation: 0.5,
          //   backgroundColor: Colors.white,
          //   actions: [
          //     IconButton(
          //       onPressed: null,
          //       icon: CircleAvatar(
          //         backgroundColor: Colors.white,
          //         radius: 30,
          //         backgroundImage: NetworkImage(userAvatar),
          //       ),
          //     ),
          //   ],
          // ),
          backgroundColor: Colors.black,
          // bottomNavigationBar: BottomNavigationBar(
          //   type: BottomNavigationBarType.fixed,
          //   unselectedItemColor: Colors.grey,
          //   selectedItemColor: Colors.red,
          //   backgroundColor: Colors.white,
          //   currentIndex: _currentIndex,
          //   showSelectedLabels: false,
          //   showUnselectedLabels: false,
          //   selectedLabelStyle: const TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   unselectedLabelStyle: const TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   onTap: (value) {
          //     // Respond to item press.
          //     setState(() => _currentIndex = value);
          //   },
          //   items: const <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.whatshot),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.person_rounded),
          //       label: '',
          //     ),
          //   ],
          // ),
          // body: IndexedStack(
          //   index: _currentIndex,
          //   children: const [
          //     // const UserSwiper(),
          //     MyProfileScreen()
          //   ],
          // )
          body:
    // print(user.username);
    // print(BlocProvider.of<UserCubit>(context).state.user.username);
    // print(BlocProvider.of<UserCubit>(context).state);
          Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(width: double.infinity, height: 100,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
                  child: CircleAvatar(
                    minRadius: 30,
                    maxRadius: 60,
                    // radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(user.avatar ??
                        'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640'),
                  ),
                ),
                SizedBox(width: 15, height: 1,),
                Column(
                  children: [
                    SizedBox(width: 1, height: 50,),
                    Container(
                      width: 200,
                      child: Text( user.firstName! + " " + user.lastName!,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          overflow: TextOverflow.fade
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,

            ),
            // Text(
            //   user.username ?? "undefined",
            //   style: const TextStyle(
            //     fontSize: 30,
            //   ),
            // ),
            SizedBox(height: 20, width: 1,),
            Divider(height: 1, color: Colors.white,),
            const SizedBox(
              width: double.infinity,
              height: 70,
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Возраст: " + user.age.toString(),
                      //   style: const TextStyle(
                      //     fontSize: 22,
                      //   ),
                      // ),
                      // Text(
                      //   "О себе: " + user.bio!,
                      //   style: const TextStyle(
                      //     fontSize: 22,
                      //   ),
                      // )
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () => {},
                            child: const Text("Мои работы                   ", style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )))
                        ),
                      ),
                      SizedBox(height: 10, width: 1,),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () => {},
                            child: const Text("Сканировать работу    ", style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )))
                        ),
                      ),
                      SizedBox(height: 10, width: 1,),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () => {},
                            child: const Text("Черновики                     ", style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )))
                        ),
                      ),
                      SizedBox(height: 10, width: 1,),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () => {},
                            child: const Text("Классы                            ", style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )))
                        ),
                      ),
                      SizedBox(height: 10, width: 1,),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () => {refresh()},
                            child: const Text("Добавить ученика      ", style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )))
                        ),
                      ),
                    ],

                  ),
                )),
            // ElevatedButton(
            //     onPressed: () =>
            //     {
            //       refresh()
            //     },
            //     child: const Text("обновить"))
          ],
        ),
      ),
      Positioned(
        bottom: 80,
        right: 33,
        child: IconButton(
            icon: const Icon(
              Icons.exit_to_app_outlined,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () async {
              await storage.deleteAll();
              Navigator.pushNamedAndRemoveUntil(context, AUTH, (r) => false);
            }),
      ),
      Positioned(
        bottom: 1,
        right: 15,
        child: IconButton(
            onPressed: () =>
            {
              Navigator.of(context).pushNamed(UPDATE, arguments: user),
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          iconSize: 50,
        ),
      ),
      SizedBox(height: 800, width: 1,),
    ])
    );
  }
      else {
        return const Scaffold(
          body: Center(
            child: Text(
              'Something went wrong.',
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      }
  });
}}
