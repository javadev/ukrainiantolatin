/*
 * $Id$
 *
 * Copyright 2015 Valentyn Kolesnikov
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
import collection.immutable.ListMap
import scala.collection.mutable.HashMap
import scala.util.control.Breaks._

/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
object UkrainianToLatin {
    val INDEX_0 = 0
    val INDEX_1 = 1
    val INDEX_2 = 2
    val INDEX_3 = 3
    val INDEX_4 = 4
    val INDEX_8 = 8
    val LENGTH_2 = 2
    val LENGTH_3 = 3
    val LENGTH_4 = 4
    val LENGTH_8 = 8

    val converts = ListMap(
        "AA" -> "Аа",
        "BB" -> "Бб",
        "VV" -> "Вв",
        "HH" -> "Гг",
        "GG" -> "Ґґ",
        "DD" -> "Дд",
        "EE" -> "Ее",
        "YeIe" -> "Єє",
        "ZhZh" -> "Жж",
        "ZZ" -> "Зз",
        "YY" -> "Ии",
        "II" -> "Іі",
        "YiI" -> "Її",
        "YI" -> "Йй",
        "KK" -> "Кк",
        "LL" -> "Лл",
        "MM" -> "Мм",
        "NN" -> "Нн",
        "OO" -> "Оо",
        "PP" -> "Пп",
        "RR" -> "Рр",
        "SS" -> "Сс",
        "TT" -> "Тт",
        "UU" -> "Уу",
        "FF" -> "Фф",
        "KhKh" -> "Хх",
        "TsTs" -> "Цц",
        "ChCh" -> "Чч",
        "ShSh" -> "Шш",
        "ShchShch" -> "Щщ",
        "YuIu" -> "Юю",
        "YaIa" -> "Яя")

    var cyrToLat : HashMap[String, ConvertCase] = null

    class ConvertCase(convert: String, lowcase: Boolean) {
        def getConvert() : String = {
            return convert
        }
        def isLowcase() : Boolean = {
            return lowcase
        }
    }

    cyrToLat = new HashMap[String, ConvertCase]()

    converts.foreach {case(key, value) =>
        cyrToLat(value.substring(INDEX_0, INDEX_1)) = new ConvertCase(key, false)
        cyrToLat(value.substring(INDEX_1, INDEX_2)) = new ConvertCase(key, true)
        if (key == "EE") {
            cyrToLat("Ё") = new ConvertCase(key, false)
            cyrToLat("ё") = new ConvertCase(key, true)
        }
    }

    /**
     * Generates latinic from cyrilic.
     * @param name the name
     * @return the result
     */
    def generateLat(name : String) : String = {
        if (name == null) {
            throw new IllegalArgumentException("name is null");
        }
        val result : StringBuilder = new StringBuilder()
        var prevConvertCase : ConvertCase = null
        for (index <- 0 until name.length()) {
            val curChar : String = name.substring(index, index + INDEX_1)
            val nextChar : String = if (index == name.length() - 1) null else name.substring(index + INDEX_1, index + INDEX_2)
            breakable {
                if (curChar.matches("[-'’,]")) {
                    break
                }
                if (cyrToLat.get(curChar).getOrElse(null) == null) {
                    if (" ".equals(curChar)) {
                        prevConvertCase = null
                        result.append(' ')
                    } else if (curChar.matches("\\n")) {
                        result.append(curChar)
                    }
                    break
                }
                val convertCase : ConvertCase = cyrToLat.get(curChar).getOrElse(null)
                if (prevConvertCase == null) {
                    checkFirstChar(result, convertCase, if (cyrToLat.get(nextChar).getOrElse(null) == null) convertCase else cyrToLat
                            .get(nextChar).getOrElse(null))
                } else {
                    checkMiddleChar(result, convertCase, if (cyrToLat.get(nextChar).getOrElse(null) == null) convertCase else cyrToLat
                            .get(nextChar).getOrElse(null))
                }
                prevConvertCase = convertCase
            }
        }
        return result.toString()
    }

    /**
     * Converts first character in the word.
     * @param result resut buffer to store string in latin
     * @param convertCase current character object
     * @param nextConvertCase next character object
     */
    def checkFirstChar(result : StringBuilder, convertCase : ConvertCase, nextConvertCase : ConvertCase) = {
        val latName : String = convertCase.getConvert()
        latName.length() match {
        case LENGTH_2 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_0, INDEX_1).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_0, INDEX_1) else latName.substring(INDEX_0, INDEX_1)
                    .toUpperCase())
            if (convertCase.getConvert() == "ZZ" && nextConvertCase.getConvert() == "HH") {
                result.append(if (nextConvertCase.isLowcase()) "g" else "G")
            }
        case LENGTH_3 | LENGTH_4 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_0, INDEX_2).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_0, INDEX_2) else latName.substring(INDEX_0, INDEX_2)
                    .toUpperCase())
        case LENGTH_8 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_0, INDEX_4).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_0, INDEX_4) else latName.substring(INDEX_0, INDEX_4)
                    .toUpperCase())
        }
    }

    /**
     * Converts middle or last character in the word.
     * @param result resut buffer to store string in latin
     * @param convertCase current character object
     * @param nextConvertCase next character object
     */
    def checkMiddleChar(result : StringBuilder, convertCase : ConvertCase, nextConvertCase : ConvertCase) = {
        val latName : String = convertCase.getConvert()
        latName.length() match {
        case LENGTH_2 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_1, INDEX_2).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_1, INDEX_2) else latName.substring(INDEX_1, INDEX_2)
                    .toUpperCase())
            if (convertCase.getConvert() == "ZZ" && nextConvertCase.getConvert() == "HH") {
                result.append(if (nextConvertCase.isLowcase()) "g" else "G")
            }
        case LENGTH_3 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_2, INDEX_3).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_2, INDEX_3) else latName.substring(INDEX_2, INDEX_3)
                    .toUpperCase());
        case LENGTH_4 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_2, INDEX_4).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_2, INDEX_4) else latName.substring(INDEX_2, INDEX_4)
                    .toUpperCase());
        case LENGTH_8 =>
            result.append(if (convertCase.isLowcase()) latName.substring(INDEX_4, INDEX_8).toLowerCase() else if (nextConvertCase
                    .isLowcase()) latName.substring(INDEX_4, INDEX_8) else latName.substring(INDEX_4, INDEX_8)
                    .toUpperCase());
        }
    }

    def main(args: Array[String]) {
        val message = "The utility class to convert ukrainian words to the latin characters.\n\n" +
        "For docs, license, tests, and downloads, see: https://github.com/javadev/ukrainiantolatin"
        print(message)
    }
}
