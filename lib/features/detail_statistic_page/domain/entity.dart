import 'dart:ui';

import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_theme.dart';

class Category {
  final String title;
  final String price;
  final String image;
  final Color color;
  final List<FoodPath> foodPath;

  Category(this.image, {required this.title, required this.price, required this.foodPath, required this.color});
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

  Products({required this.title, required this.price, required this.weight, required this.id});
}

final List<Category> categories = [
  Category(
    ImageAssets.food, // Путь к иконке еды
    title: 'Еда и напитки',
    price: '25,000 ₽',
    color: AppColors.orangeFood,
    foodPath: [
      FoodPath(
        title: 'Продукты',
        price: '3,400.99 ₽',
        products: [
          Products(title: 'Бананы',     price: '1,540.99 ₽', weight: '1.5 кг', id: '1'),
          Products(title: 'Пельмени',   price: '1,540.99 ₽', weight: '0.9 кг', id: '2'),
          Products(title: 'Йогурт',     price: '   860.00 ₽', weight: '0.5 кг', id: '3'),
          Products(title: 'Арбуз',      price: '   800.00 ₽', weight: '3.0 кг', id: '4'),
        ],
      ),
      FoodPath(
        title: 'Алкоголь',
        price: '3,400.99 ₽',
        products: [
          Products(title: 'Виски',      price: '1,200.00 ₽', weight: '0.5 л', id: '5'),
          Products(title: 'Водка',      price: '1,000.00 ₽', weight: '0.5 л', id: '6'),
          Products(title: 'Вино',       price: '   700.00 ₽', weight: '0.7 л', id: '7'),
          Products(title: 'Джин',       price: '   500.99 ₽', weight: '0.5 л', id: '8'),
        ],
      ),
      FoodPath(
        title: 'Рестораны/Бары',
        price: '3,400.99 ₽',
        products: [
          Products(title: 'The Бык',        price: '1,540.99 ₽', weight: '1 посещение', id: '9'),
          Products(title: 'Вкусно&Точка',   price: '1,000.00 ₽', weight: '2 посещения',  id: '10'),
          Products(title: 'Rostics',        price: '   400.00 ₽', weight: '1 посещение', id: '11'),
          Products(title: 'Столовка',       price: '   460.00 ₽', weight: '3 посещения', id: '12'),
        ],
      ),
    ],
  ),
  Category(
    ImageAssets.cloth, // Путь к иконке шопинга
    title: 'Шопинг',
    price: '10,000 ₽',
    color: AppColors.pinkAccent,
    foodPath: [
      FoodPath(
        title: 'Одежда',
        price: '4,000 ₽',
        products: [
          Products(title: 'Джинсы',     price: '2,000 ₽', weight: '-', id: '13'),
          Products(title: 'Рубашка',    price: '1,500 ₽', weight: '-', id: '14'),
          Products(title: 'Футболка',   price: '   500 ₽', weight: '-', id: '15'),
        ],
      ),
      FoodPath(
        title: 'Электроника',
        price: '3,000 ₽',
        products: [
          Products(title: 'Наушники',   price: '2,000 ₽', weight: '-', id: '16'),
          Products(title: 'Чехол',      price: '   500 ₽', weight: '-', id: '17'),
          Products(title: 'Зарядка',    price: '   500 ₽', weight: '-', id: '18'),
        ],
      ),
      FoodPath(
        title: 'Аксессуары',
        price: '3,000 ₽',
        products: [
          Products(title: 'Часы',       price: '2,000 ₽', weight: '-', id: '19'),
          Products(title: 'Очки',       price: '   500 ₽', weight: '-', id: '20'),
          Products(title: 'Ремень',     price: '   500 ₽', weight: '-', id: '21'),
        ],
      ),
    ],
  ),
  Category(
    ImageAssets.transports, // Путь к иконке транспорта
    title: 'Транспорт',
    price: '250,000 ₽',
    color: AppColors.black50,
    foodPath: [
      FoodPath(
        title: 'Такси',
        price: '100,000 ₽',
        products: [
          Products(title: 'Поездка 1', price: '60,000 ₽', weight: '1 поездка', id: '22'),
          Products(title: 'Поездка 2', price: '40,000 ₽', weight: '1 поездка', id: '23'),
        ],
      ),
      FoodPath(
        title: 'Автобус',
        price: '50,000 ₽',
        products: [
          Products(title: 'Поездка А', price: '25,000 ₽', weight: '1 поездка', id: '24'),
          Products(title: 'Поездка B', price: '25,000 ₽', weight: '1 поездка', id: '25'),
        ],
      ),
      FoodPath(
        title: 'Метро',
        price: '50,000 ₽',
        products: [
          Products(title: 'Проездной', price: '50,000 ₽', weight: '1 месяц', id: '26'),
        ],
      ),
      FoodPath(
        title: 'Топливо',
        price: '50,000 ₽',
        products: [
          Products(title: 'Заправка', price: '50,000 ₽', weight: '20 л', id: '27'),
        ],
      ),
    ],
  ),
  Category(
    ImageAssets.health, // Путь к иконке здоровья
    title: 'Здоровье',
    price: '75,000 ₽',
    color: AppColors.yellowAccent,
    foodPath: [
      FoodPath(
        title: 'Аптека',
        price: '25,000 ₽',
        products: [
          Products(title: 'Витамины',  price: ' 5,000 ₽', weight: '-', id: '28'),
          Products(title: 'Лекарства', price: '20,000 ₽', weight: '-', id: '29'),
        ],
      ),
      FoodPath(
        title: 'Спорт',
        price: '30,000 ₽',
        products: [
          Products(title: 'Абонемент в зал', price: '30,000 ₽', weight: '6 мес.', id: '30'),
        ],
      ),
      FoodPath(
        title: 'Визиты',
        price: '20,000 ₽',
        products: [
          Products(title: 'Терапевт',      price: '10,000 ₽', weight: '1 приём', id: '31'),
          Products(title: 'Стоматолог',    price: '10,000 ₽', weight: '1 приём', id: '32'),
        ],
      ),
    ],
  ),
  Category(
    ImageAssets.other, // Путь к иконке прочих
    title: 'Прочие',
    price: '100,000 ₽',
    color: AppColors.green,
    foodPath: [
      FoodPath(
        title: 'Жильё и ЖКХ',
        price: '40,000 ₽',
        products: [
          Products(title: 'Электричество', price: '15,000 ₽', weight: '-', id: '33'),
          Products(title: 'Вода',           price: ' 5,000 ₽', weight: '-', id: '34'),
          Products(title: 'Газ',            price: '20,000 ₽', weight: '-', id: '35'),
        ],
      ),
      FoodPath(
        title: 'Подарки',
        price: '30,000 ₽',
        products: [
          Products(title: 'Друзья',      price: '10,000 ₽', weight: '-', id: '36'),
          Products(title: 'Семья',       price: '20,000 ₽', weight: '-', id: '37'),
        ],
      ),
      FoodPath(
        title: 'Подписки',
        price: '30,000 ₽',
        products: [
          Products(title: 'Netflix',     price: '10,000 ₽', weight: '1 мес.', id: '38'),
          Products(title: 'Spotify',     price: ' 5,000 ₽', weight: '1 мес.', id: '39'),
          Products(title: 'Adobe CC',    price: '15,000 ₽', weight: '1 мес.', id: '40'),
        ],
      ),
    ],
  ),
];
