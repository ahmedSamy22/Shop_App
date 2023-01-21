import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/login_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  @override
Widget build(BuildContext context) {

  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context, state) {},
    builder: (context, state) {

      LoginModel? profile=ShopCubit.get(context).profileModel;
      emailController.text=profile?.data?.email;
      nameController.text=profile?.data?.name;
      phoneController.text=profile?.data?.phone;

      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              if(state is ShopUpdateProfileLoadingState)
              LinearProgressIndicator(),
              SizedBox(height: 20.0,),
              defaultFormField(
                controller: nameController,
                keyboardTybe: TextInputType.text,
                prefixIcon: Icons.person,
                label: 'Name',
                validator: (value)
                {
                  if(value==null || value.isEmpty)
                  {
                    return 'Name can\'t be empty';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0,),
              defaultFormField(
                controller: emailController,
                keyboardTybe: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                label: 'Email Address',
                validator: (value)
                {
                  if(value==null || value.isEmpty)
                  {
                    return 'Email can\'t be empty';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0,),
              defaultFormField(
                controller: phoneController,
                keyboardTybe: TextInputType.phone,
                prefixIcon: Icons.phone,
                label: 'Phone',
                validator: (value)
                {
                  if(value==null || value.isEmpty)
                  {
                    return 'Phone can\'t be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0,),
              defaultButton(
                function:()
                {
                  if(formKey.currentState!.validate())
                    {
                      ShopCubit.get(context).updateProfile(
                        name:nameController.text,
                        email:emailController.text,
                        phone:phoneController.text,
                      );
                    }

                } ,
                width: double.infinity,
                text: 'Update',
              ),

              SizedBox(height: 20.0,),
              defaultButton(
                function:()
                {
                  signOut(context);
                } ,
                width: double.infinity,
                text: 'Log Out',
              ),

            ],
          ),
        ),
      );
    },

  );
}
}
