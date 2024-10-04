import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'main/app.dart';
import 'main/global.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  // Set the publishable key from your Stripe dashboard
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  await Global.init();

  runApp(const MyApp());
}