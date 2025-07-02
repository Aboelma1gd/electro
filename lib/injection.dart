import 'package:electro/core/network/network_info.dart';
import 'package:electro/core/services/firebase_add_services.dart';
import 'package:electro/core/services/firebase_auth_services.dart';
import 'package:electro/core/services/firebase_topsellingandnewin_services.dart';
import 'package:electro/core/services/firestore_services.dart';
import 'package:electro/features/authintication/data/repositories/auth_repositry_impl.dart';
import 'package:electro/features/authintication/domain/repositories/auth_repositries.dart';
import 'package:electro/features/authintication/domain/usecases/forgetpassword_usecase.dart';
import 'package:electro/features/authintication/domain/usecases/login_usecase.dart';
import 'package:electro/features/authintication/domain/usecases/signup_usecase.dart';
import 'package:electro/features/authintication/presentation/cubit/forgetpassword/cubit/forgetpasswordreset_cubit.dart';
import 'package:electro/features/authintication/presentation/cubit/logincubit/cubit/login_cubit.dart';
import 'package:electro/features/authintication/presentation/cubit/signup/authintication_cubit.dart';
import 'package:electro/features/cart/data/datasources/local_datasource_cart.dart';
import 'package:electro/features/cart/data/datasources/remote_datasource_cart.dart';
import 'package:electro/features/cart/data/repositories/cart_repositry_Impl.dart';
import 'package:electro/features/cart/domain/repositories/cart_repositry.dart';
import 'package:electro/features/cart/domain/usecases/addcart_usecase.dart';
import 'package:electro/features/cart/domain/usecases/deletecart_usecase.dart';
import 'package:electro/features/cart/domain/usecases/getcarts_usecase.dart';
import 'package:electro/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:electro/features/checkout/data/repositories/checkout_repositries_Impl.dart';
import 'package:electro/features/checkout/domain/repositories/checkout_repositry.dart';
import 'package:electro/features/checkout/domain/usecases/checkout_usecase.dart';
import 'package:electro/features/checkout/domain/usecases/getaddress_usecase.dart';
import 'package:electro/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:electro/features/home/data/datasources/category_datasources/local_datasource.dart';
import 'package:electro/features/home/data/datasources/category_datasources/remote_datasource.dart';
import 'package:electro/features/home/data/datasources/product_datasources/local_productdatasource.dart';
import 'package:electro/features/home/data/datasources/product_datasources/remote_productdatasource.dart';
import 'package:electro/features/home/data/repositories/home_repostries_impel.dart';
import 'package:electro/features/home/domain/repositories/home_repositry.dart';
import 'package:electro/features/home/domain/usecases/category_usecase.dart';
import 'package:electro/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:electro/features/home/domain/usecases/get_topselling_products.dart';
import 'package:electro/features/home/domain/usecases/getproducts_byprice_usecase.dart';
import 'package:electro/features/home/domain/usecases/getproductsbytitle.dart';
import 'package:electro/features/home/domain/usecases/new_products_usecase.dart';
import 'package:electro/features/home/domain/usecases/products_usecase.dart';
import 'package:electro/features/home/presentation/cubit/fetchcategories/cubit/categories_cubit.dart';
import 'package:electro/features/home/presentation/cubit/productscubit/cubit/products_cubit.dart';
import 'package:electro/features/home/presentation/cubit/topsellingandnewin/cubit/topsellingandnewin_cubit.dart';
import 'package:electro/features/notifications/data/models/notification_model.dart';
import 'package:electro/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:electro/features/profile/data/datasources/local_profile_datasource.dart';
import 'package:electro/features/profile/data/datasources/remote_profile_datasource.dart';
import 'package:electro/features/profile/data/repositories/profile_repositry_Impl.dart';
import 'package:electro/features/profile/domain/repositories/profile_repositry.dart';
import 'package:electro/features/profile/domain/usecases/complaint_usecase.dart';
import 'package:electro/features/profile/domain/usecases/profile_usecase.dart';
import 'package:electro/features/profile/presentation/cubit/complaint_cubit/cubit/complaint_cubit.dart';
import 'package:electro/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:electro/features/reviews/data/repositories/reviews_repositry_Impl.dart';
import 'package:electro/features/reviews/domain/repositories/reviews_repositry.dart';
import 'package:electro/features/reviews/domain/usecases/reviews_usecase.dart';
import 'package:electro/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // مفقود في الكود الأصلي
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1️⃣ تسجيل Firebase
  sl.registerLazySingleton(() => FirebaseFirestore.instance); 
  sl.registerLazySingleton(() => FirebaseAuthServices());
  sl.registerLazySingleton(() => FirestoreService(sl())); // تأكد من تسجيل FirestoreService
  sl.registerLazySingleton(()=> FirebaseAddServices());
  sl.registerLazySingleton(()=> FirebaseTopsellingandnewinServices());

  // 2️⃣ تسجيل `AuthRepositries`
  sl.registerLazySingleton<AuthRepositries>(
    () => AuthRepositryImpl(
      firebaseAuthServices: sl(),
       // إضافة FirestoreService
    ),
  );

  // 3️⃣ تسجيل `HomeRepositry`
  sl.registerLazySingleton<HomeRepositry>(
    () => HomeRepostriesImpel(
      sl(),
      sl(),
      sl(), sl(),sl(), sl(),
    ),
  );

    sl.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepositoryImpl(
       sl(), // يفترض أن FirebaseFirestore مسجل مسبقاً
    ),
  );

  //sl.registerLazySingleton<cartr>(()=> AddtocartRepositryImpl(firestoreService: sl()));

  sl.registerLazySingleton<CartRepositry>(
    () => CartRepositryImpl(
       remoteDatasourceCart: sl(), localDatasourceCart: sl(),
        sl(), sl(), // يفترض أن FirebaseFirestore مسجل مسبقاً
  ));

  sl.registerLazySingleton<ProfileRepositry>(
    () => ProfileRepositryImpl(
         remoteProfileDatasource: sl(),localProfileDatasource: sl(),sl(),sl(), networkInfo: sl(), // يفترض أن FirebaseFirestore مسجل مسبقاً
    ),
  );

  sl.registerLazySingleton<CheckoutRepositry>(
    () => CheckoutRepositriesImpl(
      
    ),
  );


  // 4️⃣ تسجيل `usecases`
  sl.registerLazySingleton(() => Authusecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetpasswordUsecase(sl()));
  sl.registerLazySingleton(() => CategoryUsecase(sl()));
  sl.registerLazySingleton(()=> ProductsUsecase(sl()));
  sl.registerLazySingleton(() => ReviewsUsecase(sl(),));
  sl.registerLazySingleton(()=> NewProductsUsecase(sl()));
  sl.registerLazySingleton(() => Getproductsbytitle(sl()));
  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(()=> GetproductsBypriceUsecase(sl()));
 // sl.registerLazySingleton(()=> AddcartUsecase( sl()));
  sl.registerLazySingleton(()=> GetcartsUsecase(sl()));
  sl.registerLazySingleton(()=> DeletecartUsecase(sl()));
  sl.registerLazySingleton(()=> ProfileUsecase(profileRepositry: sl()));
  sl.registerLazySingleton(()=> ComplaintUsecase(sl()));
  sl.registerLazySingleton(()=> GetTopsellingProducts(sl()));
  sl.registerFactoryParam<TextEditingController, void, void>(
    (_, __) => TextEditingController(),
  );
  sl.registerLazySingleton(()=> CheckoutUsecase(sl()));
  sl
  .registerLazySingleton(() => GetaddressUsecase(sl()));
  sl.registerLazySingleton(() => AddcartUsecase(sl()));

 


  // 5️⃣ تسجيل `Cubits`
  sl.registerFactory(() => AuthinticationCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetpasswordresetCubit(sl()));
   // sl.registerLazySingleton(() => CategoriesCubit( sl())..fetchCategories());
  sl.registerFactory(() => CategoriesCubit(sl()));
  sl.registerLazySingleton(()=> ProductsCubit(sl(),sl(),sl()));
  sl.registerLazySingleton(() => CartCubit( sl(),sl(),sl()));
  final notificationBox = await Hive.openBox<NotificationModel>('notificationsBox');
sl.registerLazySingleton(() => notificationBox);
sl.registerLazySingleton<NotificationsCubit>(() => NotificationsCubit(sl()));
 sl.registerFactoryParam<ReviewsCubit,  String, void>(
  (productId, __) => ReviewsCubit(
    reviewsUsecase: sl(),
    reviewController: TextEditingController(),
    nameController: TextEditingController(),
    productId: productId, // Pass the productId here
  ),
);
sl.registerFactory(()=> TopsellingandnewinCubit(sl(), sl()));
//sl.registerFactory(() => OrdersCubit(sl()));
sl.registerFactory(() => ProfileCubit(sl(), sl(), sl()));
sl.registerFactory(() => ComplaintCubit(sl()));
sl.registerFactory(() => CheckoutCubit(sl(),sl()));

  // 6️⃣ تسجيل `datasources`
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl())); // هنا يتم تسجيل RemoteDatasource
  sl.registerLazySingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));
  sl.registerLazySingleton<LocalProductdatasource>(()=> LocalProductdatasourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RemoteProductdatasource>(() => RemoteProductdatasourceImpl(sl(),sl()));
  sl.registerLazySingleton<RemoteDatasourceCart>(() => RemoteDatasourceCartImpl( firestoreService: sl()));
  sl.registerLazySingleton<LocalDatasourceCart>(() => LocalDatasourceCartImpl( sl()));
  sl.registerLazySingleton<RemoteProfileDatasource>(() => RemoteProfileDatasourceImpl(firebaseAuthServices: sl()));
  sl.registerLazySingleton<LocalProfileDatasource>(() => LocalProfileDatasourceImpl(sl()));

  // 7️⃣ تسجيل `NetworkInfo`
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));

  // 8️⃣ تسجيل SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
