import '../../core/constants/strings.dart';
import '../../core/models/category_model.dart';
import '../../core/utils/size_config.dart';
import '../../core/widgets/default_form_button.dart';
import 'widgets/category_item.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.defaultSize! * 2,
              ),
              Text(
                'What is your dystrophy Type ?',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Please enter your type to recommend you a doctors !', style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18, color: Colors.grey)),
              const SizedBox(
                height: 0,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: CategoryModel.categories.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 6 / 7,
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: SizeConfig.defaultSize! * 3,
                    ),
                    itemBuilder: (context, index) {
                      final item = CategoryModel.categories[index];
                      return CategoryItem(
                        categoryModel: item,
                        selectFunction: () {
                          item.select();
                          setState(
                            () {},
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: SizeConfig.defaultSize! * 2,
              ),
              SizedBox(
                width: double.infinity,
                height: SizeConfig.defaultSize! * 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: DefaultFormButton(
                    fillColor: Colors.black,
                    textColor: Colors.white,
                    text: "Continue",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, registerScreen, arguments: CategoryModel.checkedCategory());
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
