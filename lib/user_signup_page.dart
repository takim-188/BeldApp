
import 'dart:convert';
import 'dart:io';
import 'package:beldapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'SignInSignUpButton.dart';
import 'admin_signin_page.dart';
import 'auth.dart';
import 'homepage2.dart';



class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({Key? key}) : super(key: key);

  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  String? errorMessage;
  var auth = AuthenticationService(FirebaseAuth.instance);
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? text = "";
  final _registerFormKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: width,
          height: size.height,
          child: ListView(children: <Widget>[
            SingleChildScrollView(
              child: Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // Text("SIGNUP", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 4, width * 0.05, 4),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return ("Kullanıcı adı boş bırakılamaz");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Geçerli bir isim giriniz(Min. 3 Karakter)");
                            }
                            return null;
                          },
                          controller: controller,
                          onChanged: (value) {},
                          onSaved: (value){
                            controller.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Ad Soyad",
                              hintText: "Ad Soyad",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide(color: Colors.redAccent))),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 4, width * 0.05, 4),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression for email validation
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Lütfen geçerli bir mail adresi giriniz");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide())),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 4, width * 0.05, 4),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          autofocus: false,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          obscureText: _obscureText,
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: _toggle,
                              ),
                              labelText: "Şifre",
                              hintText: "Şifre",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide())),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, 4, width * 0.05, 20),
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          validator: (value) {
                            if (passwordController2.text !=
                                passwordController2.text) {
                              return "Şifre uyuşmuyor";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordController2.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {},
                          obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          controller: passwordController2,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: _obscureText
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: _toggle,
                              ),
                              labelText: "Şifre Onayı",
                              hintText: "Şifre Onayı",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(

                                      style: BorderStyle.solid))),
                        ),
                      ),
                    ),

                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const SingleChildScrollView(
                              child:AlertDialog(
                                title: Text("KVKK Aydınlatma Metni"),
                                content: Text(
                                    " 1)	VERİ SORUMLUSU VE TEMSİLCİSİ"
                                        "6698 sayılı Kişisel Verilerin Korunması Kanunu (“6698 sayılı Kanun”) uyarınca; veri sorumlusu sıfatıyla BeldApp Uygulaması olarak; kişisel veri mahremiyeti ve özel hayatın gizliliğine önem veriyoruz."
                                        "Kişisel verilerinizi 6698 sayılı Kişisel Verilerin Korunması Kanun’un 4. Maddesi çerçevesinde aşağıda belirtilen amaçlar kapsamında;"
                                        "•	İşlenmelerini gerektiren amaç çerçevesinde ve bu amaç ile bağlantılı, sınırlı ve ölçülü şekilde, hukuka ve dürüstlük kurallarına uygun olarak,"
                                        "•	Tarafımıza bildirdiğiniz veya tarafımıza bildirilen şekliyle kişisel verilerin doğruluğunu ve en güncel halini koruyarak;"
                                        "•	İşleyebilecek, kaydedebilecek, depolayabilecek, muhafaza edilerek saklayabilecek, sınıflandırabilecek, güncelleyebilecek ve mevzuatın izin verdiği hallerde, işlendikleri amaçla sınırlı olarak 3. kişilere açıklayabilecek ve/veya aktarabileceğiz."
                                        "2)	İŞLENEBİLECEK KİŞİSEL VERİLERİNİZ"
                                        "İşlenebilecek kişisel verilerinizin kapsamına aşağıda yer alan kişisel veriler girmektedir;"
                                        "Kimlik Verisi: Kişi kimliğine dair bilgilerin bulunduğu veri grubudur. (Ad soyad, TC Kimlik No, imza, anne adı, baba adı, doğum yeri, doğum tarihi, nüfusa kayıtlı olduğu yer (il/ilçe/mahalle), nüfus cüzdanı seri ve no, aile sıra no, Cilt ve sıra no, medeni hal, kimlik kayıt numaraları, veriliş nedeni/ yeri/tarihi, nüfus cüzdanı, ehliyet ve pasaport fotokopisi, bakmakla yükümlü olunan kişiler, cinsiyet, uyruk, sgk no, vergi numarası, ruhsat fotokopisi, çalışan kartı, cinsiyet,"
                                        "İletişim Verisi: Kişiye ulaşmak için kullanılabilecek veri grubudur."
                                        "Görsel/İşitsel Veri: Kişiye ait görsel ve işitsel verilerin bulunduğu veri grubudur."
                                        "(Fotoğraf, ses kaydı, kamera kaydı, ehliyet/kimlik fotokopisi/taraması)"
                                        "Finansal Veri: Kişinin finansal bilgilerinin bulunduğu veri grubudur."
                                        "(Banka hesap no, iban no, kart bilgisi, banka adı, fatura, cari hesap)"
                                        "Çalışma Verisi: Çalışılan şirket, departman ve pozisyon bilgisi,"
                                        "Aile ve Yakını Verisi: Yakınlarının adı-soyadı, numarası, TC Kimlik numarası"
                                        "Hukuki İşlem: Resmi kurum ve kuruluşlar ile yapılan yazışmalar, icra takip dosyalarına ilişkin dosya ve borç bilgileri"
                                        "*Diğer: Danışman sekmesinden yapılan başvurular için başvurulan pozisyon, başvuru yapılan merkez ve tarafınızca yüklenmesi halinde özgeçmiş, askerlik durum bilgisi,"
                                        "Web sitesi: Log kayıtları, tarayıcı verileri ile oturum çerezleri"
                                        "3)	KİŞİSEL VERİLERİNİZİN İŞLENME AMACI"
                                        "Siz danışanlarımız, danışmanlarımız ve ziyaretçilerimiz den elde ettiğimiz kişisel veriler, aşağıda belirtilen amaçlar ve bunlarla sınırlı olmamak üzere benzer amaç ve sebeplerle işlenebilmektedir."

                                        "•	Yasal ve düzenleyici gereksinimlerin yerine getirilmesi,"
                                        "•	Üye olmanız halinde; hizmetlerimizin sizlere duyurulması, bildirim talepleriniz hakkında bildirim,"
                                        "•	Verilerin bilimsel çalışmalarda kullanılması,"
                                        "•	Hizmetlerin geliştirilebilmesi amacıyla analiz ve benzeri çalışmalar yapılması,"
                                        "•	Risk Yönetimi ve kalite geliştirme faaliyetlerinin planlanması ve yapılması,"
                                        "•	Kalite ve verimlilik çalışmalar, raporları,"
                                        "•	İlgili Mevzuat gereği saklanması gereken sağlık verilerinize ilişkin bilgileri muhafaza etme, saklama ve arşiv faaliyetlerinin yürütülmesi,"
                                        "•	Anlaşmalı olduğumuz kurumlarla, size sunulan sağlık hizmetine ilişkin finansal mutabakatlar sağlanması,"
                                        "•	Görevlendirme süreçlerinin yürütülmesi,"
                                        "•	Hukuk işlerinin takibi ve yürütülmesi ve mahkeme kararlarının yerine getirilmesi,"
                                        "•	Mevzuat gereği kurumlarca öngörülen bilgi saklama, raporlama ve bilgilendirme yükümlülükleri"
                                        "•	Bilgi güvenliği süreçlerinin planlanması, denetimi ve icrası,"
                                        "•	Kurumsal iletişim faaliyetlerinin planlanması ve icrası,"
                                        "•	Evrak işlerinin yürütülmesi ve takibi,"
                                        "•	Faaliyetlerin mevzuata uygun yürütülmesi,"
                                        "•	İş faaliyetlerinin yürütülmesi ve denetimi, İş sürekliliğinin sağlanması faaliyetlerinin yürütülmesi, iş süreçlerinin iyileştirilmesine yönelik önerilerin alınması ve değerlendirilmesi,"
                                        "•	İnternet sitesinin işlevselliğini ve performansını artırmak yoluyla sizlere sunulan hizmetleri geliştirmek,"
                                        "•	İnternet sitesini iyileştirmek ve internet sitesi üzerinden yeni özellikler sunmak ve sunulan özellikleri sizlerin tercihlerine göre kişiselleştirmek, İnternet sitesinin sizin ve kurumun hukuki ve ticari güvenliğinin teminini sağlamak"
                                        "*Mal/hizmet satış sonrası destek hizmetlerinin yürütülmesi, Müşteri ilişkileri yönetim süreçlerinin yönetilmesi, Müşteri memnuniyetine yönelik aktivitelerin yürütülmesi, reklam, pazarlama ve analiz çalışmalarının yürütülmesi, reklam kampanya promosyon süreçlerinin yürütülmesi, web push hizmetlerinin yürütülmesi,"
                                        "•	Performans değerlendirme süreçlerinin yürütülmesi,"
                                        "•	Risk yönetimi süreçlerinin yürütülmesi,"
                                        "•	Sözleşme süreçlerinin yürütülmesi,"
                                        "•	Stratejik planlama faaliyetlerinin yürütülmesi,"
                                        "•	Saklama arşiv faaliyetlerinin yürütülmesi,"
                                        "•	Talep ve şikâyetlerin takibi,"
                                        "•	Ürün ve hizmetlerin pazarlama süreçlerinin yürütülmesi,"
                                        "•	Veri sorumlusu operasyonlarının güvenliğinin temini,"
                                        "•	Yetkili kişi, kurum ve kuruluşlara bilgi verilmesi,"
                                        "•	Yönetim faaliyetlerinin yürütülmesi."
                                        "•	Çağrı Merkezi aramalarında;"
                                        "4)	KİŞİSEL VERİLERİNİZİN YURTİÇİ AKTARILMASI"
                                        "Kişisel verileriniz; yukarıda açıklanan amaçlar doğrultusunda ve 6698 sayılı Kanun’un 8. ve 9. maddelerinde belirtilen kişisel veri işleme şartları ve amaçları çerçevesinde, gerekli güvenlik önlemleri alınarak, Sosyal Güvenlik Kurumu, Sağlık Bakanlığı, İl Sağlık Müdürlüğü, Cumhuriyet Başsavcılıkları, Mahkeme ve icra müdürlükleri kapsamında ilgili Kurum ve Kuruluşlarla, anlaşmalı olduğumuz laboratuvarlarla, bağlı ortaklıklarımızla, anlaşmalı hekimlerimizle, İnternet üzerinden online hizmetlerle etkin hizmet verebilmek için online hizmet birimlerine, Hukuki yükümlülüklerimiz ve savunma hakkımız kapsamında ilgili resmi makamlarla paylaşabiliyoruz."
                                        "5)	KİŞİSEL VERİLERİNİZİN YURT DIŞINA AKTARILMASI"
                                        "İmzalamış olduğunuz üyelik sözleşmesi, mesafeli satış sözleşmesi veya aldığınız vb. hizmetler doğrultusunda elde ettiğimiz kişisel verileriniz; yukarıda açıklanan amaçlar doğrultusunda ve 6698 sayılı Kanun’un 8. ve 9. maddelerinde belirtilen kişisel veri işleme şartları ve amaçları çerçevesinde, gerekli güvenlik önlemleri alınarak; Kurul tarafından yeterli korumaya sahip olduğu ilan edilen yabancı ülkelere veya  açık rızanıza dayanarak belirtilen ve benzer amaçlarla sınırlı olarak aktarılabilecektir."
                                        "6)KİŞİSEL VERİLERİN TOPLANMA YÖNTEMİ VE HUKUKİ SEBEBİ"
                                        "Veri sorumlusu olarak yasal yükümlülüklerimizi yerine getirmek, faaliyetlerimizi yürütmek, merkezimizin meşru menfaatlerini korumak, sağlık, tedavi ve tanı konulması amacıyla ve kanunlarda öngörülen nedenlerle; sizden bizzat veya web sitemiz/telefon vasıtasıyla talep ettiğimiz veya sizin bizimle paylaşmayı tercih ettiğiniz kişisel verileriniz, e-posta vasıtasıyla ve yukarıda belirtilen hukuki sebeplere dayanarak toplanmaktadır."
                                        "Bu süreçte toplanan kişisel verileriniz; yukarıda sayılan süreçleri gerçekleştirebilmek amacıyla, sağlık hizmetlerinin ifasındaki yasal gereklilikler çerçevesinde etkin ve verimli olarak gerçekleştirilmesi, özen yükümlülüğünün yerine getirilmesi ve faaliyetlerimizi yürütebilmek sebebiyle, fiziki ve elektronik ortamda Kanun ile belirlenmiş şekilde güvenli bir biçimde toplanmaktadır."
                                        "Bu çerçevede kişisel verileriniz, yukarıda belirtilen amaçlarla; 6698 sayılı Kanun’un md.5/2-ç doğrultusunda hukuki yükümlülüklerimize uyabilmek, md.5/2-f doğrultusunda meşru menfaatlerimiz çerçevesinde ve faaliyet konumuz doğrultusunda 6. Maddede belirtilen kişisel veri işleme şartları ve amaçları dâhilinde ve gerekli durumlarda da açık rızanıza dayanarak bu amaçlar ile bağlantılı, sınırlı ve ölçülü şekilde işlenecektir."
                                        "7)	KİŞİSEL VERİ SAHİBİNİN 6698 SAYILI KANUN’UN 11’MADDESİNDE SAYILAN HAKLARI"
                                        "Kişisel veri sahipleri olarak, aşağıda belirttiğimiz haklarınıza ilişkin taleplerinize BeldApp Uygulamasına başvurmanız halinde; talebinizin niteliğine göre en geç 30 (otuz) gün içinde ücretsiz olarak yanıt verilecektir."
                                        "Kişisel Veri sahipleri olarak, aşağıda belirtmiş olduğumuz haklarınıza ilişkin taleplerinizle veya şikayetlerinizle ilgili olarak ekte yer alan başvuru formunu, talebiniz veya şikayetiniz doğrultusunda doldurarak, doldurmuş olduğunuz söz konusu formu (bilgi için BeldApp uygulamasına ait e-posta adresi) üzerinden tarafımıza iletebilirsiniz. Dilerseniz, söz konusu formu fiziki olarak doldurarak (BeldApp’in açık ve anlaşılır adresi yazılacak buraya) kargo veya posta yoluyla gönderebilirsiniz. Talebinizin veya Şikayetinizin niteliğine göre en geç 30 (otuz) gün içinde yanıt verilecektir."
                                        "Talepleriniz kural olarak ücretsiz karşılanır ancak, talebinizin gereğini yerine getirmek masraf gerektiriyorsa “Veri Sorumlusuna Başvuru Usul ve Esasları Hk. Tebliğ” madde 7’de öngörülen; “İlgili kişinin başvurusuna yazılı olarak cevap verilecekse, 10 sayfaya kadar ücret alınmaz. 10 sayfanın üzerindeki her sayfa için 1 TL işlem ücreti alınabilir. Başvuruya cevabın CD, flash bellek gibi bir kayıt ortamında verilmesi halinde veri sorumlusu tarafından talep edilebilecek ücret kayıt ortamının maliyetini geçemez.” hükmü gereğince BeldApp tarafından ücret istenebilecektir."
                                        "Bu kapsamda kişisel veri sahipleri KVKK m.11 uyarınca;"
                                        " •	Kişisel verilerinin işlenip işlenmediğini öğrenme,"
                                        " •	Kişisel verileri işlenmişse buna ilişkin bilgi talep etme,"
                                        "•	Kişisel verilerinin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme,"
                                        "•	Yurt içinde veya yurt dışında kişisel verilerinin aktarıldığı üçüncü kişileri bilme,"
                                        "•	Kişisel verilerinin eksik veya yanlış işlenmiş olması hâlinde bunların düzeltilmesini isteme ve bu kapsamda yapılan işlemin kişisel verilerin aktarıldığı üçüncü kişilere bildirilmesini isteme,"
                                        "•	KVK Kanunu ve ilgili diğer mevzuat hükümlerine uygun olarak işlenmiş olmasına rağmen, işlenmesini gerektiren sebeplerin ortadan kalkması hâlinde kişisel verilerinin silinmesini veya yok edilmesini isteme ve bu kapsamda yapılan işlemin kişisel verilerin aktarıldığı üçüncü kişilere bildirilmesini isteme,"
                                        "•	İşlenen verilerinin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme,"
                                        "•	Kişisel verilerinin kanuna aykırı olarak işlenmesi sebebiyle zarara uğraması hâlinde zararın giderilmesini talep etme, haklarına sahiptir."
                                        "•	Başvurunuzu açık, anlaşır bir şekilde ve kimlik ve adres bilgilerini tespit edici belgeleri de ekleyerek, yazılı ve ıslak imzalı olarak elden veya yukarıda belirtilen şekillerde BeldApp Uygulamasına ulaştırmanız gerekmektedir."

                                        "8)	KİŞİSEL VERİLERİN SAKLANMASI"
                                        "Kişisel verileriniz, işlenme amaçlarının gerektirdiği süreler boyunca saklanabilmektedir. Başka bir gerekçe veya hukuki sebep olmaması, uluslararası kanun veya düzenlemenin bulunmaması ve sözleşmelerden kaynaklı zorunlulukların ortadan kalkması halinde işlenme amaçları ortadan kalkan kişisel verileriniz silinmekte, yok edilmekte veya anonim hale getirilmektedir."
                                        "9)	BİLGİLERİNİZİN GÜNCELLENMESİ TALEBİ"
                                        "Tarafınızdan elde ettiğimiz ve işlediğimiz kişisel verilerinizin doğru ve gerektiğinde güncel olması gerekmektedir. Bu nedenle, kişisel verilerinizde herhangi bir değişiklik meydana gelmesi halinde, bu hususu BeldApp’in ilgili birimine bildirebilirsiniz."
                                        "10)	VERİ SORUMLUSU VE İRTİBAT KİŞİSİ"
                                        "VERİ SORUMLUSU BİLGİSİ;"
                                        "Açık Adı	:BeldApp Şirket Ortaklığı"
                                        "Adres		:Ankara"
                                        "İnternet Sitesi	:"
                                        "İRTİBAT KİŞİSİ BİLGİSİ;"
                                        "Adı		:Furkan"
                                        "Soyadı		:SARIKAYA"
                                        "E-Posta	:beldeapp.team188@gmail.com"
                                        "Telefon	:"
                                        "Unvanı		:Yazılımcı-Avukat"
                                ),
                              ),
                            ),);
                        },
                        child: Text("KVKK Aydınlatma Metni'ni okudum onaylıyorum.")),
                    SizedBox(height: 50,),
                    SingInSingUpButton(
                      context: context,
                      isLogin: false,
                      boyut: 0.8,
                      onTap: () async {
                        auth.signUp(email: emailController.text, password: passwordController.text, ).then((value)async{
                          await FirebaseFirestore.instance.collection("users").doc("${FirebaseAuth.instance.currentUser?.uid}").set({
                            "username": controller.text,
                            "email": emailController.text,
                          });
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          elevation: 20,
                          child: Container(
                            height: 35,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                // backgroundColor: MaterialStateProperty.resolveWith((states){
                                //   if(states.contains(MaterialState.pressed)){
                                //     return Colors.black26;
                                //   }
                                //   return Colors.white;
                                // }),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  )
                              ),
                              onPressed:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminSignIn()));
                              } ,
                              child: Text("Çalışan Girişi"),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          elevation: 20,
                          child: Container(
                            height: 35,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  // backgroundColor: MaterialStateProperty.resolveWith((states){
                                  //   if(states.contains(MaterialState.pressed)){
                                  //     return Colors.black26;
                                  //   }
                                  //   return Colors.white;
                                  // }),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    )
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage2()));
                                },
                                child: Icon(Icons.login)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }


  signUp(email, password) async{
    var url = "https://10.0.2.2:5000/signup";
    final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password
        })
    );

    print(response.body);
    // if(response.statusCode == 201){
    //
    // }
  }
}