/*
 * $Id$
 *
 * Copyright 2013 Valentyn Kolesnikov
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

library ukrainiantolatin;

/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
class StringBuilder {
    List _buffer;

    StringBuilder() {
        this._buffer = new List();
    }

    StringBuilder append(text) {
        this._buffer.add(text);
        return this;
    }
        
    String toString() {
        return this._buffer.join("");
    }
}

class ConvertCase {
    String _convert;
    bool _lowcase;
    ConvertCase(String convert, bool lowcase) {
        this._convert = convert;
        this._lowcase = lowcase;
    }
    String getConvert() {
        return _convert;
    }
    bool isLowcase() {
        return _lowcase;
    }
}

class UkrainianToLatin {
    static const int INDEX_0 = 0;
    static const int INDEX_1 = 1;
    static const int INDEX_2 = 2;
    static const int INDEX_3 = 3;
    static const int INDEX_4 = 4;
    static const int INDEX_8 = 8;
    static const int LENGTH_1 = 1;
    static const int LENGTH_2 = 2;
    static const int LENGTH_3 = 3;
    static const int LENGTH_4 = 4;
    static const int LENGTH_8 = 8;

    static Map<String, String> convert = {
        "AA" : "Аа",
        "BB" : "Бб",
        "VV" : "Вв",
        "HH" : "Гг",
        "GG" : "Ґґ",
        "DD" : "Дд",
        "EE" : "Ее",
        "YeIe" : "Єє",
        "ZhZh" : "Жж",
        "ZZ" : "Зз",
        "YY" : "Ии",
        "II" : "Іі",
        "YiI" : "Її",
        "YI" : "Йй",
        "KK" : "Кк",
        "LL" : "Лл",
        "MM" : "Мм",
        "NN" : "Нн",
        "OO" : "Оо",
        "PP" : "Пп",
        "RR" : "Рр",
        "SS" : "Сс",
        "TT" : "Тт",
        "UU" : "Уу",
        "FF" : "Фф",
        "KhKh" : "Хх",
        "TsTs" : "Цц",
        "ChCh" : "Чч",
        "ShSh" : "Шш",
        "ShchShch" : "Щщ",
        "YuIu" : "Юю",
        "YaIa" : "Яя"
    };

    static Map<String, ConvertCase> cyrToLat;

    static void initialize() {
        cyrToLat = new Map<String, ConvertCase>();
        convert.forEach((String key, String value) {
            cyrToLat[value.substring(INDEX_0, INDEX_1)] = new ConvertCase(key, false);
            cyrToLat[value.substring(INDEX_1, INDEX_2)] = new ConvertCase(key, true);
            if (key == "EE") {
                cyrToLat["Ё"] = new ConvertCase(key, false);
                cyrToLat["ё"] = new ConvertCase(key, true);
            }
        });
    }

    static string generateLat(String name) {
        initialize();
        StringBuilder result = new StringBuilder();
        ConvertCase prevConvertCase = null;
        for (int index = 0; index < name.length; index += 1) {
            String curChar = name.substring(index, index + INDEX_1);
            String nextChar = index == name.length - 1 ? null : name.substring(index + INDEX_1, index + INDEX_2);
            if (new RegExp("[-'’,]").hasMatch(curChar)) {
                continue;
            }
            if (!cyrToLat.containsKey(curChar)) {
                if (" " == curChar) {
                    prevConvertCase = null;
                    result.append(' ');
                }
                continue;
            }
            ConvertCase convertCase = cyrToLat[curChar];
            if (prevConvertCase == null) {
                checkFirstChar(result, convertCase, nextChar != null && cyrToLat.containsKey(nextChar) ? cyrToLat[nextChar] : convertCase);
            } else {
                checkMiddleChar(result, convertCase, nextChar != null && cyrToLat.containsKey(nextChar) ? cyrToLat[nextChar] : convertCase);
            }
            prevConvertCase = convertCase;
        }
        return result.toString();
    }

    /**
     * @param result
     * @param convertCase
     * @param nextConvertCase
     */
    static void checkFirstChar(StringBuilder result, ConvertCase convertCase, ConvertCase nextConvertCase) {
        String latName = convertCase.getConvert();
        switch (latName.length) {
        case LENGTH_2:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_0, INDEX_1).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_0, INDEX_1) : latName.substring(INDEX_0, INDEX_1).toUpperCase());
            if (convertCase.getConvert() == "ZZ" && nextConvertCase.getConvert() == "HH") {
                result.append(nextConvertCase.isLowcase() ? "g" : "G");
            }
            break;
        case LENGTH_3: case LENGTH_4:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_0, INDEX_2).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_0, INDEX_2) : latName.substring(INDEX_0, INDEX_2).toUpperCase());
            break;
        case LENGTH_8:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_0, INDEX_4).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_0, INDEX_4) : latName.substring(INDEX_0, INDEX_4).toUpperCase());
            break;
        }
    }

    /**
     * @param result
     * @param convertCase
     * @param nextConvertCase
     */
    static void checkMiddleChar(StringBuilder result, ConvertCase convertCase, ConvertCase nextConvertCase) {
        String latName = convertCase.getConvert();
        switch (latName.length) {
        case LENGTH_2:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_1, INDEX_2).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_1, INDEX_2) : latName.substring(INDEX_1, INDEX_2).toUpperCase());
            if (convertCase.getConvert() == "ZZ" && nextConvertCase.getConvert() == "HH") {
                result.append(nextConvertCase.isLowcase() ? "g" : "G");
            }
            break;
        case LENGTH_3:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_2, INDEX_3).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_2, INDEX_3) : latName.substring(INDEX_2, INDEX_3).toUpperCase());
            break;
        case LENGTH_4:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_2, INDEX_4).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_2, INDEX_4) : latName.substring(INDEX_2, INDEX_4).toUpperCase());
            break;
        case LENGTH_8:
            result.append(convertCase.isLowcase() ? latName.substring(INDEX_4, INDEX_8).toLowerCase() : nextConvertCase
                    .isLowcase() ? latName.substring(INDEX_4, INDEX_8) : latName.substring(INDEX_4, INDEX_8).toUpperCase());
            break;
        }
    }
}
