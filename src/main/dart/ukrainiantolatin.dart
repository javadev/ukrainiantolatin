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
        return Strings.join(this._buffer, "");
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
    const int INDEX_0 = 0;
    const int INDEX_1 = 1;
    const int INDEX_2 = 2;
    const int INDEX_3 = 3;
    const int INDEX_4 = 4;
    const int INDEX_8 = 8;
    const int LENGTH_1 = 1;
    const int LENGTH_2 = 2;
    const int LENGTH_3 = 3;
    const int LENGTH_4 = 4;
    const int LENGTH_8 = 8;

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

    static Map<String, ConvertCase> _cyrToLat;

    static void initialize() {
        cyrToLat = new Map<String, ConvertCase>();
/*
        for (String item in convert) {
            cyrToLat[item.Value.Substring(INDEX_0, LENGTH_1)] = new ConvertCase(item.Key, false);
            cyrToLat[item.Value.Substring(INDEX_1, LENGTH_1)] = new ConvertCase(item.Key, true);
            if (item.Key == "EE") {
                cyrToLat["Ё"] = new ConvertCase(item.Key, false);
                cyrToLat["ё"] = new ConvertCase(item.Key, true);
            }
        }
*/
    }
}

main() {
}
