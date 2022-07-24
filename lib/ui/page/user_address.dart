import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/strings.dart';
import 'package:shop_app/cubit/home_cubit/home_page_cubit.dart';
import 'package:shop_app/cubit/home_cubit/home_page_state.dart';
import 'package:shop_app/data/model/address_model.dart';
import 'package:shop_app/ui/widgets.dart';

class UserAddressesPage extends StatelessWidget {
  const UserAddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Address> addresses = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppStrings(context).user_addresses_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              //Navigator.pushNamed(context, '/user_address_add');
              navigateTo(context: context, pagePath: ADD_ADDRESS_PAGE_PATH);
            },
          ),
        ],
      ),
      body: BlocBuilder<HomePageCubit, HomeLayoutState>(
        builder: (context, state) {
          if (state is LoadingAdressesState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          addresses = (state is LoadingAdressesSucState) ? state.adressesList : addresses;
          return _buildUserAddressesPage(addresses);
        },
      ),
    );
  }

  Widget _buildUserAddressesPage(List<Address> addresses) {
    print('rebuilding: _buildUserAddressesPage');
    return ListView.separated(
      itemCount: addresses.length,
      itemBuilder: (context, index) => _buildUserAddressItem(
        addresses[index],
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1.5,
      ),
    );
  }

  Widget _buildUserAddressItem(Address address) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Address title
            smallText(text: address.name, fontWeight: FontWeight.w600),
            Row(
              children: [
                //Address details
                smallText(text: address.details),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  iconSize: 18,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                  iconSize: 18,
                ),
              ],
            )
          ],
        ),
      );
}
