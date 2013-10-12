'''
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
'''

'''
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
'''
class UkrainianToLatin:
    class StringBuilder:
        _buffer = []
    
        def __init__(self):
            self._buffer = []
    
        def append(self, text):
            self._buffer.append(text)
            return self
    
        def toString(self):
            return "".join(self._buffer)

    INDEX_0 = 0
    INDEX_1 = 1
    INDEX_2 = 2
    INDEX_3 = 3
    INDEX_4 = 4
    INDEX_8 = 8
    LENGTH_2 = 2
    LENGTH_3 = 3
    LENGTH_4 = 4
    LENGTH_8 = 8

    Convert = {
        "AA": "Аа",
        "BB": "Бб",
        "VV": "Вв",
        "HH": "Гг",
        "GG": "Ґґ",
        "DD": "Дд",
        "EE": "Ее",
        "YeIe": "Єє",
        "ZhZh": "Жж",
        "ZZ": "Зз",
        "YY": "Ии",
        "II": "Іі",
        "YiI": "Її",
        "YI": "Йй",
        "KK": "Кк",
        "LL": "Лл",
        "MM": "Мм",
        "NN": "Нн",
        "OO": "Оо",
        "PP": "Пп",
        "RR": "Рр",
        "SS": "Сс",
        "TT": "Тт",
        "UU": "Уу",
        "FF": "Фф",
        "KhKh": "Хх",
        "TsTs": "Цц",
        "ChCh": "Чч",
        "ShSh": "Шш",
        "ShchShch": "Щщ",
        "YuIu": "Юю",
        "YaIa": "Яя"
    }

    class ConvertCase:
        def __init__(self, convert, lowcase):
            self.convert = convert
            self.lowcase = lowcase

        def getConvert(self):
            return self.convert

        def isLowcase(self):
            return self.lowcase

    @staticmethod
    def __init__():
        cyrToLat = {};
        Convert.each_pair do |key, value|
            cyrToLat[value[INDEX_0, INDEX_1]] = ConvertCase.new(key, false)
            cyrToLat[value[INDEX_1, INDEX_2]] = ConvertCase.new(key, true)
            if key == "EE":
                cyrToLat["Ё"] = ConvertCase.new(key, false)
                cyrToLat["ё"] = ConvertCase.new(key, true)

    @staticmethod
    def generateLat(name):
        self.initialize
        result = StringBuilder.new();
        prevConvertCase = nil;
        name.split("").each_with_index do |curChar, index|
            if index == name.length():
              nextChar = None
            else:
              nextChar = name[index + INDEX_1]
            if curChar =~ /[-'’,]/
                next
            end
            if cyrToLat[curChar] is None:
                if " " == curChar
                    prevConvertCase = nil;
                    result.append(' ');
                end
                next
            end
            convertCase = @@cyrToLat[curChar]
            if prevConvertCase == nil:
                param = cyrToLat[nextChar]
                if cyrToLat[nextChar] is None:
                    param = convertCase
                checkFirstChar(result, convertCase, param)
            else:
                param = cyrToLat[nextChar]
                if cyrToLat[nextChar] is None:
                    param = convertCase
                checkMiddleChar(result, convertCase, param)
            prevConvertCase = convertCase
        end
        return result.toString()
    end

     '''
     * @param result
     * @param convertCase
     * @param nextConvertCase
     '''
    @staticmethod
    def checkFirstChar(result, convertCase, nextConvertCase):
        latName = convertCase.getConvert()
        if latName.length() == LENGTH_2:
            if convertCase.isLowcase():
                param = latName[INDEX_0, INDEX_1].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_0, INDEX_1]
                else:
                    latName[INDEX_0, INDEX_1].upcase
            result.append(param)
            if convertCase.getConvert() == "ZZ" and nextConvertCase.getConvert() == "HH":
                if nextConvertCase.isLowcase():
                    param = "g"
                else:
                    param = "G"
                result.append(param)
        elif latName.length() == LENGTH_3 or latName.length() == LENGTH_4:
            if convertCase.isLowcase():
                param = latName[INDEX_0, INDEX_2].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_0, INDEX_2]:
                else:
                    param = latName[INDEX_0, INDEX_2].upcase
            result.append(param)
        elif latName.length() == LENGTH_8:
            if convertCase.isLowcase():
                param = latName[INDEX_0, INDEX_4].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_0, INDEX_4]:
                else:
                    param = latName[INDEX_0, INDEX_4].upcase
            result.append(param)

     '''
     * @param result
     * @param convertCase
     * @param nextConvertCase
     '''
    @staticmethod
    def checkMiddleChar(result, convertCase, nextConvertCase):
        latName = convertCase.getConvert()
        if latName.length() == LENGTH_2:
            if convertCase.isLowcase():
                param = latName[INDEX_1, INDEX_2].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_1, INDEX_2]:
                else:
                    param = latName[INDEX_1, INDEX_2].upcase
            result.append(param)
            if convertCase.getConvert() == "ZZ" and nextConvertCase.getConvert() == "HH":
                if nextConvertCase.isLowcase():
                    param = "g"
                else:
                    param = "G"
                result.append(param)
        elif latName.length() == LENGTH_3:
            if convertCase.isLowcase():
                param = latName[INDEX_2, INDEX_3].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_2, INDEX_3]:
                else:
                    param = latName[INDEX_2, INDEX_3].upcase
            result.append(param)
        elif latName.length() == LENGTH_4:
            if convertCase.isLowcase():
                param = latName[INDEX_2, INDEX_4].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_2, INDEX_4]:
                else:
                    param = latName[INDEX_2, INDEX_4].upcase
            result.append(param)
        elif latName.length() == LENGTH_8:
            if convertCase.isLowcase():
                param = latName[INDEX_4, INDEX_8].downcase
            else:
                if nextConvertCase.isLowcase():
                    param = latName[INDEX_4, INDEX_8]:
                else:
                    param = latName[INDEX_4, INDEX_8].upcase
            result.append(param)
