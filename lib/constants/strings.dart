import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'shared_pref.dart';

//API
const String BASE_URL = 'https://student.valuxapps.com';
const String LOGIN = '/api/login';
const String SIGNUP = '/api/register';
const String HOME_DATA = '/api/home';
const String CATS_DATA = '/api/categories';
const String PRODUCTS_DATA = '/api/products';
const String ADD_FAV = '/api/favorites';
const String PROFILE_DATA = '/api/profile';
const String UPDATE_PROFILE_DATA = '/api/update-profile';
const String CART_DATA = '/api/carts';
const String ORDERS_DATA = '/api/orders';
const String ADDRESS_DATA = '/api/addresses';

//Page paths
const String HOME_PAGE_PATH = '/home';
const String LOGIN_PAGE_PATH = '/';
const String SEARCH_PAGE_PATH = '/search';
const String PRODUCT_PAGE_PATH = '/product_details';
const String CART_PAGE_PATH = '/cart_page';
const String ADDRESS_PAGE_PATH = '/address_page';
const String ADD_ADDRESS_PAGE_PATH = '/address_add';

//CONSTANTS
const String ON_BOARDING_SHARED = 'on_boarding_done';
const String LOGIN_SHARED = 'login_done';
const String APP_THEME = 'APP_THEME';
const String APP_LANG = 'lang';

String USER_TOKEN = SharedPref.getData(key: 'token').toString();
bool isDark = Settings.getValue<bool>(APP_THEME, false);
