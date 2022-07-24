import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/cubit/home_cubit/home_page_state.dart';
import 'package:shop_app/data/model/address_model.dart';
import 'package:shop_app/ui/widgets.dart';

class AddAddressPage extends StatelessWidget {
  AddAddressPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppStrings(context).add_address_title),
      ),
      body: _buildAddAddressesPage(context),
    );
  }

  Widget _buildAddAddressesPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          defaultTextField(
            context: context,
            text: getAppStrings(context).enter_name,
            keyboardType: TextInputType.name,
            controller: nameController,
            onSubmitted: (value) {},
            validateText: '',
            onTap: () {},
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(
            height: 20,
          ),
          defaultTextField(
            context: context,
            text: getAppStrings(context).address_city,
            keyboardType: TextInputType.text,
            controller: cityController,
            onSubmitted: (value) {},
            validateText: '',
            onTap: () {},
            prefixIcon: Icons.location_city_outlined,
          ),
          const SizedBox(
            height: 20,
          ),
          defaultTextField(
            context: context,
            text: getAppStrings(context).address_details,
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            onSubmitted: (value) {},
            validateText: '',
            onTap: () {},
            prefixIcon: Icons.location_history,
          ),
          const SizedBox(
            height: 20,
          ),
          defaultTextField(
            context: context,
            text: getAppStrings(context).address_notes,
            keyboardType: TextInputType.text,
            controller: notesController,
            onSubmitted: (value) {},
            validateText: '',
            onTap: () {},
            prefixIcon: Icons.note_add_outlined,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<HomePageCubit, HomeLayoutState>(builder: ((context, state) {
            if (state is AddAdressLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return defaultBtn(
              context: context,
              text: getAppStrings(context).add,
              onPressed: () {
                Address address = Address();
                address.name = nameController.text;
                address.city = cityController.text;
                address.details = addressController.text;
                address.notes = notesController.text;
                HomePageCubit.get(context)
                    .addAddress(context: context, address: address)
                    .whenComplete(() {
                  Navigator.pop(context);
                });
              },
            );
          }))
        ],
      ),
    );
  }

  void save(BuildContext context) {
    Address address = Address();
    address.name = nameController.text;
    address.city = cityController.text;
    address.details = addressController.text;
    address.notes = notesController.text;
    HomePageCubit.get(context).addAddress(context: context, address: address);
  }
}
