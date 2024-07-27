import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/design_system/colors/app_colors.dart';
import 'package:to_do_list/design_system/widgets/buttons/app_button.dart';
import 'package:to_do_list/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list/features/to_do_list/presentation/cubits/to_do_list_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController toDoController = TextEditingController();

  late final ToDoListCubit toDoListCubit;

  @override
  void initState() {
    toDoListCubit = context.read<ToDoListCubit>();

    getInitialToDoList();
    super.initState();
  }

  Future<void> getInitialToDoList() async {
    await context.read<ToDoListCubit>().getToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To do list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
      ),
      body: const _BodyWidget(),
      floatingActionButton: _AddToDoButtonWidget(
        toDoController: toDoController,
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListCubit, ToDoListState>(
      builder: (context, state) {
        return Container(
          color: AppColors.lightBlue,
          padding: const EdgeInsets.all(15),
          child: const Column(
            children: [
              _FiltersButtonsWidget(),
              SizedBox(height: 20),
              Expanded(child: _ToDoListWidget()),
            ],
          ),
        );
      },
    );
  }
}

class _ToDoListWidget extends StatefulWidget {
  const _ToDoListWidget();

  @override
  State<_ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<_ToDoListWidget> {
  late final ToDoListCubit toDoListCubit;

  @override
  void initState() {
    toDoListCubit = context.read<ToDoListCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoListCubit, ToDoListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.toDoList.isEmpty) return Container();

        if (state.errorMessage.isNotEmpty) return Container();

        return ListView.separated(
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(
                state.filteredList[index].description,
                style: TextStyle(
                  decoration: state.filteredList[index].isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              secondary: IconButton(
                onPressed: () => toDoListCubit.removeToDoItem(index),
                icon: const Icon(
                  Icons.delete_outline,
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: state.filteredList[index].isCompleted,
              onChanged: (newValue) {
                setState(() {
                  toDoListCubit.updateToDoItemStatus(
                      index: index, isCompleted: newValue!);
                });
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: state.filteredList.length,
        );
      },
    );
  }
}

class _FiltersButtonsWidget extends StatefulWidget {
  const _FiltersButtonsWidget();

  @override
  State<_FiltersButtonsWidget> createState() => _FiltersButtonsWidgetState();
}

class _FiltersButtonsWidgetState extends State<_FiltersButtonsWidget> {
  late final ToDoListCubit toDoListCubit;

  @override
  void initState() {
    toDoListCubit = context.read<ToDoListCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildAllListButton(ToDoListState state) {
      return AppButton(
        isSelected: state.currentFilter == FilterTypes.all,
        onTap: () => toDoListCubit.filterToDoList(FilterTypes.all),
        text: 'All',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
      );
    }

    Widget buildPendingListButton(ToDoListState state) {
      return AppButton(
        isSelected: state.currentFilter == FilterTypes.pending,
        onTap: () => toDoListCubit.filterToDoList(FilterTypes.pending),
        text: 'Pending',
        shape: const RoundedRectangleBorder(),
      );
    }

    Widget buildDoneListButton(ToDoListState state) {
      return AppButton(
        isSelected: state.currentFilter == FilterTypes.done,
        onTap: () => toDoListCubit.filterToDoList(FilterTypes.done),
        text: 'Done',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      );
    }

    return BlocBuilder<ToDoListCubit, ToDoListState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: buildAllListButton(state)),
          Expanded(child: buildPendingListButton(state)),
          Expanded(child: buildDoneListButton(state)),
        ],
      );
    });
  }
}

class _AddToDoButtonWidget extends StatefulWidget {
  final TextEditingController toDoController;

  const _AddToDoButtonWidget({
    required this.toDoController,
  });

  @override
  State<_AddToDoButtonWidget> createState() => _AddToDoButtonWidgetState();
}

class _AddToDoButtonWidgetState extends State<_AddToDoButtonWidget> {
  late final ToDoListCubit toDoListCubit;

  @override
  void initState() {
    toDoListCubit = context.read<ToDoListCubit>();

    super.initState();
  }

  void _showAddToDoDialog(
    BuildContext context,
    TextEditingController toDoController,
  ) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return _AddToDoDialogWidget(
          toDoController: toDoController,
          toDoListCubit: toDoListCubit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddToDoDialog(
        context,
        widget.toDoController,
      ),
      backgroundColor: AppColors.darkBlue,
      tooltip: "Add To Do",
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}

class _AddToDoDialogWidget extends StatelessWidget {
  final TextEditingController toDoController;
  final ToDoListCubit toDoListCubit;

  const _AddToDoDialogWidget({
    required this.toDoController,
    required this.toDoListCubit,
  });

  Future<void> addToDo() async {
    if (toDoController.text.isNotEmpty) {
      await toDoListCubit.addToDoItemToList(
        ToDoEntity(
          description: toDoController.text.trim(),
          isCompleted: false,
        ),
      );
      toDoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Adicionar To Do'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SizedBox(
        height: 50,
        child: TextField(
          controller: toDoController,
          autofocus: true,
        ),
      ),
      actions: [
        Center(
          child: AppButton(
            isSelected: true,
            onTap: () async => addToDo(),
            text: 'Adicionar',
          ),
        ),
      ],
    );
  }
}
