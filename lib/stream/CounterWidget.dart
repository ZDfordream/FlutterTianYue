import 'package:flutter/material.dart';
import 'package:tianyue/stream/BlocProvider.dart';
import 'package:tianyue/stream/IncrementBloc.dart';

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          // StreamBuilder控件中没有任何处理业务逻辑的代码
            stream: bloc.outStream,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              return Text('You hit me: ${snapshot.data} times');
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          bloc.inputSink.add(null);
        },
      ),
    );
  }
}
