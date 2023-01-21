import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/shop_register_cubit.dart';
import 'package:shop_app/modules/register/cubit/shop_register_states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';


class ShopRegisterScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

  return BlocProvider(
    create: (context) => RegisterCubit(),
    child: BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context, state)
      {
        if (state is ShopRegisterSuccessState)
        {
          if(state.registerModel.status!)
          {
            print(state.registerModel.message);
            print(state.registerModel.data?.token);
            CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data?.token,
            ).
            then((value) {
              token=state.registerModel.data?.token;
              navigateAndFinish(context, ShopLayout());
            });
          }
          else
          {
            print(state.registerModel.message);
            showToast(
              text: '${state.registerModel.message}',
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      defaultFormField(
                          controller: nameController,
                          keyboardTybe: TextInputType.name,
                          prefixIcon: Icons.person,
                          label: 'Name',
                          validator: (value)
                          {
                            if(value==null || value.isEmpty)
                            {
                              return 'Name can\'t be empty';
                            }
                            return null;
                          }),
                      SizedBox(height: 30.0,),
                      defaultFormField(
                          controller: emailController,
                          keyboardTybe: TextInputType.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          label: 'Email Address',
                          validator: (value)
                          {
                            if(value==null || value.isEmpty)
                            {
                              return 'Email can\'t be empty';
                            }
                            return null;
                          }),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        controller: passwordController,
                        keyboardTybe: TextInputType.visiblePassword,
                        isPassword: RegisterCubit.get(context).isPassword,
                        prefixIcon: Icons.lock_outline,
                        suffix: RegisterCubit.get(context).suffix,
                        suffixPressed: (){
                          RegisterCubit.get(context).changePasswordVisability();
                        },
                        label: 'Password',
                        validator: (value)
                        {
                          if(value==null || value.isEmpty)
                          {
                            return 'Password is too short';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 30.0,),
                      defaultFormField(
                          controller: phoneController,
                          keyboardTybe: TextInputType.phone,
                          prefixIcon: Icons.phone,
                          label: 'Phone Number',
                          validator: (value)
                          {
                            if(value==null || value.isEmpty)
                            {
                              return 'Phone Number can\'t be empty';
                            }
                            return null;
                          }),
                      SizedBox(height: 30.0,),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder:(context)=> defaultButton(
                          function: (){
                            if(formKey.currentState!.validate())
                            {
                              RegisterCubit.get(context).userRegister(
                                name:   nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone:   phoneController.text,
                              );
                            }
                          },
                          width: double.infinity,
                          text: 'Register',),
                        fallback: (context) => Center(child: CircularProgressIndicator()),

                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    ),
  );
  }
}
