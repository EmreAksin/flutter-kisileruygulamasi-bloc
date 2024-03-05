import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/sqlite/veritabani_yardimcisi.dart';

class KisilerDaoRepository {
  Future<void> kaydet(String kisi_ad, String kisi_tel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniKisi = Map<String,dynamic>();
    yeniKisi["kisi_ad"] = kisi_ad;
    yeniKisi["kisi_tel"] = kisi_tel;
    await db.insert("kisiler", yeniKisi);
  }
  Future<void> guncelle(int kisi_id,String kisi_ad, String kisi_tel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncelenenKisi = Map<String,dynamic>();
    guncelenenKisi["kisi_ad"] = kisi_ad;
    guncelenenKisi["kisi_tel"] = kisi_tel;
    await db.update("kisiler", guncelenenKisi, where: "kisi_id = ?",whereArgs: [kisi_id]);
  }

  Future<List<Kisiler>> kisilerYukle() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");
    return List.generate(
        maps.length, (index) {
          var satir = maps[index];
          return Kisiler(kisi_id: satir["kisi_id"], kisi_ad: satir["kisi_ad"], kisi_tel: satir["kisi_tel"]);
    } );
  }

  Future<void> sil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("kisiler",where: "kisi_id = ?",whereArgs: [kisi_id]);
  }


  Future<List<Kisiler>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%' ");
    return List.generate(
        maps.length, (index) {
      var satir = maps[index];
      return Kisiler(kisi_id: satir["kisi_id"], kisi_ad: satir["kisi_ad"], kisi_tel: satir["kisi_tel"]);
    } );
  }
}