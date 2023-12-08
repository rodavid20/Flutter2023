import 'package:counter_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlocScreen extends StatefulWidget {
  const HomeBlocScreen({super.key});

  @override
  State<HomeBlocScreen> createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<CounterBloc, int>(
          builder: (context, value) {
            return Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineLarge,
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(CounterDecrementPressed());
              },
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(CounterIncrementPressed());
              },
              child: Icon(Icons.add),
            )
          ],
        )
      ],
    );
  }
}
