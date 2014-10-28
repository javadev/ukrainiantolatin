<?php
/*
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
 */
require('../../main/php/UkrainianToLatin.php');

class UkrainianToLatinTest {

    public function assert_equal($expected, $actual) {
        if ($expected != $actual) {
            throw new Exception("expected: (" . $expected . ") actual: (" . $actual . ")");
        }
    }

    public function generateLat() {
        $this->assert_equal("", UkrainianToLatin::generateLat(""));
        $this->assert_equal("abvhd", UkrainianToLatin::generateLat("абвгд"));
        $this->assert_equal("abvhd kh", UkrainianToLatin::generateLat("абвгд х"));
        $this->assert_equal("abvhd kh yulia", UkrainianToLatin::generateLat("абвгд х юля"));
        $this->assert_equal("yizhak", UkrainianToLatin::generateLat("їжак"));
        $this->assert_equal("yizhaksiryi", UkrainianToLatin::generateLat("їжак-сірий"));
        $this->assert_equal("Rozghon", UkrainianToLatin::generateLat("Розгон"));
        $this->assert_equal("Zghorany", UkrainianToLatin::generateLat("Згорани"));
        $this->assert_equal("Zghorany", UkrainianToLatin::generateLat("Згорани'"));
        $this->assert_equal("Zghorany", UkrainianToLatin::generateLat("Згорани’"));
    }

    private function equal($actual, $expected) {
        $this->assert_equal($expected, UkrainianToLatin::generateLat($actual));
    }

    public function ukrainianToLatin() {
//Аа Aа 
        $this->equal("Алушта Андрій", "Alushta Andrii");
//Бб Bb 
        $this->equal("Борщагівка Борисенко", "Borshchahivka Borysenko");
//Вв Vv 
        $this->equal("Вінниця Володимир", "Vinnytsia Volodymyr");
//Гг Hh 
        $this->equal("Гадяч Богдан Згурський", "Hadiach Bohdan Zghurskyi");
//Ґґ Gg 
        $this->equal("Ґалаґан Ґорґани", "Galagan Gorgany");
//Дд Dd 
        $this->equal("Донецьк Дмитро", "Donetsk Dmytro");
//Ее Eе 
        $this->equal("Рівне Олег Есмань", "Rivne Oleh Esman");
//Єє Ye ie на початку слова в інших позиціях 
        $this->equal("Єнакієве Гаєвич Короп’є", "Yenakiieve Haievych Koropie");
//Жж Zh zh 
        $this->equal("Житомир Жанна Жежелів", "Zhytomyr Zhanna Zhezheliv");
//Зз Zz 
        $this->equal("Закарпаття Казимирчук", "Zakarpattia Kazymyrchuk");
//Ии Yy 
        $this->equal("Медвин Михайленко", "Medvyn Mykhailenko");
//Іі Ii 
        $this->equal("Іванків Іващенко", "Ivankiv Ivashchenko");
//Її Yi i на початку слова в інших позиціях 
        $this->equal("Їжакевич Кадиївка Мар’їне", "Yizhakevych Kadyivka Marine");
//Йй Y i на початку слова в інших позиціях 
        $this->equal("Йосипівка Стрий Олексій", "Yosypivka Stryi Oleksii");
//Кк Kk 
        $this->equal("Київ Коваленко", "Kyiv Kovalenko");
//Лл Ll 
        $this->equal("Лебедин Леонід", "Lebedyn Leonid");
//Мм Mm 
        $this->equal("Миколаїв Маринич", "Mykolaiv Marynych");
//Нн Nn 
        $this->equal("Ніжин Наталія", "Nizhyn Nataliia");
//Оо Oo 
        $this->equal("Одеса Онищенко", "Odesa Onyshchenko");
//Пп Pp 
        $this->equal("Полтава Петро", "Poltava Petro");
//Рр Rr 
        $this->equal("Решетилівка Рибчинський", "Reshetylivka Rybchynskyi");
//Сс Ss 
        $this->equal("Суми Соломія", "Sumy Solomiia");
//Тт Tt 
        $this->equal("Тернопіль Троць", "Ternopil Trots");
//Уу Uu 
        $this->equal("Ужгород Уляна", "Uzhhorod Uliana");
//Фф Ff 
        $this->equal("Фастів Філіпчук", "Fastiv Filipchuk");
//Хх Kh kh 
        $this->equal("Харків Христина", "Kharkiv Khrystyna");
//Цц Ts ts 
        $this->equal("Біла Церква Стеценко", "Bila Tserkva Stetsenko");
//Чч Ch ch 
        $this->equal("Чернівці Шевченко", "Chernivtsi Shevchenko");
//Шш Sh sh 
        $this->equal("Шостка Кишеньки", "Shostka Kyshenky");
//Щщ Shch shch 
        $this->equal("Щербухи Гоща Гаращенко", "Shcherbukhy Hoshcha Harashchenko");
//Юю Yu іu на початку слова в інших позиціях 
        $this->equal("Юрій Корюківка", "Yurii Koriukivka");
//Яя Ya ia на початку слова в інших позиціях 
        $this->equal("Яготин Ярошенко Костянтин Знам’янка Феодосія", "Yahotyn Yaroshenko Kostiantyn Znamianka Feodosiia");
    }
}
    $test = new UkrainianToLatinTest();
    $test->generateLat();
    $test->ukrainianToLatin();
    echo("2 tests were run: generateLat(), ukrainianToLatin()");
?>