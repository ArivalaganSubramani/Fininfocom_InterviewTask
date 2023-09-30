import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/Model/profile.dart';
import 'package:flutter_task/Network/apiService.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? apiResponse;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");



  @override
  initState() {
    getProfile();
    super.initState();
    debugPrint("getProfile>>>>>$getProfile()");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),

              child: apiResponse == null ? ClipOval(
                child: Image.network(
                    "https://picsum.photos/seed/572/600"),
              ) : ClipOval(child: Image.network(apiResponse?.results[0].picture.large ?? "")),

            ),
             Row(
              children: [
                SizedBox(width: 40),

                Expanded(
                  flex: 1,
                    child: const Text("Name")),
                SizedBox(width: 10),
                apiResponse == null ? const Text("") : Expanded(
                  flex: 3,
                    child: Text("${apiResponse?.results[0].name.title} ${apiResponse?.results[0].name.first} ${apiResponse?.results[0].name.last}")),
              ],
            ),
             Row(
              children: [
                SizedBox(width: 40),

                Expanded(
                  flex: 1,
                    child: const Text("DOB")),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                    child: Text(apiResponse?.results[0].dob.date == null ? "" : dateFormat.format(apiResponse!.results[0].dob.date))),
              ],
            ),
             Row(
              children: [
                SizedBox(width: 40),

                Expanded(
                  flex: 1,
                    child: const Text("Email")),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                    child: Text(apiResponse?.results[0].email ?? "")),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 40),

                Expanded(
                  flex: 1,
                    child: const Text("Location")),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                    child: Text(apiResponse?.results[0].location.street.name ?? "")),
              ],
            ),
             Row(
              children: [
                SizedBox(width: 40),
                Expanded(
                  flex: 1,
                    child: const Text("Register")),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                    child: Text(apiResponse?.results[0].registered.age.toString() ?? "")),
              ],
            ),
          ],

        ),
      ),
    );
  }

  Future<void> getProfile() async {
    apiResponse = (await ApiService().getProfile());
    debugPrint("api resp $apiResponse");
    setState(() {

    });
  }
}
