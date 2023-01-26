import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homepage_controller.dart';
import '../remote_services/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final services = Get.put(Services());
  final controller = Get.put(HomePageController());
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoadingPersons.value
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.personList?.length,
              padding: const EdgeInsets.only(top: 20),
              //itemExtent: 90,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: const CircleAvatar(
                        radius: 25, child: Icon(Icons.person)),
                    title: Text(
                      controller.personList![index].name ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Father Name: ${controller.personList![index].username ?? ''}" ??
                                "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13)),
                        Text(
                            "Address: ${controller.personList![index].email ?? ''}" ??
                                "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 90,
                      child: Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _updatePerson(context,
                                        controller.personList![index].id ?? '');
                                    nameController.clear();
                                    emailController.clear();
                                    userNameController.clear();
                                    passwordController.clear();
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_pin_rounded,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Update',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Deleted"),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //controller.getPersons();
          _addPerson(context);
          nameController.clear();
          emailController.clear();
          userNameController.clear();
          passwordController.clear();
        },
        child: const Icon(Icons.person_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _updatePerson(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Details"),
            content: Wrap(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter name',
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person_pin_rounded),
                          hintText: 'Enter User Name',
                          labelText: 'username',
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.phone),
                          hintText: 'Enter Email',
                          labelText: 'email',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person_pin_circle),
                          hintText: 'Enter Password',
                          labelText: 'password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding:
                              const EdgeInsets.only(left: 150.0, top: 40.0),
                          child: ElevatedButton(
                            child: const Text('Update'),
                            onPressed: () async {
                              var val = await controller.updatePerson(
                                nameController.text,
                                emailController.text,
                                userNameController.text,
                                passwordController.text,
                                id,
                              );
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Information Updated"),
                              ));
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  _addPerson(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Person"),
            content: Wrap(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter name',
                          labelText: 'Name',
                        ),
                      ),
                      TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person_pin_rounded),
                          hintText: 'Enter User Name',
                          labelText: 'username',
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.email),
                          hintText: 'Enter Email',
                          labelText: 'email',
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.password),
                          hintText: 'Enter Password',
                          labelText: 'password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding:
                              const EdgeInsets.only(left: 150.0, top: 40.0),
                          child: ElevatedButton(
                            child: const Text('Add'),
                            onPressed: () async {
                              var val = await controller.addPerson(
                                  nameController.text,
                                  emailController.text,
                                  userNameController.text,
                                  passwordController.text);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Information Updated"),
                              ));
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
