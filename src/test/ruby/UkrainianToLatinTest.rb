require "../../main/ruby/UkrainianToLatin"
require "test/unit"
 
class UkrainianToLatinTest < Test::Unit::TestCase
 
  def test_generateLat
    assert_equal("", UkrainianToLatin.generateLat(""))
    assert_equal("abvhd", UkrainianToLatin.generateLat("абвгд"))
    assert_equal("abvhd kh", UkrainianToLatin.generateLat("абвгд х"));
    assert_equal("abvhd kh yulia", UkrainianToLatin.generateLat("абвгд х юля"));
    assert_equal("yizhak", UkrainianToLatin.generateLat("їжак"));
    assert_equal("yizhaksiryi", UkrainianToLatin.generateLat("їжак-сірий"));
    assert_equal("Rozghon", UkrainianToLatin.generateLat("Розгон"));
    assert_equal("Zghorany", UkrainianToLatin.generateLat("Згорани"));
    assert_equal("Zghorany", UkrainianToLatin.generateLat("Згорани'"));
    assert_equal("Zghorany", UkrainianToLatin.generateLat("Згорани’"));
  end
 
  def equalLat(actual, expected)
        assert_equal(expected, UkrainianToLatin.generateLat(actual));
  end

  def test_ukrainianToLatin
#Аа Aа 
        equalLat("Алушта Андрій", "Alushta Andrii");
#Бб Bb 
        equalLat("Борщагівка Борисенко", "Borshchahivka Borysenko");
#Вв Vv 
        equalLat("Вінниця Володимир", "Vinnytsia Volodymyr");
#Гг Hh 
        equalLat("Гадяч Богдан Згурський", "Hadiach Bohdan Zghurskyi");
#Ґґ Gg 
        equalLat("Ґалаґан Ґорґани", "Galagan Gorgany");
#Дд Dd 
        equalLat("Донецьк Дмитро", "Donetsk Dmytro");
#Ее Eе 
        equalLat("Рівне Олег Есмань", "Rivne Oleh Esman");
#Єє Ye ie на початку слова в інших позиціях 
        equalLat("Єнакієве Гаєвич Короп’є", "Yenakiieve Haievych Koropie");
#Жж Zh zh 
        equalLat("Житомир Жанна Жежелів", "Zhytomyr Zhanna Zhezheliv");
#Зз Zz 
        equalLat("Закарпаття Казимирчук", "Zakarpattia Kazymyrchuk");
#Ии Yy 
        equalLat("Медвин Михайленко", "Medvyn Mykhailenko");
#Іі Ii 
        equalLat("Іванків Іващенко", "Ivankiv Ivashchenko");
#Її Yi i на початку слова в інших позиціях 
        equalLat("Їжакевич Кадиївка Мар’їне", "Yizhakevych Kadyivka Marine");
#Йй Y i на початку слова в інших позиціях 
        equalLat("Йосипівка Стрий Олексій", "Yosypivka Stryi Oleksii");
#Кк Kk 
        equalLat("Київ Коваленко", "Kyiv Kovalenko");
#Лл Ll 
        equalLat("Лебедин Леонід", "Lebedyn Leonid");
#Мм Mm 
        equalLat("Миколаїв Маринич", "Mykolaiv Marynych");
#Нн Nn 
        equalLat("Ніжин Наталія", "Nizhyn Nataliia");
#Оо Oo 
        equalLat("Одеса Онищенко", "Odesa Onyshchenko");
#Пп Pp 
        equalLat("Полтава Петро", "Poltava Petro");
#Рр Rr 
        equalLat("Решетилівка Рибчинський", "Reshetylivka Rybchynskyi");
#Сс Ss 
        equalLat("Суми Соломія", "Sumy Solomiia");
#Тт Tt 
        equalLat("Тернопіль Троць", "Ternopil Trots");
#Уу Uu 
        equalLat("Ужгород Уляна", "Uzhhorod Uliana");
#Фф Ff 
        equalLat("Фастів Філіпчук", "Fastiv Filipchuk");
#Хх Kh kh 
        equalLat("Харків Христина", "Kharkiv Khrystyna");
#Цц Ts ts 
        equalLat("Біла Церква Стеценко", "Bila Tserkva Stetsenko");
#Чч Ch ch 
        equalLat("Чернівці Шевченко", "Chernivtsi Shevchenko");
#Шш Sh sh 
        equalLat("Шостка Кишеньки", "Shostka Kyshenky");
#Щщ Shch shch 
        equalLat("Щербухи Гоща Гаращенко", "Shcherbukhy Hoshcha Harashchenko");
#Юю Yu іu на початку слова в інших позиціях 
        equalLat("Юрій Корюківка", "Yurii Koriukivka");
#Яя Ya ia на початку слова в інших позиціях 
        equalLat("Яготин Ярошенко Костянтин Знам’янка Феодосія", "Yahotyn Yaroshenko Kostiantyn Znamianka Feodosiia");
  end

end
