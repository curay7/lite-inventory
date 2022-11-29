import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:first/app/data/services/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:first/app/data/services/notification_services.dart';

import '../../../data/model/product.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var productList = <Product>[].obs;
  var productListUpdate = <Product>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  late Product updateProduct;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendNotification(String title, String body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1, channelKey: 'test_channel', title: title, body: body));
    //AwesomeNotifications().actionStream.listen((event) {});
  }

  void findProductUpdate(int id) {
    productList.forEach((element) {
      print(element);
      if (element.id == id) {
        updateProduct = element;
      }
    });
  }

  void findProductByBarcode(String barcode) async {
    productList.forEach((element) {
      if (element.note == barcode) {
        // This is how I iterate
        var contain =
            productListUpdate.where((element) => element.note == barcode);

        if (contain.isEmpty) {
          productListUpdate.add(element);
        }
      }
    });
  }

  void getProduct() async {
    List<Map<String, dynamic>> products = await DBHelper.query();
    productList.assignAll(
      products.map(
        (data) => new Product.fromJson(data),
      ),
    );
  }

  Future<int> addProduct({Product? product}) async {
    return await DBHelper.insert(product);
  }

  void delete(Product product) {
    var id = DBHelper.delete(product);
    getProduct();
  }

  Future<int> updateProductController(
      {required int id, Product? product}) async {
    int returnId = await DBHelper.update(id: id, product: product!);
    productListUpdate[
            productListUpdate.indexWhere((element) => element.id == id)]
        .qty = product.qty;

    print("UPDATE!!!");
    print(productListUpdate[
            productListUpdate.indexWhere((element) => element.id == id)]
        .qty);
    getProduct();
    return returnId;
  }
}
