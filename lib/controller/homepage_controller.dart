import 'package:get/get.dart';
import 'package:http/http.dart';

import '../model/person.dart';
import '../remote_services/services.dart';

class HomePageController extends GetxController {
  final services = Get.find<Services>();
  RxBool isLoadingPersons = false.obs;
  List<Person>? personList = [];
  @override
  void onInit() {
    getPersons();
    super.onInit();
  }

  getPersons() async {
    isLoadingPersons.value = true;
    personList = await services.getPersons();
    isLoadingPersons.value = false;
    print('list loaded');
  }

  addPerson(name, email, username, password) async {
    var val = await services.addPerson(name, email, username, password);
    getPersons();
  }

  updatePerson(name, email, username, password, id) async {
    var val = await services.updatePerson(name, email, username, password, id);
    getPersons();
  }
}
