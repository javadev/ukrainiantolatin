/*
 * $Id$
 *
 * Copyright 2013-2020 Valentyn Kolesnikov
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
import '../../main/dart/ukrainiantolatin.dart';
/**
 * UkrainianToLatin unit test.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
class UkrainianToLatinTest {

    /** setUp. */
    void setup() {
    }

    void assert_equal(String expected, String actual) {
        if (expected != actual) {
            throw new ExpectException("expected: (".concat(expected).concat(") actual: (").concat(actual).concat(")"));
        }
    }

    void generateLat() {
        assert_equal("", UkrainianToLatin.generateLat(""));
        assert_equal("abvhd", UkrainianToLatin.generateLat("абвгд"));
        assert_equal("abvhd kh", UkrainianToLatin.generateLat("абвгд х"));
        assert_equal("abvhd kh yulia", UkrainianToLatin.generateLat("абвгд х юля"));
        assert_equal("yizhak", UkrainianToLatin.generateLat("їжак"));
        assert_equal("yizhaksiryi", UkrainianToLatin.generateLat("їжак-сірий"));
        assert_equal("Rozghon", UkrainianToLatin.generateLat("Розгон"));
        assert_equal("Zghorany", UkrainianToLatin.generateLat("Згорани"));
        assert_equal("Zghorany", UkrainianToLatin.generateLat("Згорани'"));
        assert_equal("Zghorany", UkrainianToLatin.generateLat("Згорани’"));
    }

    void equal(String actual, String expected) {
        assert_equal(expected, UkrainianToLatin.generateLat(actual));
    }

    void ukrainianToLatin() {
//Аа Aа 
        equal("Алушта Андрій", "Alushta Andrii");
//Бб Bb 
        equal("Борщагівка Борисенко", "Borshchahivka Borysenko");
//Вв Vv 
        equal("Вінниця Володимир", "Vinnytsia Volodymyr");
//Гг Hh 
        equal("Гадяч Богдан Згурський", "Hadiach Bohdan Zghurskyi");
//Ґґ Gg 
        equal("Ґалаґан Ґорґани", "Galagan Gorgany");
//Дд Dd 
        equal("Донецьк Дмитро", "Donetsk Dmytro");
//Ее Eе 
        equal("Рівне Олег Есмань", "Rivne Oleh Esman");
//Єє Ye ie на початку слова в інших позиціях 
        equal("Єнакієве Гаєвич Короп’є", "Yenakiieve Haievych Koropie");
//Жж Zh zh 
        equal("Житомир Жанна Жежелів", "Zhytomyr Zhanna Zhezheliv");
//Зз Zz 
        equal("Закарпаття Казимирчук", "Zakarpattia Kazymyrchuk");
//Ии Yy 
        equal("Медвин Михайленко", "Medvyn Mykhailenko");
//Іі Ii 
        equal("Іванків Іващенко", "Ivankiv Ivashchenko");
//Її Yi i на початку слова в інших позиціях 
        equal("Їжакевич Кадиївка Мар’їне", "Yizhakevych Kadyivka Marine");
//Йй Y i на початку слова в інших позиціях 
        equal("Йосипівка Стрий Олексій", "Yosypivka Stryi Oleksii");
//Кк Kk 
        equal("Київ Коваленко", "Kyiv Kovalenko");
//Лл Ll 
        equal("Лебедин Леонід", "Lebedyn Leonid");
//Мм Mm 
        equal("Миколаїв Маринич", "Mykolaiv Marynych");
//Нн Nn 
        equal("Ніжин Наталія", "Nizhyn Nataliia");
//Оо Oo 
        equal("Одеса Онищенко", "Odesa Onyshchenko");
//Пп Pp 
        equal("Полтава Петро", "Poltava Petro");
//Рр Rr 
        equal("Решетилівка Рибчинський", "Reshetylivka Rybchynskyi");
//Сс Ss 
        equal("Суми Соломія", "Sumy Solomiia");
//Тт Tt 
        equal("Тернопіль Троць", "Ternopil Trots");
//Уу Uu 
        equal("Ужгород Уляна", "Uzhhorod Uliana");
//Фф Ff 
        equal("Фастів Філіпчук", "Fastiv Filipchuk");
//Хх Kh kh 
        equal("Харків Христина", "Kharkiv Khrystyna");
//Цц Ts ts 
        equal("Біла Церква Стеценко", "Bila Tserkva Stetsenko");
//Чч Ch ch 
        equal("Чернівці Шевченко", "Chernivtsi Shevchenko");
//Шш Sh sh 
        equal("Шостка Кишеньки", "Shostka Kyshenky");
//Щщ Shch shch 
        equal("Щербухи Гоща Гаращенко", "Shcherbukhy Hoshcha Harashchenko");
//Юю Yu іu на початку слова в інших позиціях 
        equal("Юрій Корюківка", "Yurii Koriukivka");
//Яя Ya ia на початку слова в інших позиціях 
        equal("Яготин Ярошенко Костянтин Знам’янка Феодосія", "Yahotyn Yaroshenko Kostiantyn Znamianka Feodosiia");
    }
}

void main() {
    UkrainianToLatinTest test = new UkrainianToLatinTest();
    test.setup();
    test.generateLat();
    test.ukrainianToLatin();
    print("2 tests were run: generateLat(), ukrainianToLatin()");
}
