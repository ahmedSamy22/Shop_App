import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import '../register/shop_register_screen.dart';
import 'cubit/shop_login_cubit.dart';
import 'cubit/shop_login_states.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit() ,
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState)
            {
              if(state.loginModel.status!)
                {
                  print(state.loginModel.message);
                  print(state.loginModel.data?.token);
                  // showToast(
                  //   text: '${state.loginModel.message}',
                  //   state: ToastStates.SUCCESS,
                  // );
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).
                  then((value) {
                    token=state.loginModel.data?.token;
                    navigateAndFinish(context, ShopLayout());
                  });
                }
              else
              {
                print(state.loginModel.message);
                showToast(
                    text: '${state.loginModel.message}',
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
                          'Login',
                          style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.black,
                          ),
                        ),
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
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            prefixIcon: Icons.lock_outline,
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisability();
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
                          onSubmit: (value){
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }
                            ),
                        SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder:(context)=> defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                            },
                            width: double.infinity,
                            text: 'login',),
                          fallback: (context) => Center(child: CircularProgressIndicator()),

                        ),

                        SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                'Register now',
                              ),
                            ),
                          ],
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