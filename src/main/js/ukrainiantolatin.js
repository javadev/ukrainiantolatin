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
        var result = new StringBuilder();
/*
        ConvertCase prevConvertCase = null;
        for (int index = 0; index < name.length(); index += 1) {
            String curChar = name.substring(index, index + INDEX_1);
            String nextChar = index == name.length() - 1 ? null : name.substring(index + INDEX_1, index + INDEX_2);
            if (curChar.matches("[-'вЂ™,]")) {
                result.append("вЂ™".equals(curChar) ? "'" : curChar);
                continue;
            }
            if (cyrToLat.get(curChar) == null) {
                if (" ".equals(curChar)) {
                    prevConvertCase = null;
                    result.append(' ');
                }
                continue;
            }
            ConvertCase convertCase = cyrToLat.get(curChar);
            if (prevConvertCase == null) {
                checkFirstChar(result, convertCase, cyrToLat.get(nextChar) == null ? convertCase : cyrToLat
                        .get(nextChar));
            } else {
                checkMiddleChar(result, convertCase, cyrToLat.get(nextChar) == null ? convertCase : cyrToLat
                        .get(nextChar));
            }
            prevConvertCase = convertCase;
        }
*/
        return result.toString();
    }
    }
});

