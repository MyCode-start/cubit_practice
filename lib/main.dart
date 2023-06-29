import 'package:blocandcubit/cubit_counter_cubit.dart';
import 'package:blocandcubit/data_manage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
    BlocProvider<DataManageCubit>(create: (context) => DataManageCubit()),
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  var namecontroller= TextEditingController();
  var classcontroller= TextEditingController();
  var stdname;
  var stdclass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc & Cubit'),
      ),
      body: Container(
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                color: Colors.greenAccent,
                child: Text('Floating Action Button was tapped this may times',
                    style: TextStyle(fontSize: 15))
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.pinkAccent,
                child: BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return CircularProgressIndicator();
                    };

                    if (state.error) {
                      return Text(
                        'Check Server', style: (TextStyle(color: Colors.red)),);
                    }

                    return Text('${state.counterValue}',
                        style: TextStyle(fontSize: 25));
                  },
                )
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                height: 300,
                width: 300,
                color: Colors.blueGrey,
                child: BlocBuilder<DataManageCubit, DataManageState>(
                  builder: (context, state) {

                    if (state.loading) {
                      return CircularProgressIndicator();
                    };

                    return ListView.builder(
                        itemCount: state.arrData.length,
                        itemBuilder: (context,index){
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('${state.arrData[index]['name']}',
                                    style: TextStyle(fontSize: 10)),
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Container(
                                child: Text('${state.arrData[index]['class']}',
                                    style: TextStyle(fontSize: 10)),
                              ),
                            ],
                          ),
                        ],
                      );


                       /* title:  Text('${state.arrData[index]['name']}',
                            style: TextStyle(fontSize: 10)),
                        subtitle: Text('${state.arrData[index]['class']}',
                            style: TextStyle(fontSize: 10)),*/



                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          FloatingActionButton(
            onPressed: () {

             showDialog(context: context, builder:(context) {
               return AlertDialog(
                 title: Text('Add Enteries'),
                 content: Column (
                   children: [
                     TextField(
                       controller: namecontroller,
                     ),
                     TextField(
                       controller: classcontroller,
                     ),
                   ],
                 ),

                 actions: [
                   ElevatedButton(onPressed: () {

                     stdname= namecontroller.text.toString();
                     stdclass= classcontroller.text.toString();

                     BlocProvider.of<DataManageCubit>(context).addDataList(value: {
                       'name': stdname,
                       'class': stdclass,
                     });

                     Navigator.pop(context);


                   }, child: Text('Save'))
                 ],


               );
             } );


            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),

          SizedBox(
            width: 80,
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
              //context.read<CounterCubit>().increment(); another way
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


