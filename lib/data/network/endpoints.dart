//API
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shop_app/utils/shared_pref.dart';

const String BASE_URL = 'https://student.valuxapps.com';
const String LOGIN = '/api/login';
const String SIGNUP = '/api/register';
const String HOME_DATA = '/api/home';
const String CATS_DATA = '/api/categories';
const String PRODUCTS_DATA = '/api/products';
const String ADD_FAV = '/api/favorites';
const String PROFILE_DATA = '/api/profile';
const String UPDATE_PROFILE_DATA = '/api/update-profile';

//CONSTANTS
const String ON_BOARDING_SHARED = 'on_boarding_done';
const String LOGIN_SHARED = 'login_done';
const String APP_THEME = 'APP_THEME';
const String APP_LANG = 'lang';

const String HOME_PAGE_PATH = '/home';
const String LOGIN_PAGE_PATH = '/';
String USER_TOKEN = SharedPref.getData(key: 'token').toString();
bool isDark = Settings.getValue<bool>(APP_THEME, false);
