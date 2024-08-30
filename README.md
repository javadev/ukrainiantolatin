ukrainiantolatin
================

[![Maven Central](https://img.shields.io/maven-central/v/com.github.javadev/ukrainiantolatin.svg)](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22com.github.javadev%22%20AND%20a%3A%22ukrainiantolatin%22)
[![Java CI](https://github.com/javadev/ukrainiantolatin/actions/workflows/maven.yml/badge.svg?branch=master)](https://github.com/javadev/ukrainiantolatin/actions/workflows/maven.yml)
[![CodeQL](https://github.com/javadev/ukrainiantolatin/actions/workflows/codeql.yml/badge.svg)](https://github.com/javadev/ukrainiantolatin/actions/workflows/codeql.yml)
[![Coverage Status](https://coveralls.io/repos/javadev/ukrainiantolatin/badge.svg)](https://coveralls.io/r/javadev/ukrainiantolatin)

Requirements
============

Java 1.8 and later.

## Installation

Include the following in your `pom.xml` for Maven:

```xml
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

| Український алфавіт | Латиниця | Позиція у слові | Приклади написання (українською мовою) | Приклади написання (латиницею) |
|----------------------|-----------|------------------|-----------------------------------------|-------------------------------|
| Аа                   | Aa        |                  | Алушта                                  | Alushta                       |
| Бб                   | Bb        |                  | Борщагівка                              | Borshchahivkа                 |
| Вв                   | Vv        |                  | Вінниця                                 | Vinnytsia                     |
| Гг                   | Hh        |                  | Гадяч                                   | Hadiach                       |
| Ґґ                   | Gg        |                  | Ґалаґан                                 | Galagan                       |
| Дд                   | Dd        |                  | Донецьк                                 | Donetsk                       |
| Ее                   | Ee        |                  | Рівне                                   | Rivne                         |
| Єє                   | Ye/ie     | на початку слова в інших позиціях | Єнакієве Гаєвич Короп’є             | Yenakiieve Haievych Koropie   |
| Жж                   | Zh/zh     |                  | Житомир Жанна Жежелів                  | Zhytomyr Zhanna Zhezheliv     |
| Зз                   | Zz        |                  | Закарпаття                              | Zakarpattia                   |
| Ии                   | Yy        |                  | Медвин Михайленко                       | Medvyn Mykhailenko            |
| Іі                   | Ii        |                  | Іванків Іващенко                        | Ivankiv Ivashchenko           |
| Її                   | Yi/i      | на початку слова в інших позиціях | Їжакевич Кадиївка Мар’їне           | Yizhakevych Kadyivka Marine   |
| Йй                   | Y/i       | на початку слова в інших позиціях | Йосипівка Стрий Олексій              | Yosypivka Stryi Oleksii       |
| Кк                   | Kk        |                  | Київ                                    | Kyiv                          |
| Лл                   | Ll        |                  | Лебедин Леонід                          | Lebedyn Leonid                |
| Мм                   | Mm        |                  | Миколаїв Маринич                        | Mykolaiv Marynych             |
| Нн                   | Nn        |                  | Ніжин Наталія                           | Nizhyn Nataliіa               |
| Оо                   | Oo        |                  | Одеса Онищенко                          | Odesa Onyshchenko            |
| Пп                   | Pp        |                  | Полтава Петро                           | Poltava Petro                 |
| Рр                   | Rr        |                  | Решетилівка Рибчинськй                 | Reshetylivka Rybchynskyi      |
| Сс                   | Ss        |                  | Суми Соломія                            | Sumy Solomiia                 |
| Тт                   | Tt        |                  | Тернопіль Троць                        | Ternopil Trots                |
| Уу                   | Uu        |                  | Ужгород Уляна                           | Uzhhorod Uliana               |
| Фф                   | Ff        |                  | Фастів Філіпчук                         | Fastiv Filipchuk              |
| Хх                   | Kh/kh     |                  | Харків Христина                         | Kharkiv Khrystyna             |
| Цц                   | Ts/ts     |                  | Біла Церква Стеценко                    | Bila Tserkva Stetsenko        |
| Чч                   | Ch/ch     |                  | Чернівці Шевченко                       | Chernivtsi Shevchenko         |
| Шш                   | Sh/sh     |                  | Шостка Кишеньки                         | Shostka Kyshenky              |
| Щщ                   | Shch/shch |                  | Щербухи Гоща Гаращенко                 | Shcherbukhy Hoshcha Harashchenko |
| Юю                   | Yu/iu     | на початку слова в інших позиціях | Юрій Корюківка                        | Yurii Koriukivka              |
| Яя                   | Ya/ia     | на початку слова в інших позиціях | Яготин Ярошенко Костянтин Знам’янка Феодосія | Yahotyn Yaroshenko Kostiantyn Znamianka Feodosiia |

[![Screen short](https://raw.github.com/javadev/ukrainiantolatin/master/ukrtolatin.png)](http://javadev.github.io/ukrainiantolatin/)

[![Screen short](https://raw.github.com/javadev/ukrainiantolatin/master/ukrtolatin2.png)](http://javadev.github.io/ukrainiantolatin/)
