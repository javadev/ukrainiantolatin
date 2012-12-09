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

Class.Mutators.Static = function(items){
    this.extend(items);
};
/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
var StringBuilder = new Class({
    initialize: function() {
        this._buffer = new Array();
    },

    append: function(text) {
            this._buffer[this._buffer.length] = text;
            return this;
    },
        
    insert: function(index, text) { 
            this._buffer.splice(index, 0, text);
            return this;
    },

    toString: function() {
            return this._buffer.join("");
    }
});

var ConvertCase = new Class({
        initialize: function(convert, lowcase) {
            this.convert = convert;
            this.lowcase = lowcase;
        }
});

var UkrainianToLatin = new Class({
    Static: {
        INDEX_0: 0,
        INDEX_1: 1,
        INDEX_2: 2,
        INDEX_3: 3,
        INDEX_4: 4,
        INDEX_8: 8,
        LENGTH_2: 2,
        LENGTH_3: 3,
        LENGTH_4: 4,
        LENGTH_8: 8,

        Convert: {
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
        },
    /**
     * Generates latinic from cyrilic.
     * @param name the name
     * @return the result
     */
    generateLat: function(name) {
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
    },
    checkFirstChar: function(result, convertCase, nextConvertCase) {
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
    },
    /**
     * @param result
     * @param convertCase
     * @param prevChar
     */
    checkMiddleChar: function(result, convertCase, nextConvertCase) {
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
    },
    initialize: function() {
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
});

