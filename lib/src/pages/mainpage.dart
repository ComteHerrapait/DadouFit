import 'package:dadoufit/src/apis/doinsport.dart';
import 'package:dadoufit/src/domains/doinsport/api_response_wrapper.dart';
import 'package:dadoufit/src/domains/doinsport/club_playgound.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<ApiResponseWrapper<ClubPlaygound>> futureApiResult;

  @override
  void initState() {
    super.initState();
    futureApiResult = getPlaygrounds();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: futureApiResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final playgrounds = snapshot.data!.data; 
            return ListView.builder(
              itemCount: snapshot.data!.totalItems,
              itemBuilder: (context, index) {
                final playground = playgrounds[index];

                return Text(playground.name);
              },
            );
          } else if (snapshot.hasError) {
            return Text('HTTP request KO :  ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
