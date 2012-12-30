=begin
/**
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
=end

=begin
/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
=end
class UkrainianToLatin
    class StringBuilder
        def initialize()
            @buffer = [];
        end

        def append(text)
            @buffer[@buffer.length] = text;
            return self;
        end

        def toString()
            return @buffer.join("");
        end
    end

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

    @@Convert = {
        AA: "Аа",
        BB: "Бб",
        VV: "Вв",
        HH: "Гг",
        GG: "Ґґ",
        DD: "Дд",
        EE: "Ее",
        YeIe: "Єє",
        ZhZh: "Жж",
        ZZ: "Зз",
        YY: "Ии",
        II: "Іі",
        YiI: "Її",
        YI: "Йй",
        KK: "Кк",
        LL: "Лл",
        MM: "Мм",
        NN: "Нн",
        OO: "Оо",
        PP: "Пп",
        RR: "Рр",
        SS: "Сс",
        TT: "Тт",
        UU: "Уу",
        FF: "Фф",
        KhKh: "Хх",
        TsTs: "Цц",
        ChCh: "Чч",
        ShSh: "Шш",
        ShchShch: "Щщ",
        YuIu: "Юю",
        YaIa: "Яя"
    }

    class ConvertCase
        def initialize(convert, lowcase)
            @convert = convert;
            @lowcase = lowcase;
        end
        def getConvert()
            return @convert;
        end
        def isLowcase()
            return @lowcase;
        end
    end

    def self.initialize
        @@cyrToLat = {};
        @@Convert.each_pair do |key, value|
            @@cyrToLat[value[INDEX_0, INDEX_1]] = ConvertCase.new(key, false)
            @@cyrToLat[value[INDEX_1, INDEX_2]] = ConvertCase.new(key, true)
            if key == :EE
                @@cyrToLat["Ё"] = ConvertCase.new(key, false)
                @@cyrToLat["ё"] = ConvertCase.new(key, true)
            end
        end
    end

    def self.generateLat(name)
        self.initialize
        result = StringBuilder.new();
        prevConvertCase = nil;
        name.split("").each_with_index do |curChar, index|
            nextChar = index == name.length() - 1 ? nil : name[index + INDEX_1];
            if curChar =~ /[-'’,]/
                next
            end
            if @@cyrToLat[curChar] == nil
                if " " == curChar
                    prevConvertCase = nil;
                    result.append(' ');
                end
                next
            end
            convertCase = @@cyrToLat[curChar];
            if prevConvertCase == nil
                checkFirstChar(result, convertCase, @@cyrToLat[nextChar] == nil ? convertCase : @@cyrToLat[nextChar]);
            else
                checkMiddleChar(result, convertCase, @@cyrToLat[nextChar] == nil ? convertCase : @@cyrToLat[nextChar]);
            end
            prevConvertCase = convertCase;
        end
        return result.toString();
    end

=begin
    /**
     * @param result
     * @param convertCase
     * @param nextConvertCase
     */
=end
    def self.checkFirstChar(result, convertCase, nextConvertCase)
        latName = convertCase.getConvert();
        case latName.length()
        when LENGTH_2
            result.append(convertCase.isLowcase() ? latName[INDEX_0, INDEX_1].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_0, INDEX_1] : latName[INDEX_0, INDEX_1].upcase);
            if convertCase.getConvert() == :ZZ && nextConvertCase.getConvert() == :HH
                result.append(nextConvertCase.isLowcase() ? "g" : "G");
            end
        when LENGTH_3, LENGTH_4
            result.append(convertCase.isLowcase() ? latName[INDEX_0, INDEX_2].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_0, INDEX_2] : latName[INDEX_0, INDEX_2].upcase);
        when LENGTH_8
            result.append(convertCase.isLowcase() ? latName[INDEX_0, INDEX_4].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_0, INDEX_4] : latName[INDEX_0, INDEX_4].upcase);
        end
    end

=begin
    /**
     * @param result
     * @param convertCase
     * @param nextConvertCase
     */
=end
    def self.checkMiddleChar(result, convertCase, nextConvertCase)
        latName = convertCase.getConvert();
        case latName.length()
        when LENGTH_2
            result.append(convertCase.isLowcase() ? latName[INDEX_1, INDEX_2].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_1, INDEX_2] : latName[INDEX_1, INDEX_2].upcase);
            if convertCase.getConvert() == :ZZ && nextConvertCase.getConvert() == :HH
                result.append(nextConvertCase.isLowcase() ? "g" : "G");
            end
        when LENGTH_3
            result.append(convertCase.isLowcase() ? latName[INDEX_2, INDEX_3].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_2, INDEX_3] : latName[INDEX_2, INDEX_3].upcase);
        when LENGTH_4
            result.append(convertCase.isLowcase() ? latName[INDEX_2, INDEX_4].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_2, INDEX_4] : latName[INDEX_2, INDEX_4].upcase);
        when LENGTH_8
            result.append(convertCase.isLowcase() ? latName[INDEX_4, INDEX_8].downcase : nextConvertCase
                    .isLowcase() ? latName[INDEX_4, INDEX_8] : latName[INDEX_4, INDEX_8].upcase);
        end
    end
end
