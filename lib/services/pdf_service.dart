import 'dart:io';

import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pdfw;

class PDFService {

  static Future<File> generatePDF(
      {String text, String diagnosisDate, String perc, String name, String email}) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) {
          return <Widget>[
            PdfLogo(),
            pdfw.SizedBox(width: 0.5 * PdfPageFormat.cm),
            pdfw.Header(child: pdfw.Text('EyeSee Diagnosis', style: pdfw.TextStyle(
              fontSize: 24,
              fontWeight: pdfw.FontWeight.bold,
              color: PdfColors.white
            )
            ),
              decoration: pdfw.BoxDecoration(
                color: PdfColors.grey
              ),
              padding: pdfw.EdgeInsets.all(5.0)
            ),
            ...buildBulletPoints(text, diagnosisDate, perc, name, email),

          ];
        }
      )
    );

    return saveDocument(name: 'Diagnosis - ${DateTime.now()}', pdf: pdf);
  }

  static Future<File> saveDocument({String name,Document pdf}) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    print('${dir.path}/$name');
    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    
    await OpenFile.open(url);
  }

  static List<Widget> buildBulletPoints(String text, String diagnosisDate, String perc, String name, String email) {

    return [
      Bullet(text: 'Name: $name'),
      Bullet(text: 'Diagnosis: $text'),
      Bullet(text: 'Accuracy: $perc%'),
      Bullet(text: 'Diagnosis Date: $diagnosisDate'),
      Bullet(text: 'Save Date: ${DateTime.now()}'),
      Bullet(text: 'E-mail: $email')
    ];
  }
}
