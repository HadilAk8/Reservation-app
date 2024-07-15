class AppConstant{
  static const String APP_NAME ="DBFood";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://192.168.100.9:8001";//"http://127.0.0.1:8000";/*"https://mvs.bslmeiyu.com"*/
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String DRINK_PRODUCT_URI = "/api/v1/products/drink";
  static const String ALG_PRODUCT_URI = "/api/v1/products/algerianfood";
  static const String JAP_PRODUCT_URI = "/api/v1/products/japanesefood";
  static const String ITA_PRODUCT_URI = "/api/v1/products/italianfood";
  static const String DESSERT_PRODUCT_URI = "/api/v1/products/dessert";
  static const String UPLOAD_URL = "/uploads/";
  static const String TABLE_URI = "/api/v1/table";

  static const String RESERVATION_URI = "/api/v1/reservation/list";
  static const String ADD_RESERVATION_URI = "/api/v1/reservation/add";

  static const String ADD_CART_URI = "/api/v1/cart/register";
  static const String GET_CART_URI = "/api/v1/cart/get";


  //auth end points
  static const String REGISTRATION_URI="/api/v1/auth/register";
  static const String LOGIN_URI="/api/v1/auth/login";
  static const String USER_INFO_URI="/api/v1/customer/info";

  static const String TOKEN='';
  static const String PHONE="";
  static const String PASSWORD="";
  static const String CART_LIST="cart_list";
  static const String CART_HISTORY_LIST="cart_history_list";
  
}