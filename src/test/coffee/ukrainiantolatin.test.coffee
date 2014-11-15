# ukrainiantolatin.test.coffee

conv = require '../../main/coffee/ukrainiantolatin.coffee'

equal = (expected, actual) ->
  throw new Error(expected + " != " + actual) if expected != actual
  
test_generateLat = ()->
    equal("", conv.UkrainianToLatin.generateLat(""));
    equal("abvhd", conv.UkrainianToLatin.generateLat("абвгд"));
    equal("abvhd kh", conv.UkrainianToLatin.generateLat("абвгд х"));
    equal("abvhd kh yulia", conv.UkrainianToLatin.generateLat("абвгд х юля"));
    equal("yizhak", conv.UkrainianToLatin.generateLat("їжак"));
    equal("yizhaksiryi", conv.UkrainianToLatin.generateLat("їжак-сірий"));
    equal("Rozghon", conv.UkrainianToLatin.generateLat("Розгон"));
    equal("Zghorany", conv.UkrainianToLatin.generateLat("Згорани"));
    equal("Zghorany", conv.UkrainianToLatin.generateLat("Згорани'"));
    equal("Zghorany", conv.UkrainianToLatin.generateLat("Згорани’"));

equalLat = (expected, actual) ->
    equal(actual, conv.UkrainianToLatin.generateLat(expected))

test_ukrainianToLatin = ()->
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

test_generateLat()
test_ukrainianToLatin()
console.log "Tests were run test_generateLat(), test_ukrainianToLatin()"
