import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_squad_premiun/design_system/colors/app_colors.dart';
import 'package:to_do_list_squad_premiun/design_system/widgets/buttons/app_button.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/presentation/cubits/to_do_list_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController toDoController = TextEditingController();

  late ToDoListCubit toDoListCubit;

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
      appBar: _buildAppBar,
      body: _buildBody(),
      floatingActionButton: _buildAddToDoItemButton,
    );
  }

  PreferredSizeWidget get _buildAppBar {
    return AppBar(
      title: const Text(
        'To do list',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.darkBlue,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ToDoListCubit, ToDoListState>(
      builder: (context, state) {
        return Container(
          color: AppColors.lightBlue,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildListButtons(state),
              const SizedBox(height: 20),
              Expanded(child: _buildToDoList()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListButtons(ToDoListState state) {
    Widget buildAllListButton() {
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

    Widget buildPendingListButton() {
      return AppButton(
        isSelected: state.currentFilter == FilterTypes.pending,
        onTap: () => toDoListCubit.filterToDoList(FilterTypes.pending),
        text: 'pending',
        shape: const RoundedRectangleBorder(),
      );
    }

    Widget buildDoneListButton() {
      return AppButton(
        isSelected: state.currentFilter == FilterTypes.done,
        onTap: () => toDoListCubit.filterToDoList(FilterTypes.done),
        text: 'done',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: buildAllListButton()),
        Expanded(child: buildPendingListButton()),
        Expanded(child: buildDoneListButton()),
      ],
    );
  }

  Widget _buildToDoList() {
    return BlocBuilder<ToDoListCubit, ToDoListState>(
      builder: (context, state) {
        if (state.isLoading) return const Center(child: CircularProgressIndicator());

        if (state.toDoList.isEmpty) return Container();

        if (state.errorMessage.isNotEmpty) return Container();

        return ListView.separated(
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(
                state.filteredList[index].description,
                style: TextStyle(
                  decoration: state.filteredList[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
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
                  toDoListCubit.updateToDoItemStatus(index: index, isCompleted: newValue!);
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

  Widget get _buildAddToDoItemButton {
    return FloatingActionButton(
      onPressed: () async => _buildAddToDoDialog(),
      backgroundColor: AppColors.darkBlue,
      tooltip: "Add To Do",
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }

  Future _buildAddToDoDialog() {
    Future<void> addToDo() async {
      if (toDoController.text.isNotEmpty) {
        await toDoListCubit.addToDoItemToList(
          ToDoEntity(
            description: toDoController.text.trim(),
            isCompleted: false,
          ),
        );
        Navigator.pop(context);
        toDoController.clear();
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text('Adicionar To Do'),
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
      },
    );
  }
}
