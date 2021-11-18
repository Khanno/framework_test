import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/helpers/string_helper.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_events.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_state.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartState(shoppingCart: [])) {
    on<AddItemToShoppingCart>((event, emit) => _addItemToState(event, emit));
    on<RemoveItemFromShoppingCart>((event, emit) => _removeItemFromState(event, emit));
    on<CreateAndSavePdf>((event, emit) => _createAndSavePdfToDevice(event, emit));
    on<ResetShoppingCart>((event, emit) => _resetShoppingCartState(event, emit));
  }

  void _addItemToState(
      AddItemToShoppingCart event, Emitter<ShoppingCartState> emit) {
    List<Product> shoppingCart = state.shoppingCart!;
    shoppingCart.add(event.product);
    emit(state.copyWith(shoppingCart: shoppingCart));
  }

  void _removeItemFromState(
      RemoveItemFromShoppingCart event, Emitter<ShoppingCartState> emit) {
    List<Product> shoppingCart = state.shoppingCart!;
    int productIndex = shoppingCart.indexOf(event.product);
    shoppingCart.removeAt(productIndex);
    emit(ShoppingCartState(shoppingCart: shoppingCart));
  }

  void _createAndSavePdfToDevice(CreateAndSavePdf event, Emitter<ShoppingCartState> emit) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    final pdf = pw.Document(title: 'Receipt', pageMode: PdfPageMode.fullscreen);
    final fontData = await rootBundle.load('assets/fonts/open-sans.ttf');
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    int total = 0;

    if (state.shoppingCart != null && state.shoppingCart!.isNotEmpty) state.shoppingCart!.forEach((item) => total += item.value as int);

    emit(CreatingPdfState(shoppingCart: state.shoppingCart!));

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Text('MobiMarket', style: pw.TextStyle(font: ttf, fontSize: 20)),
                pw.Text('Receipt', style: pw.TextStyle(font: ttf, fontSize: 20)),
                pw.Text('Value', style: pw.TextStyle(font: ttf, fontSize: 20)),
              ]
            ),
            pw.SizedBox(
              height: 15.0
            ),
            pw.ListView.builder(
              itemCount: state.shoppingCart!.length,
              itemBuilder: (pw.Context context, int index) => pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(state.shoppingCart![index].name as String,
                      style: pw.TextStyle(font: ttf, fontSize: 15)),
                  pw.Text(
                      'R\$ ${convertCentsToReal(state.shoppingCart![index].value as int)}',
                      style: pw.TextStyle(font: ttf, fontSize: 15)),
                ],
              ),
            ),
            pw.SizedBox(height: 35.0),
            pw.Text('Total: R\$ ${convertCentsToReal(total)}',
                style: pw.TextStyle(font: ttf, fontSize: 20)),
          ];
        }));
    String fileName = '$appDocPath/${DateTime.now()}.pdf';
    final File file = File(fileName);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(fileName);
    emit(PdfCreatedState());
  }

  void _resetShoppingCartState(ResetShoppingCart event, Emitter<ShoppingCartState> emit) {
    emit(ShoppingCartState(shoppingCart: []));
  }
}
