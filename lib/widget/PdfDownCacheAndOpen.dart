import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shulan_edu/http/Api.dart';

class PdfDownCacheAndOpen {
  static Future<String> downThePdfWithId(String pdd) {
    // 查看是否有缓存
    String ppresultPath = '';
    return getTemporaryDirectory().then((tempPath) {
      bool havCache = false;
      Directory pdfFoder = Directory('${tempPath.path}/PDF');
      bool haveDir = pdfFoder.existsSync();
      if (!haveDir) pdfFoder.createSync();
      pdfFoder.listSync().forEach((files) {
        if (files.path.contains(pdd)) {
          // 已有缓存
          havCache = true;
          OpenFile.open(files.path);
          ppresultPath = files.path;
        }
      });
      if (!havCache) {
        // 下载
        Options options = Options();
        options.responseType = ResponseType.bytes;
        return getTemporaryDirectory().then((tempPath) {
          String savePath = tempPath.path + '/PDF' + '/$pdd.pdf';
          return HttpUtils(needAuthor: false)
              .downloadFile(Api.downTheGuideApi + pdd, savePath,
              option: options)
              .then((data) {
            String hz = data.headers
                .value('content-disposition')
                .toString()
                .split('.')
                .last;
            return File(savePath)
                .rename(tempPath.path + '/PDF' + '/' + pdd + '.' + hz)
                .then((dd) {
              OpenFile.open(tempPath.path + '/PDF' + '/' + pdd + '.' + hz);
              ppresultPath = tempPath.path + '/PDF' + '/' + pdd + '.' + hz;
              return ppresultPath;
            });
          });
        });
      } else {
        return ppresultPath;
      }
    });
  }
}
