'''
 * $Id$
 *
 * Copyright 2014 Valentyn Kolesnikov
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
'''

import os, sys
import unittest
sys.path.append(os.path.abspath("../../main/python"))
from UkrainianToLatin import UkrainianToLatin

class UkrainianToLatinTest(unittest.TestCase):
    #/** generateLat. */
    def test_generateLat(self):
        self.assertEquals("", UkrainianToLatin.generateLat(u""));
        self.assertEquals("abvhd", UkrainianToLatin.generateLat(u"абвгд"));
        self.assertEquals("a", UkrainianToLatin.generateLat(u"а"));
        self.assertEquals("B", UkrainianToLatin.generateLat(u"Б"));
        self.assertEquals("abvhd kh", UkrainianToLatin.generateLat(u"абвгд х"));
        self.assertEquals("abVhd KH", UkrainianToLatin.generateLat(u"абВгд Х"));
        self.assertEquals("abVhKH", UkrainianToLatin.generateLat(u"абВгХ"));
        self.assertEquals("abKhhKH", UkrainianToLatin.generateLat(u"абХгХ"));
        self.assertEquals("abvhd kh yulia", UkrainianToLatin.generateLat(u"абвгд х юля"));
        self.assertEquals("yizhak", UkrainianToLatin.generateLat(u"їжак"));
        self.assertEquals("Yizhak", UkrainianToLatin.generateLat(u"Їжак"));
        self.assertEquals("YI", UkrainianToLatin.generateLat(u"Ї"));
        self.assertEquals("aI", UkrainianToLatin.generateLat(u"аЇ"));
        self.assertEquals("SHCH", UkrainianToLatin.generateLat(u"Щ"));
        self.assertEquals("aSHCH", UkrainianToLatin.generateLat(u"аЩ"));
        self.assertEquals("yiZhak", UkrainianToLatin.generateLat(u"їЖак"));
        self.assertEquals("aIzhak", UkrainianToLatin.generateLat(u"аЇжак"));
        self.assertEquals("yizhaksiryi", UkrainianToLatin.generateLat(u"їжак-сірий"));
        self.assertEquals("Rozghon", UkrainianToLatin.generateLat(u"Розгон"));
        self.assertEquals("Zghorany", UkrainianToLatin.generateLat(u"Згорани"));
        self.assertEquals("Zghorany", UkrainianToLatin.generateLat(u"Згорани'"));
        self.assertEquals("Zghorany", UkrainianToLatin.generateLat(u"Згорани’"));
        self.assertEquals("Zghorany\nkh", UkrainianToLatin.generateLat(u"Згорани’\nх"));
        self.assertEquals("aZghorany\nkh", UkrainianToLatin.generateLat(u"аЗгорани’\nх"));

    def equal(self, actual, expected):
        self.assertEquals(expected, UkrainianToLatin.generateLat(actual))

    #/** ukrainianToLatin. */
    def test_ukrainianToLatin(self):
#//Аа Aа
        self.equal(u"Алушта Андрій", "Alushta Andrii");
#//Бб Bb
        self.equal(u"Борщагівка Борисенко", "Borshchahivka Borysenko");
#//Вв Vv
        self.equal(u"Вінниця Володимир", "Vinnytsia Volodymyr");
#//Гг Hh
        self.equal(u"Гадяч Богдан Згурський", "Hadiach Bohdan Zghurskyi");
#//Ґґ Gg
        self.equal(u"Ґалаґан Ґорґани", "Galagan Gorgany");
#//Дд Dd
        self.equal(u"Донецьк Дмитро", "Donetsk Dmytro");
#//Ее Eе
        self.equal(u"Рівне Олег Есмань", "Rivne Oleh Esman");
#//Єє Ye ie на початку слова в інших позиціях
        self.equal(u"Єнакієве Гаєвич Короп’є", "Yenakiieve Haievych Koropie");
#//Жж Zh zh
        self.equal(u"Житомир Жанна Жежелів", "Zhytomyr Zhanna Zhezheliv");
#//Зз Zz
        self.equal(u"Закарпаття Казимирчук", "Zakarpattia Kazymyrchuk");
#//Ии Yy
        self.equal(u"Медвин Михайленко", "Medvyn Mykhailenko");
#//Іі Ii
        self.equal(u"Іванків Іващенко", "Ivankiv Ivashchenko");
#//Її Yi i на початку слова в інших позиціях
        self.equal(u"Їжакевич Кадиївка Мар’їне", "Yizhakevych Kadyivka Marine");
#//Йй Y i на початку слова в інших позиціях
        self.equal(u"Йосипівка Стрий Олексій", "Yosypivka Stryi Oleksii");
#//Кк Kk
        self.equal(u"Київ Коваленко", "Kyiv Kovalenko");
#//Лл Ll
        self.equal(u"Лебедин Леонід", "Lebedyn Leonid");
#//Мм Mm
        self.equal(u"Миколаїв Маринич", "Mykolaiv Marynych");
#//Нн Nn
        self.equal(u"Ніжин Наталія", "Nizhyn Nataliia");
#//Оо Oo
        self.equal(u"Одеса Онищенко", "Odesa Onyshchenko");
#//Пп Pp
        self.equal(u"Полтава Петро", "Poltava Petro");
#//Рр Rr
        self.equal(u"Решетилівка Рибчинський", "Reshetylivka Rybchynskyi");
#//Сс Ss
        self.equal(u"Суми Соломія", "Sumy Solomiia");
#//Тт Tt
        self.equal(u"Тернопіль Троць", "Ternopil Trots");
#//Уу Uu
        self.equal(u"Ужгород Уляна", "Uzhhorod Uliana");
#//Фф Ff
        self.equal(u"Фастів Філіпчук", "Fastiv Filipchuk");
#//Хх Kh kh
        self.equal(u"Харків Христина", "Kharkiv Khrystyna");
#//Цц Ts ts
        self.equal(u"Біла Церква Стеценко", "Bila Tserkva Stetsenko");
#//Чч Ch ch
        self.equal(u"Чернівці Шевченко", "Chernivtsi Shevchenko");
#//Шш Sh sh
        self.equal(u"Шостка Кишеньки", "Shostka Kyshenky");
#//Щщ Shch shch
        self.equal(u"Щербухи Гоща Гаращенко", "Shcherbukhy Hoshcha Harashchenko");
#//Юю Yu іu на початку слова в інших позиціях
        self.equal(u"Юрій Корюківка", "Yurii Koriukivka");
#//Яя Ya ia на початку слова в інших позиціях
        self.equal(u"Яготин Ярошенко Костянтин Знам’янка Феодосія", "Yahotyn Yaroshenko Kostiantyn Znamianka Feodosiia");

def main():
    unittest.main()

if __name__ == '__main__':
    main()
