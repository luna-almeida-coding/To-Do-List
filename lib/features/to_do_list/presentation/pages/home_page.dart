import 'package:flutter/material.dart';
import 'package:to_do_list_squad_premiun/design_system/colors/app_colors.dart';
import 'package:to_do_list_squad_premiun/design_system/widgets/buttons/app_button.dart';
import 'package:to_do_list_squad_premiun/features/to_do_list/domain/entities/to_do_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
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
    return Container(
      color: AppColors.lightBlue,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          _buildListButtons(),
          const SizedBox(height: 20),
          Expanded(child: _buildToDoList()),
        ],
      ),
    );
  }

  Widget _buildListButtons() {
    Widget buildAllListButton() {
      return AppButton(
        onTap: () {},
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
        onTap: () {},
        text: 'pending',
        shape: const RoundedRectangleBorder(),
      );
    }

    Widget buildDoneListButton() {
      return AppButton(
        onTap: () {},
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
    Widget buildToDoItem({
      String? text,
      bool isCompleted = false,
    }) {
      return Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (value) {
              //TODO: Add checkbox implementation
            },
          ),
          const SizedBox(width: 10),
          Text(
            text ?? '',
            style: TextStyle(
              decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ],
      );
    }

    return BlocBuilder<ToDoListCubit, ToDoListState>(
      builder: (context, state) {
        if (state.isLoading) return const Center(child: CircularProgressIndicator());

        if (state.toDoList.isEmpty) return Container();

        if (state.errorMessage.isNotEmpty) return Container();

        return ListView.separated(
          itemBuilder: (context, index) {
            return buildToDoItem(
              text: state.filteredList[index].description,
              isCompleted: state.filteredList[index].isCompleted,
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
      onPressed: () {},
      backgroundColor: AppColors.darkBlue,
      tooltip: "Add To Do",
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}
