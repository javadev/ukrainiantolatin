/**
 * $Id$
 *
 * Copyright (c) 2013 Valentyn Kolesnikov
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
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
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

    private static Dictionary<string, string> convert = new Dictionary<string, string>() {
        {"AA", "Аа"},
        {"BB", "Бб"},
        {"VV", "Вв"},
        {"HH", "Гг"},
        {"GG", "Ґґ"},
        {"DD", "Дд"},
        {"EE", "Ее"},
        {"YeIe", "Єє"},
        {"ZhZh", "Жж"},
        {"ZZ", "Зз"},
        {"YY", "Ии"},
        {"II", "Іі"},
        {"YiI", "Її"},
        {"YI", "Йй"},
        {"KK", "Кк"},
        {"LL", "Лл"},
        {"MM", "Мм"},
        {"NN", "Нн"},
        {"OO", "Оо"},
        {"PP", "Пп"},
        {"RR", "Рр"},
        {"SS", "Сс"},
        {"TT", "Тт"},
        {"UU", "Уу"},
        {"FF", "Фф"},
        {"KhKh", "Хх"},
        {"TsTs", "Цц"},
        {"ChCh", "Чч"},
        {"ShSh", "Шш"},
        {"ShchShch", "Щщ"},
        {"YuIu", "Юю"},
        {"YaIa", "Яя"}
    };

    class ConvertCase {
        private string convert;
        private bool lowcase;
        public ConvertCase(string convert, bool lowcase) {
            this.convert = convert;
            this.lowcase = lowcase;
        }
        public string getConvert() {
            return convert;
        }
        public bool isLowcase() {
            return lowcase;
        }
    }

    private static Dictionary<string, ConvertCase> cyrToLat;

    static UkrainianToLatin() {
        cyrToLat = new Dictionary<string, ConvertCase>();
        foreach(KeyValuePair<string, string> item in convert) {
            cyrToLat[item.Value.Substring(INDEX_0, LENGTH_1)] = new ConvertCase(item.Key, false);
            cyrToLat[item.Value.Substring(INDEX_1, LENGTH_1)] = new ConvertCase(item.Key, true);
            if (item.Key == "EE") {
                cyrToLat["Ё"] = new ConvertCase(item.Key, false);
                cyrToLat["ё"] = new ConvertCase(item.Key, true);
            }
        }
    }

    public static string generateLat(string name) {
        StringBuilder result = new StringBuilder();
        ConvertCase prevConvertCase = null;
        for (int index = 0; index < name.Length; index += 1) {
            string curChar = name.Substring(index, LENGTH_1);
            string nextChar = index == name.Length - 1 ? null : name.Substring(index + INDEX_1, LENGTH_1);
            if (new Regex("[-'’,]").IsMatch(curChar)) {
                continue;
            }
            if (!cyrToLat.ContainsKey(curChar)) {
                if (" " == curChar) {
                    prevConvertCase = null;
                    result.Append(' ');
                }
                continue;
            }
            ConvertCase convertCase = cyrToLat[curChar];
            if (prevConvertCase == null) {
                checkFirstChar(result, convertCase, nextChar != null && cyrToLat.ContainsKey(nextChar) ? cyrToLat[nextChar] : convertCase);
            } else {
                checkMiddleChar(result, convertCase, nextChar != null && cyrToLat.ContainsKey(nextChar) ? cyrToLat[nextChar] : convertCase);
            }
            prevConvertCase = convertCase;
        }
        return result.ToString();
    }

    /**
     * @param result
     * @param convertCase
     * @param nextConvertCase
     */
    private static void checkFirstChar(StringBuilder result, ConvertCase convertCase, ConvertCase nextConvertCase) {
        string latName = convertCase.getConvert();
        switch (latName.Length) {
        case LENGTH_2:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_0, LENGTH_1).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_0, LENGTH_1) : latName.Substring(INDEX_0, LENGTH_1).ToUpper());
            if (convertCase.getConvert() == "ZZ" && nextConvertCase.getConvert() == "HH") {
                result.Append(nextConvertCase.isLowcase() ? "g" : "G");
            }
            break;
        case LENGTH_3: case LENGTH_4:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_0, LENGTH_2).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_0, LENGTH_2) : latName.Substring(INDEX_0, LENGTH_2).ToUpper());
            break;
        case LENGTH_8:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_0, LENGTH_4).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_0, LENGTH_4) : latName.Substring(INDEX_0, LENGTH_4).ToUpper());
            break;
        }
    }

    /**
     * @param result
     * @param convertCase
     * @param nextConvertCase
     */
    private static void checkMiddleChar(StringBuilder result, ConvertCase convertCase, ConvertCase nextConvertCase) {
        string latName = convertCase.getConvert();
        switch (latName.Length) {
        case LENGTH_2:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_1, LENGTH_1).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_1, LENGTH_1) : latName.Substring(INDEX_1, LENGTH_1).ToUpper());
            if (convertCase.getConvert() == "ZZ" && nextConvertCase.getConvert() == "HH") {
                result.Append(nextConvertCase.isLowcase() ? "g" : "G");
            }
            break;
        case LENGTH_3:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_2, LENGTH_1).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_2, LENGTH_1) : latName.Substring(INDEX_2, LENGTH_1).ToUpper());
            break;
        case LENGTH_4:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_2, LENGTH_2).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_2, LENGTH_2) : latName.Substring(INDEX_2, LENGTH_2).ToUpper());
            break;
        case LENGTH_8:
            result.Append(convertCase.isLowcase() ? latName.Substring(INDEX_4, LENGTH_4).ToLower() : nextConvertCase
                    .isLowcase() ? latName.Substring(INDEX_4, LENGTH_4) : latName.Substring(INDEX_4, LENGTH_4).ToUpper());
            break;
        }
    }
}
