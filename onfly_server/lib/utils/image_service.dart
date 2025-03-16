import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart';

class ImageService {
  final String _storagePath = 'storage/receipts/';

  Future<String> saveImage(List<int> bytes, String filename) async {
    try {
      // Criar diretório se não existir
      final directory = Directory(_storagePath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Decodificar a imagem
      Image? image = decodeImage(Uint8List.fromList(bytes));
      if (image == null) {
        throw Exception('Invalid image format');
      }

      // Comprimir a imagem
      final compressedImage = encodeJpg(image, quality: 70);
      if (compressedImage.isEmpty) {
        throw Exception('Image compression failed');
      }

      // Definir caminho do arquivo
      final filePath = '$_storagePath$filename';

      // Salvar imagem
      final file = File(filePath);
      await file.writeAsBytes(compressedImage);

      return filePath;
    } catch (e) {
      print('❌ Error saving image: $e');
      throw Exception('Failed to save image');
    }
  }
}
