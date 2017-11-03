ukrainiantolatin
================

[![Maven Central](https://img.shields.io/maven-central/v/com.github.javadev/ukrainiantolatin.svg)](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22com.github.javadev%22%20AND%20a%3A%22ukrainiantolatin%22)
[![Build Status](https://secure.travis-ci.org/javadev/ukrainiantolatin.svg)](http://travis-ci.org/javadev/ukrainiantolatin)
[![Coverage Status](https://coveralls.io/repos/javadev/ukrainiantolatin/badge.svg)](https://coveralls.io/r/javadev/ukrainiantolatin)
[![Dependency Status](https://www.versioneye.com/user/projects/576ad67cfdabcd003d086d82/badge.svg?style=flat)](https://www.versioneye.com/user/projects/576ad67cfdabcd003d086d82)

Requirements
============

Java 1.6 and later.

## Installation

Include the following in your `pom.xml` for Maven:

```
<dependencies>
  <dependency>
    <groupId>com.github.javadev</groupId>
    <artifactId>ukrainiantolatin</artifactId>
    <version>1.2</version>
  </dependency>
  ...
</dependencies>
```

Gradle:

```groovy
compile 'com.github.javadev:ukrainiantolatin:1.2'
```

The tool to convert Ukrainian words to the Latin characters (supports NBU transliteration)

Таблиця транслітерації українського алфавіту латиницею

Український алфавіт  Латиниця Позиція у слові    Приклади написання(українською мовою)  Приклади написання(латиницею)<br/>
Аа    Aа     Алушта Андрій   Alushta Andrii<br/>
Бб    Bb      Борщагівка Борисенко Borshchahivkа Borysenko<br/>
Вв    Vv      Вінниця Володимир   Vinnytsia Volodymyr<br/>
Гг    Hh      Гадяч Богдан Згурський  Hadiach Bohdan Zghurskyi<br/>
Ґґ    Gg      Ґалаґан Ґорґани   Galagan Gorgany<br/>
Дд    Dd      Донецьк Дмитро Donetsk Dmytro<br/>
Ее    Eе     Рівне Олег Есмань    Rivne Oleh Esman<br/>
Єє    Ye ie   на початку слова в інших позиціях   Єнакієве Гаєвич Короп’є   Yenakiieve Haievych Koropie<br/>
Жж    Zh zh       Житомир Жанна Жежелів    Zhytomyr Zhanna Zhezheliv<br/>
Зз    Zz      Закарпаття Казимирчук   Zakarpattia Kazymyrchuk<br/>
Ии    Yy      Медвин Михайленко   Medvyn Mykhailenko<br/>
Іі    Ii      Іванків Іващенко Ivankiv Ivashchenko<br/>
Її    Yi i    на початку слова в інших позиціях   Їжакевич Кадиївка Мар’їне   Yizhakevych Kadyivka Marine<br/>
Йй    Y i на початку слова в інших позиціях   Йосипівка Стрий Олексій    Yosypivka Stryi Oleksii<br/>
Кк    Kk      Київ Коваленко Kyiv Kovalenko<br/>
Лл    Ll      Лебедин Леонід Lebedyn Leonid<br/>
Мм    Mm      Миколаїв Маринич Mykolaiv Marynych<br/>
Нн    Nn      Ніжин Наталія   Nizhyn Nataliіa<br/>
Оо    Oo      Одеса Онищенко Odesa Onyshchenko<br/>
Пп    Pp      Полтава Петро   Poltava Petro<br/>
Рр    Rr      Решетилівка Рибчинськй Reshetylivka Rybchynskyi<br/>
Сс    Ss      Суми Соломія Sumy Solomiia<br/>
Тт    Tt      Тернопіль Троць   Ternopil Trots<br/>
Уу    Uu      Ужгород Уляна   Uzhhorod Uliana<br/>
Фф    Ff      Фастів Філіпчук   Fastiv Filipchuk<br/>
Хх    Kh kh       Харків Христина   Kharkiv Khrystyna<br/>
Цц    Ts ts       Біла Церква Стеценко  Bila Tserkva Stetsenko<br/>
Чч    Ch ch       Чернівці Шевченко   Chernivtsi Shevchenko<br/>
Шш    Sh sh       Шостка Кишеньки   Shostka Kyshenky<br/>
Щщ    Shch shch       Щербухи Гоща Гаращенко  Shcherbukhy Hoshcha Harashchenko<br/>
Юю    Yu іu  на початку слова в інших позиціях   Юрій Корюківка Yurii Koriukivka<br/>
Яя    Ya ia   на початку слова в інших позиціях   Яготин Ярошенко Костянтин Знам’янка Феодосія   Yahotyn Yaroshenko Kostiantyn Znamianka Feodosiia

[![Screen short](https://raw.github.com/javadev/ukrainiantolatin/master/ukrtolatin.png)](http://javadev.github.com/ukrainiantolatin/)

[![Screen short](https://raw.github.com/javadev/ukrainiantolatin/master/ukrtolatin2.png)](http://javadev.github.com/ukrainiantolatin/)
