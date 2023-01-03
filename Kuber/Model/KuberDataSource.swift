//
//  DistrictDataSource.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 14.12.2022.
//

import Foundation
struct KuberDataSource {

    private let districtArray: [District]
    private let majorrArray: [String]

    init() {
        districtArray = [
            District(
                name: "Koç Üniversitesi Kampüsleri",
                neighbourhood: ["Ana Kampüs", "Batı Kampüs"]
            ),
            District(
                name: "Adalar",
                neighbourhood: ["Burgazada", "Heybeliada", "Kınalıada", "Maden", "Nizam"]
            ),
            District(
                name: "Arnavutköy",
                neighbourhood: ["Anadolu", "İmrahor", "İslambey", "Arnavutköy Merkez", "Yavuz Selim", "Atatürk", "Bahşayış", "Boğazköy Atatürk", "Boğazköy İstiklal", "Boğazköy Merkez", "Bolluca", "Deliklikaya", "Dursunköy", "Durusu Cami", "Durusu Zafer", "Hastane", "İstasyon", "Sazlıbosna", "Nakkaş", "Karlıbayır", "Haraççı", "Hicret", "Mavigöl", "Nenehatun", "Ömerli", "Taşoluk", "Taşoluk Adnan Menderes", "Taşoluk Çilingir", "Taşoluk Fatih", "Taşoluk M. Fevzi Çakmak", "Taşoluk Mehmet Akif Ersoy", "Yeşilbayır"]
            ),
            District(
                name: "Ataşehir",
                neighbourhood: ["Aşıkveysel", "Atatürk", "Barbaros", "Esatpaşa", "Ferhatpaşa", "Fetih", "İçerenköy", "İnönü", "Kayışdağı", "Küçükbakkalköy", "Mevlana", "Mimarsinan", "Mustafa Kemal", "Örnek", "Yeniçamlıca", "Yenişehir", "Yenisahra"]
            ),
             District(
                 name: "Avcılar",
                 neighbourhood: ["Ambarlı", "Cihangir", "Denizköşkler", "Firuzköy", "Gümüşpala", "Merkez", "Mustafa Kemal Paşa", "Tahtakale", "Üniversite", "Yeşilkent"]
             ),
            District(
                name: "Bağcılar",
                neighbourhood: ["15 Temmuz", "Bağlar", "Barbaros", "Çınar", "Demirkapı", "Fatih", "Fevzi Çakmak", "Göztepe", "Güneşli", "Hürriyet", "İnönü", "Kâzım Karabekir", "Kemalpaşa", "Kirazlı", "Mahmutbey", "Merkez", "Sancaktepe", "Yavuzselim", "Yenigün", "Yenimahalle", "Yıldıztepe", "Yüzyıl"]
            ),
            District(
                name: "Bahçelievler",
                neighbourhood: ["Bahçelievler", "Cumhuriyet", "Çobançeşme", "Fevzi Çakmak", "Hürriyet", "Kocasinan", "Siyavuşpaşa", "Soğanlı", "Şirinevler", "Yenibosna", "Zafer"]
            ),
             District(
                 name: "Bakırköy",
                 neighbourhood: ["Ataköy 1. kısım", "Ataköy 2-5-6. kısım", "Ataköy 3-4-11. kısım", "Ataköy 7-8-9-10. kısım", "Basınköy", "Cevizlik", "Kartaltepe", "Osmaniye", "Sakızağacı", "Şenlikköy", "Yenimahalle", "Yeşilköy", "Yeşilyurt", "Zeytinlik", "Zuhuratbaba"]
             ),
            District(
                name: "Başakşehir",
                neighbourhood: ["Altınşehir", "Bahçeşehir 1. Kısım", "Bahçeşehir 2. Kısım", "Başak", "Başakşehir", "Güvercintepe", "Kayabaşı", "Şahintepe", "Şamlar", "Ziya Gökalp"]
            ),
            
            District(
                name: "Bayrampaşa",
                neighbourhood:["Altıntepsi", "Cevatpaşa", "İsmetpaşa", "Kartaltepe", "Kocatepe", "Muratpaşa", "Orta", "Terazidere", "Vatan", "Yenidoğan", "Yıldırım"]
            ),
             District(
                 name: "Beşiktaş",
                 neighbourhood: ["Abbasağa", "Akat", "Arnavutköy", "Balmumcu", "Bebek", "Cihannüma", "Dikilitaş", "Etiler", "Gayrettepe", "Konaklar", "Kuruçeşme", "Kültür", "Levazım", "Levent", "Mecidiye", "Muradiye", "Nisbetiye", "Ortaköy", "Sinanpaşa", "Türkali", "Ulus", "Vişnezade", "Yıldız"]
             ),
            District(
                name: "Beykoz",
                neighbourhood: ["Acarlar", "Akbaba", "Alibahadır", "Anadolufeneri", "Anadoluhisarı", "Anadolukavağı", "Baklacı", "Bozhane", "Cumhuriyet", "Çamlıbahçe", "Çengeldere", "Çiftlik", "Çiğdem", "Çubuklu", "Dereseki", "Elmalı", "Fatih", "Göksu", "Göllü", "Görele", "Göztepe", "Gümüşsuyu", "İncirköy", "İshaklı", "Kanlıca", "Kavacık", "Kaynarca", "Kılıçlı", "Merkez", "M.Şevketpaşa", "Ortaçeşme", "Öğümce", "Örnekköy", "Paşabahçe", "Paşamandıra", "Polonezköy", "Poyrazköy", "Riva", "Rüzgarlıbahçe", "Soğuksu", "Tokatköy", "Yalıköy", "Yavuz Selim", "Yenimahalle", "Zerzevatçı"]
            ),
            District(
                name: "Beylikdüzü",
                neighbourhood: ["Adnan Kahveci", "Barış", "Büyükşehir", "Cumhuriyet", "Dereağzı", "Gürpınar", "Kavaklı", "Marmara", "Sahil", "Yakuplu"]
            ),
             District(
                 name: "Beyoğlu",
                 neighbourhood: ["Arapcami", "Asmalımescit", "Bedrettin", "Bereketzade", "Bostan", "Bülbül", "Camiikebir", "Cihangir", "Çatmamescit", "Çukur", "Emekyemez", "Evliya Çelebi", "Fetihtepe", "Firuzağa", "Gümüşsuyu", "Hacıahmet", "Hacımimi", "Halıcıoğlu", "Hüseyinağa", "İstiklal", "Kadı Mehmet Efendi", "Kamerhatun", "Kalyoncukulluğu", "Kaptanpaşa", "Katip Mustafa Çelebi", "Keçecipiri", "Kemankeş Kara Mustafa Paşa", "Kılıçalipaşa", "Kocatepe", "Kulaksız", "Kuloğlu", "Küçükpiyale", "Müeyyetzade", "Ömeravni", "Örnektepe", "Piripaşa", "Piyalepaşa", "Pürtelaş", "Sururi", "Sütlüce", "Şahkulu", "Şehit Muhtar", "Tomtom", "Yahya Kahya", "Yenişehir"]
             ),
             District(
                 name: "Büyükçekmece",
                 neighbourhood: ["19 Mayıs", "Ahmediye", "Alkent 2000", "Atatürk", "Bahçelievler", "Celaliye", "Cumhuriyet", "Çakmaklı", "Dizdariye", "Ekinoba", "Fatih", "Güzelce", "Hürriyet", "Kamiloba", "Karaağaç", "Kumburgaz", "Mimaroba", "Mimarsinan", "Muratçeşme", "Pınartepe", "Sinanoba", "Türkoba", "Ulus", "Yenimahalle"]
             ),
             District(
                 name: "Çatalca",
                 neighbourhood: ["Akalan", "Atatürk", "Aydınlar", "Bahşayiş", "Başak", "Belgrat", "Celepköy", "Çakıl", "Çanakça", "Çiftlikköy", "Dağyenice", "Elbasan", "Fatih", "Ferhatpaşa", "Gökçeali", "Gümüşpınar", "Hallaçlı", "Hisarbeyli", "İhsaniye", "İnceğiz", "İzzettin", "Kabakça", "Kaleiçi", "Kalfa", "Karacaköy", "Karamandere", "Kestanelik", "Kızılcaali", "Muratbey", "Nakkaş", "Oklalı", "Ormanlı", "Ovayenice", "Örcünlü", "Örencik", "Subaşı", "Yalıköy", "Yaylacık", "Yazlık"]
             ),
              District(
                  name: "Çekmeköy",
                  neighbourhood: ["Alemdağ", "Aydınlar", "Cumhuriyet", "Çamlık", "Çatalmeşe", "Ekşioğlu", "Güngören", "Hamidiye", "Hüseyinli", "Kirazlıdere", "Koçullu", "Mehmet Akif", "Merkez", "Mimar Sinan", "Nişantepe", "Ömerli", "Reşadiye", "Sırapınar", "Soğukpınar", "Sultançiftliği", "Taşdelen"]
              ),
             District(
                 name: "Esenler",
                 neighbourhood: ["15 Temmuz", "Birlik", "Çiftehavuzlar", "Davutpaşa", "Fatih", "Fevzi Çakmak", "Havaalanı", "Kazım Karabekir", "Kemer", "Menderes", "Mimar Sinan", "Namık Kemal", "Nenehatun", "Oruçreis", "Tuna", "Turgutreis", "Yavuz Selim"]
             ),
             District(
                 name: "Esenyurt",
                 neighbourhood: ["Akçaburgaz", "Akevler", "Akşemseddin", "Ardıçlı", "Aşık Veysel", "Atatürk", "Bağlarçeşme", "Balık Yolu", "Barbaros Hayrettin Paşa", "Battalgazi", "Cumhuriyet", "Çınar", "Esenkent", "Fatih", "Gökevler", "Güzelyurt", "Hürriyet", "İncirtepe", "İnönü", "İstiklal", "Koza", "Mehmet Akif Ersoy", "Mehterçeşme", "Mevlana", "Namık Kemal", "Necip Fazıl Kısakürek", "Orhan Gazi", "Osmangazi", "Örnek", "Pınar", "Piri Reis", "Saadetdere", "Selahaddin Eyyubi", "Sultaniye", "Süleymaniye", "Şehitler", "Talatpaşa", "Turgut Özal", "Üçevler", "Yenikent", "Yeşilkent", "Yunus Emre", "Zafer"]
             ),
              District(
                  name: "Eyüpsultan",
                  neighbourhood: ["5. Levent", "Akşemsettin", "Alibeyköy", "Çırçır", "Defterdar", "Düğmeciler", "Emniyettepe", "Esentepe", "Merkez", "Göktürk", "Güzeltepe", "İslambey", "Karadolap", "Mimarsinan", "Mithatpaşa", "Nişanca", "Rami Cuma", "Rami Yeni", "Sakarya", "Silahtarağa", "Topçular", "Yeşilpınar"]
              ),
             District(
                 name: "Fatih",
                 neighbourhood: ["Aksaray", "Akşemsettin", "Alemdar", "Ali Kuşçu", "Atikali", "Ayvansaray", "Balabanağa", "Balat", "Beyazıt", "Binbirdirek", "Cankurtaran", "Cerrahpaşa", "Cibali", "Demirtaş", "Derviş Ali", "Eminsinan", "Hacıkadın", "Hasekisultan", "Hırkaişerif", "Hobyar", "Hoca Giyasettin", "Hocapaşa", "İskenderpaşa", "Kalenderhane", "Karagümrük", "Katip Kasım", "Kemalpaşa", "Kocamustafapaşa", "Küçükayasofya", "Mercan", "Mesihpaşa", "Mevlanakapı", "Mimar Hayrettin", "Mimar Kemalettin", "Mollafenari", "Mollagürani", "Mollahüsrev", "Muhsinehatun", "Nişanca", "Rüstempaşa", "Saraçishak", "Sarıdemir", "Seyyid Ömer", "Silivrikapı", "Sultanahmet", "Sururi", "Süleymaniye", "Sümbülefendi", "Şehremini", "Şehsuvarbey", "Tahtakale", "Tayahatun", "Topkapı", "Yavuzsinan", "Yavuz Sultan Selim", "Yedikule", "Zeyrek"]
             ),
             District(
                 name: "Gaziosmanpaşa",
                 neighbourhood: ["Bağlarbaşı", "Barbaros Hayrettin Paşa", "Fevzi Çakmak", "Hürriyet", "Karadeniz", "Karayolları", "Karlıtepe", "Kâzım Karabekir", "Merkez", "Mevlana", "Pazariçi", "Sarıgöl", "Şemsipaşa", "Yenidoğan", "Yenimahalle", "Yıldıztabya"]
             ),
              District(
                  name: "Güngören",
                  neighbourhood: ["Akıncılar", "Abdurrahman Nafiz Gürman", "Gençosman", "Güneştepe", "Güven", "Haznedar", "Mareşal Fevzi Çakmak", "Mehmet Nezih Özmen", "Merkez", "Sanayi", "Tozkoparan"]
              ),
             District(
                 name: "Kadıköy",
                 neighbourhood: ["19 Mayıs", "Acıbadem", "Bostancı", "Caddebostan", "Caferağa", "Dumlupınar", "Eğitim", "Erenköy", "Fenerbahçe", "Feneryolu", "Fikirtepe", "Göztepe", "Hasanpaşa", "Koşuyolu", "Kozyatağı", "Merdivenköy", "Osmanağa", "Rasimpaşa", "Sahrayıcedid", "Suadiye", "Zühtüpaşa"]
             ),
             District(
                 name: "Kâğıthane",
                 neighbourhood: ["Çağlayan", "Çeliktepe", "Gültepe", "Emniyet", "Gürsel", "Hamidiye", "Harmantepe", "Hürriyet", "Mehmet Akif Ersoy", "Merkez", "Nurtepe", "Ortabayır", "Sultan Selim", "Seyrantepe", "Şirintepe", "Talatpaşa", "Telsizler", "Yahya Kemal", "Yeşilce"]
             ),
              District(
                  name: "Kartal",
                  neighbourhood: ["Atalar", "Cevizli", "Cumhuriyet", "Çavuşoğlu", "Esentepe", "Gümüşpınar", "Hürriyet", "Karlıktepe", "Kordonboyu", "Orhantepe", "Ortamahalle", "Petrol-İş", "Soğanlık", "Topselvi", "Uğur Mumcu", "Yakacık Çarşı", "Yakacık Yeni", "Yalı", "Yukarımahalle", "Yunus"]
              ),
            District(
                name: "Küçükçekmece",
                neighbourhood: ["Atakent", "Atatürk", "Beşyol", "Cennet", "Cumhuriyet", "Fatih", "Fevzi Çakmak", "Gültepe", "Halkalı", "İnönü", "İstasyon", "Kanarya", "Kartaltepe", "Kemalpaşa", "Mehmet Akif", "Söğütlüçeşme", "Sultanmurat", "Tevfikbey", "Yarımburgaz", "Yenimahalle", "Yeşilova"]
            ),
            District(
                name: "Maltepe",
                neighbourhood: ["Altayçeşme", "Altıntepe", "Aydınevler", "Bağlarbaşı", "Başıbüyük", "Büyükbakkalköy", "Cevizli", "Çınar", "Esenkent", "Feyzullah", "Fındıklı", "Girne", "Gülensu", "Gülsuyu", "İdealtepe", "Küçükyalı", "Yalı", "Zümrütevler"]
            ),
             District(
                 name: "Pendik",
                 neighbourhood: ["Ahmet Yesevi", "Bahçelievler", "Batı", "Çamçeşme", "Çamlık", "Çınardere", "Doğu", "Dumlupınar", "Ertuğrulgazi", "Esenler", "Esenyalı", "Fatih", "Fevzi Çakmak", "Güllübağlar", "Güzelyalı", "Harmandere", "Kavakpınar", "Kaynarca", "Kurtköy", "Orhangazi", "Orta", "Ramazanoğlu", "Sanayi", "Sapanbağları", "Sülüntepe", "Şeyhli", "Velibaba", "Yayalar", "Yenimahalle", "Yenişehir", "Yeşilbağlar"]
             ),
            District(
                name: "Sancaktepe",
                neighbourhood: ["Abdurrahmangazi", "Akpınar", "Atatürk", "Emek", "Eyüp Sultan", "Fatih", "Hilal", "İnönü", "Kemal Türkler", "Meclis", "Merve", "Mevlana", "Osmangazi", "Safa", "Sarıgazi", "Veysel Karani", "Yenidoğan", "Yunus Emre"]
            ),
            District(
                name: "Sarıyer",
                neighbourhood: ["Ayazağa", "Baltalimanı", "Bahçeköy Kemer", "Bahçeköy", "Bahçeköy Yenimahalle", "Büyükdere", "Cumhuriyet", "Çayırbaşı", "Darüşşafaka", "Derbent (Çamlıtepe)", "Emirgân", "Fatih Sultan Mehmet", "Ferahevler", "İstinye", "Kâzım Karabekir", "Kireçburnu", "Kocataş", "Maden", "Pınar", "Poligon", "PTT Evleri", "Reşitpaşa", "Rumelihisarı", "Rumelikavağı", "Maslak", "Merkez", "Tarabya", "Yeniköy", "Yenimahalle"]
            ),
             District(
                 name: "Silivri",
                 neighbourhood: ["Alibey", "Alipaşa", "Büyük Çavuşlu", "Cumhuriyet", "Çanta Fatih", "Çanta Mimarsinan", "Değirmenköy İsmetpaşa", "Değirmenköy Fevzipaşa", "Fatih", "Gazitepe (Haraççı)", "Gümüşyaka", "Kadıköy", "Kavaklı Hürriyet", "Kavaklı Cumhuriyet", "Küçük Kılıçlı", "Mimar Sinan", "Ortaköy", "Piri Mehmet Paşa", "Selimpaşa", "Semizkumlar", "Yenimahalle", "Yolçatı"]
             ),
            District(
                name: "Sultanbeyli",
                neighbourhood: ["Abdurrahmangazi", "Adil", "Ahmet Yesevi", "Akşemsettin", "Battalgazi", "Fatih", "Hamidiye", "Hasanpaşa", "Mecidiye", "Mehmet Akif", "Mimarsinan", "Necip Fazıl", "Orhangazi", "Turgutreis", "Yavuz Selim"]
            ),
            District(
                name: "Sultangazi",
                neighbourhood: ["50. Yıl", "75. Yıl", "Cebeci", "Cumhuriyet", "Esentepe", "Eski Habibler", "Gazi", "Habibler", "İsmetpaşa", "Malkoçoğlu", "Sultançiftliği", "Uğur Mumcu", "Yayla", "Yunusemre", "Zübeydehanım"]
            ),
             District(
                 name: "Şile",
                 neighbourhood: ["Ağva", "Balibey", "Çavuş", "Hacıkasım", "Kumbaba"]
             ),
            District(
                name: "Şişli",
                neighbourhood: ["19 Mayıs", "Bozkurt", "Cumhuriyet", "Duatepe", "Ergenekon", "Esentepe", "Eskişehir", "Feriköy", "Fulya", "Gülbahar", "Halaskargazi", "Halide Edip Adıvar", "Halil Rıfat Paşa", "Harbiye", "İnönü", "İzzetpaşa", "Kaptanpaşa", "Kuştepe", "Mahmut Şevket Paşa", "Mecidiyeköy", "Merkez", "Meşrutiyet", "Paşa", "Teşvikiye", "Yayla"]
            ),
            District(
                name: "Tuzla",
                neighbourhood: ["Akfırat", "Anadolu", "Aydınlı", "Aydıntepe", "Cami", "Evliya Çelebi", "Fatih", "İçmeler", "İstasyon", "Mescit", "Mimar Sinan", "Orhanlı", "Orta", "Postane", "Şifa", "Tepeören", "Yayla"]
            ),
             District(
                 name: "Ümraniye",
                 neighbourhood: ["Adem Yavuz", "Altınşehir", "Armağanevler", "Aşağıdudullu", "Atakent", "Atatürk", "Cemil Meriç", "Çakmak", "Çamlık", "Dumlupınar", "Elmalıkent", "Esenevler", "Esenşehir", "Fatih Sultan Mehmet", "Hekimbaşı", "Huzur", "Ihlamurkuyu", "İnkılap", "İstiklal", "Kâzım Karabekir", "Mehmet Akif", "Madenler", "Namık Kemal", "Necip Fazıl", "Parseller", "Saray", "Site", "Şerifali", "Tantavi", "Tatlısu", "Tepeüstü", "Topağacı", "Yamanevler", "Yeni Sanayi", "Yukarıdudullu"]
             ),
            District(
                name: "Üsküdar",
                neighbourhood: ["Acıbadem", "Ahmediye", "Altunizade", "Aziz Mahmud Hüdayi", "Bahçelievler", "Barbaros", "Beylerbeyi", "Bulgurlu", "Burhaniye", "Cumhuriyet", "Çengelköy", "Ferah", "Güzeltepe", "İcadiye", "Kandilli", "Kirazlıtepe", "Kısıklı", "Kuleli", "Kuzguncuk", "Küçük Çamlıca", "Küçüksu", "Küplüce", "Mehmet Akif Ersoy", "Mimar Sinan", "Murat Reis", "Salacak", "Selami Ali", "Selimiye", "Sultantepe", "Ünalan", "Valide-i Atik", "Yavuztürk", "Zeynep Kamil"]
            ),
            District(
                name: "Zeytinburnu",
                neighbourhood: ["Beştelsiz", "Çırpıcı", "Gökalp", "Kazlıçeşme", "Maltepe", "Merkezefendi", "Nuripaşa", "Seyitnizam", "Sümer", "Telsiz", "Veliefendi", "Yenidoğan", "Yeşiltepe"]
            ),
        ]
        majorrArray=["International Relations", "Economics", "Business Administration", "Chemical and Biological Engineering", "Computer Engineering", "Electrical and Electronics Engineering", "Industrial Engineering", "Mechanical Engineering", "Chemistry", "Physics", "Mathematics", "Molecular Biology and Genetics", "Archaeology and History of Art", "Comparative Literature", "History", "Psychology", "Philosophy", "Sociology", "Media and Visual Arts", "Law", "Medicine", "Nursing"]
    }
    func getListOfDistricts() -> [District]? {
        return districtArray
    }
    func getDistrict(with name: String) -> District? {
        return districtArray.first { $0.name == name }
    }
    func getNumberDistricts() -> Int {
        return districtArray.count
    }
    
    func getDistrict(for index: Int) -> District? {
        guard index < districtArray.count else {
            return nil
        }
        
        return districtArray[index]
    } 
    func getListOfNeighbourhoods(with name: String) -> [String]? {
        return districtArray.first { $0.name == name }?.neighbourhood
    }
    func getNumberOfNeighbourhood(with name: String) -> Int{
        return districtArray.first { $0.name == name }?.neighbourhood.count ?? 0
    }
    func getNeighbourhood(with name: String , for index: Int) -> String? {
        let neighbourhoodArray = getListOfNeighbourhoods(with: name)
        guard index < neighbourhoodArray?.count ?? 0 else {
            return nil
        }
        
        return neighbourhoodArray?[index]
    }
}
