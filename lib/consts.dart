import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_shop_ui/models/cart_model.dart';
import 'package:shoes_shop_ui/models/sparepart_model.dart';

final TextStyle style = GoogleFonts.lato(
    fontSize: 30, color: Colors.white, fontWeight: FontWeight.w700);
const Color bleu = Color(0xFF148BFF);
const Color red = Color(0xFFC3011B);
const Color white = Color(0xFFDCDBEB);

List<ShoesModel> racinglist = [
  ShoesModel(
      name: 'Knalpot',
      img: 'assets/images/knalpotproliner.png',
      company: 'Pro Liner',
      price: 850000,
      isselected: false,
      color: red),
  ShoesModel(
      name: 'Ban Michelin',
      img: 'assets/images/banmichelin.png',
      company: 'Michelin',
      price: 650000,
      isselected: false,
      color: Colors.amber.shade700),
  ShoesModel(
      name: 'Stang Motor',
      img: 'assets/images/stangdaitona.png',
      company: 'Daitona',
      price: 950000,
      isselected: false,
      color: bleu),
];

List<ShoesModel> olilist = [
  ShoesModel(
      name: 'Oli Motul',
      img: 'assets/images/olimotul.png',
      company: 'Motul',
      price: 55000,
      isselected: false,
      color: Colors.teal),
  ShoesModel(
      name: 'Oli Mpx',
      img: 'assets/images/olimpx.png',
      company: 'Honda',
      price: 45000,
      isselected: false,
      color: Colors.amber.shade700),
  ShoesModel(
      name: 'Oli Shell',
      img: 'assets/images/olishell.png',
      company: 'Shell',
      price: 54500,
      isselected: false,
      color: bleu),
];

List<ShoesModel> otherlist = [
  ShoesModel(
      name: 'Rantai TDR',
      img: 'assets/images/rantaitdr.png',
      company: 'TDR',
      price: 200000,
      isselected: false,
      color: Colors.amber.shade700),
  ShoesModel(
      name: 'Rantai SSS',
      img: 'assets/images/rantaisss.png',
      company: 'SSS',
      price: 220000,
      isselected: false,
      color: bleu),
  ShoesModel(
      name: 'ShockBreaker',
      img: 'assets/images/shockbreakeryss.png',
      company: 'YSS',
      price: 800000,
      isselected: false,
      color: red),
];

List<ShoesModel> allsparepart = racinglist + olilist + otherlist;
List<CartModel> boughtitems = [];
List<ShoesModel> favouriteitems = [];

double total = 0.00;
