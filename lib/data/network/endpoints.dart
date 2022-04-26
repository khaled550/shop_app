//API
import 'package:shop_app/utils/shared_pref.dart';

const String BASE_URL = 'https://student.valuxapps.com';
const String LOGIN = '/api/login';
const String SIGNUP = '/api/register';
const String HOME_DATA = '/api/home';
const String CATS_DATA = '/api/categories';
const String PRODUCTS_DATA = '/api/products';

//CONSTANTS
const String ON_BOARDING_SHARED = 'on_boarding_done';
const String LOGIN_SHARED = 'login_done';
const String APP_THEME = 'APP_THEME';
const String HOME_PAGE_PATH = '/home';
const String LOGIN_PAGE_PATH = '/';
String USER_TOKEN = SharedPref.getData(key: 'token').toString();
