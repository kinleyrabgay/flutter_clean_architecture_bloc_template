import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/di/injection_container.dart';
import '../../bloc/counter/counter_bloc.dart';

/// Counter page that displays the counter value and controls
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CounterBloc>()..add(const CounterLoadRequested()),
      child: const CounterView(),
    );
  }
}

/// Counter view widget
class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You have pushed the button this many times:',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.largePadding),
                  _buildCounterDisplay(context, state),
                  const SizedBox(height: AppConstants.largePadding * 2),
                  _buildControls(context, state),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state is CounterLoading
                ? null
                : () => context.read<CounterBloc>().add(
                    const CounterIncrementRequested(),
                  ),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  Widget _buildCounterDisplay(BuildContext context, CounterState state) {
    if (state is CounterLoading) {
      return const CircularProgressIndicator();
    } else if (state is CounterLoaded) {
      return Text(
        '${state.counter.value}',
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    } else if (state is CounterError) {
      return Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Error: ${state.message}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return const Text(
        '0',
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      );
    }
  }

  Widget _buildControls(BuildContext context, CounterState state) {
    final isLoading = state is CounterLoading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: isLoading
              ? null
              : () => context.read<CounterBloc>().add(
                  const CounterDecrementRequested(),
                ),
          icon: const Icon(Icons.remove),
          label: const Text('Decrement'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        ElevatedButton.icon(
          onPressed: isLoading
              ? null
              : () => context.read<CounterBloc>().add(
                  const CounterLoadRequested(),
                ),
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ],
    );
  }
}
