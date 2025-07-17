import 'dart:ui';

import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_theme.dart';

class CategoryProduct {
  final String title;
  final String price;
  final String image;
  final int id;
  final Color color;
  final List<FoodPath> foodPath;

  CategoryProduct(
      {required this.image,
      required this.title,
      required this.id,
      required this.price,
      required this.foodPath,
      required this.color});
}

class FoodPath {
  final String title;
  final String price;
  final List<Products> products;

  FoodPath({
    required this.title,
    required this.price,
    required this.products,
  });
}

class Products {
  final String title;
  final String price;
  final String weight;
  final String id;
  final String data;

  Products({required this.title, required this.price, required this.data, required this.weight, required this.id});
}

// В самом верху вашего файла:
final DateTime now      = DateTime.now().toUtc();
final DateTime weekAgo  = now.subtract(Duration(days: 7));
final DateTime monthAgo = now.subtract(Duration(days: 30));

final List<CategoryProduct> categories = [
  // 1. Еда и напитки
  CategoryProduct(
    id: 1,
    image: ImageAssets.food,
    title: 'Еда и напитки',
    price: '25 000 ₽',
    color: AppColors.orangeFood,
    foodPath: [
      FoodPath(
        title: 'Продукты',
        price: '3 400,99 ₽',
        products: [
          // Бананы
          Products(title: 'Бананы',   price: '1 540,99 ₽', weight: '1,5 кг', id: '1', data: now.toIso8601String()),
          Products(title: 'Бананы',   price: '2 540,99 ₽', weight: '1,5 кг', id: '1', data: weekAgo.toIso8601String()),
          Products(title: 'Бананы',   price: '3 540,99 ₽', weight: '1,5 кг', id: '1', data: monthAgo.toIso8601String()),
          // Пельмени
          Products(title: 'Пельмени', price: '1 540,99 ₽', weight: '0,9 кг', id: '2', data: now.toIso8601String()),
          Products(title: 'Пельмени', price: '2 540,99 ₽', weight: '0,9 кг', id: '2', data: weekAgo.toIso8601String()),
          Products(title: 'Пельмени', price: '3 540,99 ₽', weight: '0,9 кг', id: '2', data: monthAgo.toIso8601String()),
          // Йогурт
          Products(title: 'Йогурт',   price: '860,00 ₽',   weight: '0,5 кг', id: '3', data: now.toIso8601String()),
          Products(title: 'Йогурт',   price: '860,00 ₽',   weight: '0,5 кг', id: '3', data: weekAgo.toIso8601String()),
          Products(title: 'Йогурт',   price: '860,00 ₽',   weight: '0,5 кг', id: '3', data: monthAgo.toIso8601String()),
          // Арбуз
          Products(title: 'Арбуз',    price: '800,00 ₽',   weight: '3,0 кг', id: '4', data: now.toIso8601String()),
          Products(title: 'Арбуз',    price: '1300,00 ₽',   weight: '3,0 кг', id: '4', data: weekAgo.toIso8601String()),
          Products(title: 'Арбуз',    price: '2800,00 ₽',   weight: '3,0 кг', id: '4', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Алкоголь',
        price: '3 400,99 ₽',
        products: [
          // Виски
          Products(title: 'Виски',   price: '1 200,00 ₽', weight: '0,5 л', id: '5', data: now.toIso8601String()),
          Products(title: 'Виски',   price: '3 200,00 ₽', weight: '0,5 л', id: '5', data: weekAgo.toIso8601String()),
          Products(title: 'Виски',   price: '4 200,00 ₽', weight: '0,5 л', id: '5', data: monthAgo.toIso8601String()),
          // Водка
          Products(title: 'Водка',   price: '1 000,00 ₽', weight: '0,5 л', id: '6', data: now.toIso8601String()),
          Products(title: 'Водка',   price: '1 000,00 ₽', weight: '0,5 л', id: '6', data: weekAgo.toIso8601String()),
          Products(title: 'Водка',   price: '1 000,00 ₽', weight: '0,5 л', id: '6', data: monthAgo.toIso8601String()),
          // Вино
          Products(title: 'Вино',    price: '700,00 ₽',   weight: '0,7 л', id: '7', data: now.toIso8601String()),
          Products(title: 'Вино',    price: '700,00 ₽',   weight: '0,7 л', id: '7', data: weekAgo.toIso8601String()),
          Products(title: 'Вино',    price: '700,00 ₽',   weight: '0,7 л', id: '7', data: monthAgo.toIso8601String()),
          // Джин
          Products(title: 'Джин',    price: '500,99 ₽',   weight: '0,5 л', id: '8', data: now.toIso8601String()),
          Products(title: 'Джин',    price: '3500,99 ₽',   weight: '0,5 л', id: '8', data: weekAgo.toIso8601String()),
          Products(title: 'Джин',    price: '1500,99 ₽',   weight: '0,5 л', id: '8', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Рестораны/Бары',
        price: '3 400,99 ₽',
        products: [
          // The Бык
          Products(title: 'The Бык',           price: '1 540,99 ₽', weight: '1 посещение', id: '9',  data: now.toIso8601String()),
          Products(title: 'The Бык',           price: '2 540,99 ₽', weight: '1 посещение', id: '9',  data: weekAgo.toIso8601String()),
          Products(title: 'The Бык',           price: '3 540,99 ₽', weight: '1 посещение', id: '9',  data: monthAgo.toIso8601String()),
          // Вкусно&Точка
          Products(title: 'Вкусно&Точка',      price: '1 000,00 ₽', weight: '2 посещения', id: '10', data: now.toIso8601String()),
          Products(title: 'Вкусно&Точка',      price: '2 000,00 ₽', weight: '2 посещения', id: '10', data: weekAgo.toIso8601String()),
          Products(title: 'Вкусно&Точка',      price: '3 000,00 ₽', weight: '2 посещения', id: '10', data: monthAgo.toIso8601String()),
          // Rostics
          Products(title: 'Rostics',           price: '400,00 ₽',   weight: '1 посещение', id: '11', data: now.toIso8601String()),
          Products(title: 'Rostics',           price: '800,00 ₽',   weight: '1 посещение', id: '11', data: weekAgo.toIso8601String()),
          Products(title: 'Rostics',           price: '2400,00 ₽',   weight: '1 посещение', id: '11', data: monthAgo.toIso8601String()),
          // Столовка
          Products(title: 'Столовка',          price: '460,00 ₽',   weight: '3 посещения', id: '12', data: now.toIso8601String()),
          Products(title: 'Столовка',          price: '2460,00 ₽',   weight: '3 посещения', id: '12', data: weekAgo.toIso8601String()),
          Products(title: 'Столовка',          price: '3460,00 ₽',   weight: '3 посещения', id: '12', data: monthAgo.toIso8601String()),
        ],
      ),
    ],
  ),

  // 2. Шопинг
  CategoryProduct(
    id: 2,
    image: ImageAssets.cloth,
    title: 'Шопинг',
    price: '10 000 ₽',
    color: AppColors.pinkAccent,
    foodPath: [
      FoodPath(
        title: 'Одежда',
        price: '4 000 ₽',
        products: [
          // Джинсы
          Products(title: 'Джинсы',  price: '2 000 ₽', weight: '-', id: '13', data: now.toIso8601String()),
          Products(title: 'Джинсы',  price: '2 000 ₽', weight: '-', id: '13', data: weekAgo.toIso8601String()),
          Products(title: 'Джинсы',  price: '2 000 ₽', weight: '-', id: '13', data: monthAgo.toIso8601String()),
          // Рубашка
          Products(title: 'Рубашка', price: '1 500 ₽', weight: '-', id: '14', data: now.toIso8601String()),
          Products(title: 'Рубашка', price: '1 500 ₽', weight: '-', id: '14', data: weekAgo.toIso8601String()),
          Products(title: 'Рубашка', price: '1 500 ₽', weight: '-', id: '14', data: monthAgo.toIso8601String()),
          // Футболка
          Products(title: 'Футболка', price: '500 ₽',  weight: '-', id: '15', data: now.toIso8601String()),
          Products(title: 'Футболка', price: '500 ₽',  weight: '-', id: '15', data: weekAgo.toIso8601String()),
          Products(title: 'Футболка', price: '500 ₽',  weight: '-', id: '15', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Электроника',
        price: '3 000 ₽',
        products: [
          // Наушники
          Products(title: 'Наушники', price: '2 000 ₽', weight: '-', id: '16', data: now.toIso8601String()),
          Products(title: 'Наушники', price: '2 000 ₽', weight: '-', id: '16', data: weekAgo.toIso8601String()),
          Products(title: 'Наушники', price: '2 000 ₽', weight: '-', id: '16', data: monthAgo.toIso8601String()),
          // Чехол
          Products(title: 'Чехол',    price: '500 ₽',   weight: '-', id: '17', data: now.toIso8601String()),
          Products(title: 'Чехол',    price: '500 ₽',   weight: '-', id: '17', data: weekAgo.toIso8601String()),
          Products(title: 'Чехол',    price: '500 ₽',   weight: '-', id: '17', data: monthAgo.toIso8601String()),
          // Зарядка
          Products(title: 'Зарядка',  price: '500 ₽',   weight: '-', id: '18', data: now.toIso8601String()),
          Products(title: 'Зарядка',  price: '500 ₽',   weight: '-', id: '18', data: weekAgo.toIso8601String()),
          Products(title: 'Зарядка',  price: '500 ₽',   weight: '-', id: '18', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Аксессуары',
        price: '3 000 ₽',
        products: [
          // Часы
          Products(title: 'Часы',    price: '2 000 ₽', weight: '-', id: '19', data: now.toIso8601String()),
          Products(title: 'Часы',    price: '2 000 ₽', weight: '-', id: '19', data: weekAgo.toIso8601String()),
          Products(title: 'Часы',    price: '2 000 ₽', weight: '-', id: '19', data: monthAgo.toIso8601String()),
          // Очки
          Products(title: 'Очки',    price: '500 ₽',   weight: '-', id: '20', data: now.toIso8601String()),
          Products(title: 'Очки',    price: '500 ₽',   weight: '-', id: '20', data: weekAgo.toIso8601String()),
          Products(title: 'Очки',    price: '500 ₽',   weight: '-', id: '20', data: monthAgo.toIso8601String()),
          // Ремень
          Products(title: 'Ремень',  price: '500 ₽',   weight: '-', id: '21', data: now.toIso8601String()),
          Products(title: 'Ремень',  price: '500 ₽',   weight: '-', id: '21', data: weekAgo.toIso8601String()),
          Products(title: 'Ремень',  price: '500 ₽',   weight: '-', id: '21', data: monthAgo.toIso8601String()),
        ],
      ),
    ],
  ),

  // 3. Транспорт
  CategoryProduct(
    id: 3,
    image: ImageAssets.transports,
    title: 'Транспорт',
    price: '250 000 ₽',
    color: AppColors.black50,
    foodPath: [
      FoodPath(
        title: 'Такси',
        price: '100 000 ₽',
        products: [
          Products(title: 'Поездка 1', price: '2 000 ₽', weight: '1 поездка', id: '22', data: now.toIso8601String()),
          Products(title: 'Поездка 1', price: '3 000 ₽', weight: '1 поездка', id: '22', data: weekAgo.toIso8601String()),
          Products(title: 'Поездка 1', price: '4 000 ₽', weight: '1 поездка', id: '22', data: monthAgo.toIso8601String()),

          Products(title: 'Поездка 2', price: '3 000 ₽', weight: '1 поездка', id: '23', data: now.toIso8601String()),
          Products(title: 'Поездка 2', price: '5 000 ₽', weight: '1 поездка', id: '23', data: weekAgo.toIso8601String()),
          Products(title: 'Поездка 2', price: '8 000 ₽', weight: '1 поездка', id: '23', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Автобус',
        price: '50 000 ₽',
        products: [
          Products(title: 'Поездка А', price: '25 000 ₽', weight: '1 поездка', id: '24', data: now.toIso8601String()),
          Products(title: 'Поездка А', price: '25 000 ₽', weight: '1 поездка', id: '24', data: weekAgo.toIso8601String()),
          Products(title: 'Поездка А', price: '25 000 ₽', weight: '1 поездка', id: '24', data: monthAgo.toIso8601String()),
          Products(title: 'Поездка B', price: '25 000 ₽', weight: '1 поездка', id: '25', data: now.toIso8601String()),
          Products(title: 'Поездка B', price: '25 000 ₽', weight: '1 поездка', id: '25', data: weekAgo.toIso8601String()),
          Products(title: 'Поездка B', price: '25 000 ₽', weight: '1 поездка', id: '25', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Метро',
        price: '50 000 ₽',
        products: [
          Products(title: 'Проездной', price: '50 000 ₽', weight: '1 месяц', id: '26', data: now.toIso8601String()),
          Products(title: 'Проездной', price: '50 000 ₽', weight: '1 месяц', id: '26', data: weekAgo.toIso8601String()),
          Products(title: 'Проездной', price: '50 000 ₽', weight: '1 месяц', id: '26', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Топливо',
        price: '50 000 ₽',
        products: [
          Products(title: 'Заправка', price: '50 000 ₽', weight: '20 л', id: '27', data: now.toIso8601String()),
          Products(title: 'Заправка', price: '50 000 ₽', weight: '20 л', id: '27', data: weekAgo.toIso8601String()),
          Products(title: 'Заправка', price: '50 000 ₽', weight: '20 л', id: '27', data: monthAgo.toIso8601String()),
        ],
      ),
    ],
  ),

  // 4. Здоровье
  CategoryProduct(
    id: 4,
    image: ImageAssets.health,
    title: 'Здоровье',
    price: '75 000 ₽',
    color: AppColors.yellowAccent,
    foodPath: [
      FoodPath(
        title: 'Аптека',
        price: '25 000 ₽',
        products: [
          Products(title: 'Витамины',     price: '5 000 ₽',   weight: '-',   id: '28', data: now.toIso8601String()),
          Products(title: 'Витамины',     price: '5 000 ₽',   weight: '-',   id: '28', data: weekAgo.toIso8601String()),
          Products(title: 'Витамины',     price: '5 000 ₽',   weight: '-',   id: '28', data: monthAgo.toIso8601String()),
          Products(title: 'Лекарства',    price: '20 000 ₽',  weight: '-',   id: '29', data: now.toIso8601String()),
          Products(title: 'Лекарства',    price: '20 000 ₽',  weight: '-',   id: '29', data: weekAgo.toIso8601String()),
          Products(title: 'Лекарства',    price: '20 000 ₽',  weight: '-',   id: '29', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Спорт',
        price: '30 000 ₽',
        products: [
          Products(title: 'Абонемент в зал', price: '30 000 ₽', weight: '6 мес.', id: '30', data: now.toIso8601String()),
          Products(title: 'Абонемент в зал', price: '30 000 ₽', weight: '6 мес.', id: '30', data: weekAgo.toIso8601String()),
          Products(title: 'Абонемент в зал', price: '30 000 ₽', weight: '6 мес.', id: '30', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Визиты',
        price: '20 000 ₽',
        products: [
          Products(title: 'Терапевт',       price: '10 000 ₽', weight: '1 приём', id: '31', data: now.toIso8601String()),
          Products(title: 'Терапевт',       price: '10 000 ₽', weight: '1 приём', id: '31', data: weekAgo.toIso8601String()),
          Products(title: 'Терапевт',       price: '10 000 ₽', weight: '1 приём', id: '31', data: monthAgo.toIso8601String()),
          Products(title: 'Стоматолог',     price: '10 000 ₽', weight: '1 приём', id: '32', data: now.toIso8601String()),
          Products(title: 'Стоматолог',     price: '10 000 ₽', weight: '1 приём', id: '32', data: weekAgo.toIso8601String()),
          Products(title: 'Стоматолог',     price: '10 000 ₽', weight: '1 приём', id: '32', data: monthAgo.toIso8601String()),
        ],
      ),
    ],
  ),

  // 5. Прочие
  CategoryProduct(
    id: 5,
    image: ImageAssets.other,
    title: 'Прочие',
    price: '100 000 ₽',
    color: AppColors.green,
    foodPath: [
      FoodPath(
        title: 'Жильё и ЖКХ',
        price: '40 000 ₽',
        products: [
          Products(title: 'Электричество', price: '15 000 ₽', weight: '-', id: '33', data: now.toIso8601String()),
          Products(title: 'Электричество', price: '15 000 ₽', weight: '-', id: '33', data: weekAgo.toIso8601String()),
          Products(title: 'Электричество', price: '15 000 ₽', weight: '-', id: '33', data: monthAgo.toIso8601String()),
          Products(title: 'Вода',           price: '5 000 ₽',   weight: '-', id: '34', data: now.toIso8601String()),
          Products(title: 'Вода',           price: '5 000 ₽',   weight: '-', id: '34', data: weekAgo.toIso8601String()),
          Products(title: 'Вода',           price: '5 000 ₽',   weight: '-', id: '34', data: monthAgo.toIso8601String()),
          Products(title: 'Газ',            price: '20 000 ₽',  weight: '-', id: '35', data: now.toIso8601String()),
          Products(title: 'Газ',            price: '20 000 ₽',  weight: '-', id: '35', data: weekAgo.toIso8601String()),
          Products(title: 'Газ',            price: '20 000 ₽',  weight: '-', id: '35', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Подарки',
        price: '30 000 ₽',
        products: [
          Products(title: 'Друзья', price: '10 000 ₽', weight: '-', id: '36', data: now.toIso8601String()),
          Products(title: 'Друзья', price: '10 000 ₽', weight: '-', id: '36', data: weekAgo.toIso8601String()),
          Products(title: 'Друзья', price: '10 000 ₽', weight: '-', id: '36', data: monthAgo.toIso8601String()),
          Products(title: 'Семья',  price: '20 000 ₽', weight: '-', id: '37', data: now.toIso8601String()),
          Products(title: 'Семья',  price: '20 000 ₽', weight: '-', id: '37', data: weekAgo.toIso8601String()),
          Products(title: 'Семья',  price: '20 000 ₽', weight: '-', id: '37', data: monthAgo.toIso8601String()),
        ],
      ),
      FoodPath(
        title: 'Подписки',
        price: '30 000 ₽',
        products: [
          Products(title: 'Netflix', price: '10 000 ₽', weight: '1 мес.', id: '38', data: now.toIso8601String()),
          Products(title: 'Netflix', price: '10 000 ₽', weight: '1 мес.', id: '38', data: weekAgo.toIso8601String()),
          Products(title: 'Netflix', price: '10 000 ₽', weight: '1 мес.', id: '38', data: monthAgo.toIso8601String()),
          Products(title: 'Spotify', price: '5 000 ₽',  weight: '1 мес.', id: '39', data: now.toIso8601String()),
          Products(title: 'Spotify', price: '5 000 ₽',  weight: '1 мес.', id: '39', data: weekAgo.toIso8601String()),
          Products(title: 'Spotify', price: '5 000 ₽',  weight: '1 мес.', id: '39', data: monthAgo.toIso8601String()),
          Products(title: 'Adobe CC', price: '15 000 ₽', weight: '1 мес.', id: '40', data: now.toIso8601String()),
          Products(title: 'Adobe CC', price: '15 000 ₽', weight: '1 мес.', id: '40', data: weekAgo.toIso8601String()),
          Products(title: 'Adobe CC', price: '15 000 ₽', weight: '1 мес.', id: '40', data: monthAgo.toIso8601String()),
        ],
      ),
    ],
  ),
];
