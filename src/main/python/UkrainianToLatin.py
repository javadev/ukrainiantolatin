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

import re
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
            print("append - " + text)
            self._buffer.append(text)
            return self
    
        def toString(self):
            print("toString - " + "".join(self._buffer))
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
        UkrainianToLatin.cyrToLat = {};
        for key, value in UkrainianToLatin.Convert.items():
            print ("key - " + key, ", value - " + value + ", " + value[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_1])
            UkrainianToLatin.cyrToLat[value[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_1]] = UkrainianToLatin.ConvertCase(key, False)
            UkrainianToLatin.cyrToLat[value[UkrainianToLatin.INDEX_1 : UkrainianToLatin.INDEX_2]] = UkrainianToLatin.ConvertCase(key, True)
            if key == "EE":
                UkrainianToLatin.cyrToLat["Ё"] = UkrainianToLatin.ConvertCase(key, False)
                UkrainianToLatin.cyrToLat["ё"] = UkrainianToLatin.ConvertCase(key, True)
            print ("key - " + key)

    @staticmethod
    def generateLat(name):
        UkrainianToLatin.__init__()
        result = UkrainianToLatin.StringBuilder()
        prevConvertCase = None
        for index, curChar in enumerate(name):
            if index == name.__len__():
              nextChar = None
            else:
              nextChar = name[index + UkrainianToLatin.INDEX_1 : index + UkrainianToLatin.INDEX_2]
            if re.search("[-'’,]", curChar):
                continue
            if UkrainianToLatin.cyrToLat.get(curChar, None) is None:
                if " " == curChar:
                    prevConvertCase = None
                    result.append(' ')
                continue
            convertCase = UkrainianToLatin.cyrToLat.get(curChar, None)
            if prevConvertCase is None:
                param = UkrainianToLatin.cyrToLat[nextChar]
                if UkrainianToLatin.cyrToLat.get(nextChar, None) is None:
                    param = convertCase
                UkrainianToLatin.checkFirstChar(result, convertCase, param)
            else:
                param = UkrainianToLatin.cyrToLat.get(nextChar, None)
                if UkrainianToLatin.cyrToLat.get(nextChar, None) is None:
                    param = convertCase
                UkrainianToLatin.checkMiddleChar(result, convertCase, param)
            prevConvertCase = convertCase
        return result.toString()

    @staticmethod
    def checkFirstChar(result, convertCase, nextConvertCase):
        latName = convertCase.getConvert()
        if latName.__len__() == UkrainianToLatin.LENGTH_2:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_1].lower()
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_1]
                else:
                    latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_1].upper()
            result.append(param)
            if convertCase.getConvert() == "ZZ" and nextConvertCase.getConvert() == "HH":
                if nextConvertCase.isLowcase():
                    param = "g"
                else:
                    param = "G"
                result.append(param)
        elif latName.__len__() == UkrainianToLatin.LENGTH_3 or latName.__len__() == UkrainianToLatin.LENGTH_4:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_2].lower()
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_2]
                else:
                    param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_2].upper()
            result.append(param)
        elif latName.__len__() == UkrainianToLatin.LENGTH_8:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_4].lower()
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_4]
                else:
                    param = latName[UkrainianToLatin.INDEX_0 : UkrainianToLatin.INDEX_4].upper()
            result.append(param)

    @staticmethod
    def checkMiddleChar(result, convertCase, nextConvertCase):
        latName = convertCase.getConvert()
        if latName.__len__() == UkrainianToLatin.LENGTH_2:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_1 : UkrainianToLatin.INDEX_2].lower()
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_1 : UkrainianToLatin.INDEX_2]
                else:
                    param = latName[UkrainianToLatin.INDEX_1 : UkrainianToLatin.INDEX_2].upper()
            result.append(param)
            if convertCase.getConvert() == "ZZ" and nextConvertCase.getConvert() == "HH":
                if nextConvertCase.isLowcase():
                    param = "g"
                else:
                    param = "G"
                result.append(param)
        elif latName.__len__() == UkrainianToLatin.LENGTH_3:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_2 : UkrainianToLatin.INDEX_3].lower()
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_2 : UkrainianToLatin.INDEX_3]
                else:
                    param = latName[UkrainianToLatin.INDEX_2 : UkrainianToLatin.INDEX_3].upper()
            result.append(param)
        elif latName.__len__() == UkrainianToLatin.LENGTH_4:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_2 : UkrainianToLatin.INDEX_4].lower()
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_2 : UkrainianToLatin.INDEX_4]
                else:
                    param = latName[UkrainianToLatin.INDEX_2 : UkrainianToLatin.INDEX_4].upper()
            result.append(param)
        elif latName.__len__() == UkrainianToLatin.LENGTH_8:
            if convertCase.isLowcase():
                param = latName[UkrainianToLatin.INDEX_4 : UkrainianToLatin.INDEX_8].down
            else:
                if nextConvertCase.isLowcase():
                    param = latName[UkrainianToLatin.INDEX_4 : UkrainianToLatin.INDEX_8]
                else:
                    param = latName[UkrainianToLatin.INDEX_4 : UkrainianToLatin.INDEX_8].upper()
            result.append(param)


print ("resilt" + UkrainianToLatin.generateLat("Валентин"))
