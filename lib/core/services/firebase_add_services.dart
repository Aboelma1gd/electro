import 'package:electro/core/errors/failure.dart';
import 'package:electro/features/cart/domain/entities/cart_item_entity.dart';
import 'package:electro/features/checkout/data/models/address_model.dart';
import 'package:electro/features/profile/data/models/complaint_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAddServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addComplaint(ComplaintModel complaint) async {
    await _firestore.collection('complaints').add(complaint.toJson());
  }

  Future<void> addAddress(AddressModel address, String userid) async {
    await _firestore
        .collection('Users')
        .doc(userid)
        .collection('address')
        .doc('mainAddress')
        .set(address.toJson());
  }

  Future<AddressModel> getUserAddress(String userId) async {
    try {
      final docSnapshot = await _firestore
          .collection('Users')
          .doc(userId)
          .collection('address')
          .doc('mainAddress')
          .get();
      if (docSnapshot.exists) {
        return AddressModel.fromJson(docSnapshot.data()!);
      } else {
        throw Exception("No address found for user.");
      }
    } catch (e) {
      throw Exception("Error fetching user address: $e");
    }
  }

  Future<Either<Failure, CartItemEntity>> addCartItem(
      CartItemEntity cart, String userId) async {
    try {
      // مرجع لسلة المشتريات الخاصة بالمستخدم
      final cartCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('cart');

      // البحث عن عنصر بنفس المنتج
      final querySnapshot =
          await cartCollection.where('id', isEqualTo: cart.id).get();

      if (querySnapshot.docs.isNotEmpty) {
        // العنصر موجود بالفعل، نقوم بتحديث الكمية والسعر الإجمالي
        final docRef = querySnapshot.docs.first.reference;

        await docRef.update({
          'quantity': FieldValue.increment(cart.quantity),
          'totalPrice': FieldValue.increment(cart.totalPrice),
        });

        return Right(cart);
      } else {
        // عنصر جديد، نقوم بإضافته
        final itemData = {
          'id': cart.id,
          'name': cart.name,
          'image': cart.image,
          'price': cart.price,
          'quantity': cart.quantity,
          'totalPrice': cart.totalPrice,
        };

        await cartCollection.add(itemData);
        return Right(cart);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<void> deletecart(String productId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No authenticated user found");
      throw Exception("No authenticated user found");
    }

    var cartRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('cart');

    try {
      var querySnapshot = await cartRef.where('id', isEqualTo: productId).get();

      if (querySnapshot.docs.isNotEmpty) {
        // حذف العنصر الأول الذي تطابقه الشروط
        await querySnapshot.docs.first.reference.delete();
        print("Item successfully deleted from Firebase.");
      } else {
        print("Item not found in cart.");
      }
    } catch (e) {
      print('Error deleting cart item: $e');
      throw Exception('Failed to delete item from cart: $e');
    }
  }
}
