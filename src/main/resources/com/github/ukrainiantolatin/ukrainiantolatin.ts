/*
 * $Id$
 *
 * Copyright (c) 2012 Valentyn Kolesnikov
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

/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
class StringBuilder{
    private _buffer;
    constructor() {
        this._buffer = [];
    }

    append(text) {
            this._buffer[this._buffer.length] = text;
            return this;
    }
        
    insert(index, text) { 
            this._buffer.splice(index, 0, text);
            return this;
    }

    toString() {
            return this._buffer.join("");
    }
}

class ConvertCase {
        private convert;
        private lowcase;
        constructor(convert, lowcase) {
            this.convert = convert;
            this.lowcase = lowcase;
        }
}

class UkrainianToLatin {
        static INDEX_0 = 0;
        static INDEX_1 = 1;
        static INDEX_2 = 2;
        static INDEX_3 = 3;
        static INDEX_4 = 4;
        static INDEX_8 = 8;
        static LENGTH_2 = 2;
        static LENGTH_3 = 3;
        static LENGTH_4 = 4;
        static LENGTH_8 = 8;
        static cyrToLat = {};

        static Convert = {
        AA:"Аа",
        BB:"Бб",
        VV:"Вв",
        HH:"Гг",
        GG:"Ґґ",
        DD:"Дд",
        EE:"Ее",
        YeIe:"Єє",
        ZhZh:"Жж",
        ZZ:"Зз",
        YY:"Ии",
        II:"Іі",
        YiI:"Її",
        YI:"Йй",
        KK:"Кк",
        LL:"Лл",
        MM:"Мм",
        NN:"Нн",
        OO:"Оо",
        PP:"Пп",
        RR:"Рр",
        SS:"Сс",
        TT:"Тт",
        UU:"Уу",
        FF:"Фф",
        KhKh:"Хх",
        TsTs:"Цц",
        ChCh:"Чч",
        ShSh:"Шш",
        ShchShch:"Щщ",
        YuIu:"Юю",
        YaIa:"Яя"
        }
    /**
     * Generates latinic from cyrilic.
     * @param name the name
     * @return the result
     */
    static generateLat(name) {
        this.initialize();
        var result = new StringBuilder();
        var prevConvertCase = null;
        for (var index = 0; index < name.length; index += 1) {
            var curChar = name.substring(index, index + UkrainianToLatin.INDEX_1);
            var nextChar = index == name.length - 1 ? null : name.substring(index + UkrainianToLatin.INDEX_1, index + UkrainianToLatin.INDEX_2);
            if (curChar.match("[-'’,]")) {
                continue;
            }
            if (this.cyrToLat[curChar] == null) {
                if (" " == curChar) {
                    prevConvertCase = null;
                    result.append(' ');
                }
                continue;
            }
            var convertCase = this.cyrToLat[curChar];
            if (prevConvertCase == null) {
                this.checkFirstChar(result, convertCase, this.cyrToLat[nextChar] == null ? convertCase : this.cyrToLat[nextChar]);
            } else {
                this.checkMiddleChar(result, convertCase, this.cyrToLat[nextChar] == null ? convertCase : this.cyrToLat[nextChar]);
            }
            prevConvertCase = convertCase;
        }
        return result.toString();
    }
    static checkFirstChar(result, convertCase, nextConvertCase) {
        var latName = convertCase.convert;
        switch (latName.length) {
        case UkrainianToLatin.LENGTH_2:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1) : latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1)
                    .toUpperCase());
            if (convertCase.convert == "ZZ" && nextConvertCase.convert == "HH") {
                result.append(nextConvertCase.lowcase ? "g" : "G");
            }
            break;
        case UkrainianToLatin.LENGTH_3:
        case UkrainianToLatin.LENGTH_4:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2) : latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2)
                    .toUpperCase());
            break;
        case UkrainianToLatin.LENGTH_8:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4) : latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4)
                    .toUpperCase());
            break;
        default:
            break;
        }
    }
    /**
     * @param result the output string
     * @param convertCase the current char
     * @param nextConvertCase the next char
     */
    static checkMiddleChar(result, convertCase, nextConvertCase) {
        var latName = convertCase.convert;
        switch (latName.length) {
        case UkrainianToLatin.LENGTH_2:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2) : latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2)
                    .toUpperCase());
            if (convertCase.convert == "ZZ" && nextConvertCase.convert == "HH") {
                result.append(nextConvertCase.lowcase ? "g" : "G");
            }
            break;
        case UkrainianToLatin.LENGTH_3:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3) : latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3)
                    .toUpperCase());
            break;
        case UkrainianToLatin.LENGTH_4:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4) : latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4)
                    .toUpperCase());
            break;
        case UkrainianToLatin.LENGTH_8:
            result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8).toLowerCase() : nextConvertCase
                    .lowcase ? latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8) : latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8)
                    .toUpperCase());
            break;
        default:
            break;
        }
    }
    static initialize() {
        this.cyrToLat = {};
        for (var convert in UkrainianToLatin.Convert) {
            this.cyrToLat[UkrainianToLatin.Convert[convert].substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1)] = new ConvertCase(convert, false);
            this.cyrToLat[UkrainianToLatin.Convert[convert].substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2)] = new ConvertCase(convert, true);
            if (convert == UkrainianToLatin.Convert.EE) {
                this.cyrToLat["Ё"] = new ConvertCase(convert, false);
                this.cyrToLat["ё"] = new ConvertCase(convert, true);
            }
        }
    }
}

