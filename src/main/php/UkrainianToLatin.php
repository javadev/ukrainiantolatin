<?php
/*
 * $Id$
 *
 * Copyright 2014 Valentyn Kolesnikov
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
class StringBuilder {
    var $_buffer = array();

    public function __construct() {
        $this->_buffer = array();
    }

    public function append($text) {
        array_push($this->_buffer, $text);
        return $this;
    }

    public function toString() {
        return join("", $this->_buffer);
    }
}

class ConvertCase {
    var $convert, $lowcase;
    public function __construct($convert, $lowcase) {
        $this->convert = $convert;
        $this->lowcase = $lowcase;
    }
}

class UkrainianToLatin {
    private function __construct() {
    }

    /**
    * Generates latinic from cyrilic.
    * @param name the name
    * @return the result
    */
    public static function generateLat($name) {
        self::initialize();
        $result = new StringBuilder();
        $prevConvertCase = null;
        for ($index = 0; $index < mb_strlen($name); $index += 1) {
            $curChar = mb_substr($name, $index, self::LENGTH_1);
            $nextChar = $index == mb_strlen($name) - 1 ? null : mb_substr($name, $index + self::INDEX_1, self::LENGTH_1);
            if (preg_match("[-'’,]", $curChar)) {
                continue;
            }
            if (!isset(self::$cyrToLat[$curChar])) {
                if (" " == $curChar) {
                    $prevConvertCase = null;
                    $result->append(' ');
                }
                continue;
            }
            $convertCase = self::$cyrToLat[$curChar];
            if ($prevConvertCase == null) {
                self::checkFirstChar($result, $convertCase, !isset(self::$cyrToLat[$nextChar]) ? $convertCase : self::$cyrToLat[$nextChar]);
            } else {
                self::checkMiddleChar($result, $convertCase, !isset(self::$cyrToLat[$nextChar]) ? $convertCase : self::$cyrToLat[$nextChar]);
            }
            $prevConvertCase = $convertCase;
        }
        return $result->toString();
    }

    private static function checkFirstChar($result, $convertCase, $nextConvertCase) {
        $latName = $convertCase->convert;
        switch (mb_strlen($latName)) {
            case self::LENGTH_2:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_0, self::LENGTH_1)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_0, self::LENGTH_1) : mb_strtoupper(mb_substr($latName, self::INDEX_0, self::LENGTH_1))));
                if ($convertCase->convert == "ZZ" && $nextConvertCase->convert == "HH") {
                    $result->append($nextConvertCase->lowcase ? "g" : "G");
                }
                break;
            case self::LENGTH_3:
            case self::LENGTH_4:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_0, self::LENGTH_2)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_0, self::LENGTH_2) : mb_strtoupper(mb_substr($latName, self::INDEX_0, self::LENGTH_2))));
                break;
            case self::LENGTH_8:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_0, self::LENGTH_4)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_0, self::LENGTH_4) : mb_strtoupper(mb_substr($latName, self::INDEX_0, self::LENGTH_4))));
                break;
            default:
                break;
        }
    }

    private static function checkMiddleChar($result, $convertCase, $nextConvertCase) {
        $latName = $convertCase->convert;
        switch (mb_strlen($latName)) {
            case self::LENGTH_2:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_1, self::LENGTH_1)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_1, self::INDEX_2) : mb_strtoupper(mb_substr($latName, self::INDEX_1, self::LENGTH_1))));
                if ($convertCase->convert == "ZZ" && $nextConvertCase->convert == "HH") {
                    $result->append($nextConvertCase->lowcase ? "g" : "G");
                }
                break;
            case self::LENGTH_3:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_2, self::LENGTH_1)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_2, self::LENGTH_1) : mb_strtoupper(mb_substr($latName, self::INDEX_2, self::LENGTH_1))));
                break;
            case self::LENGTH_4:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_2, self::LENGTH_2)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_2, self::LENGTH_1) : mb_strtoupper(mb_substr($latName, self::INDEX_2, self::LENGTH_2))));
                break;
            case self::LENGTH_8:
                $result->append($convertCase->lowcase ? mb_strtolower(mb_substr($latName, self::INDEX_4, self::LENGTH_4)) : ($nextConvertCase->lowcase ? mb_substr($latName, self::INDEX_4, self::LENGTH_4) : mb_strtoupper(mb_substr($latName, self::INDEX_4, self::LENGTH_4))));
                break;
            default:
                break;
        }
    }

    private static function initialize() {
        self::$cyrToLat = array();
        foreach (self::$Convert as $key => $value) {
            self::$cyrToLat[mb_substr($value, self::INDEX_0, self::LENGTH_1)] = new ConvertCase($key, false);
            self::$cyrToLat[mb_substr($value, self::INDEX_1, self::LENGTH_1)] = new ConvertCase($key, true);
            if ($key == "EE") {
                self::$cyrToLat["Ё"] = new ConvertCase($key, false);
                self::$cyrToLat["ё"] = new ConvertCase($key, true);
            }
        }
    }
    const INDEX_0 = 0;
    const INDEX_1 = 1;
    const INDEX_2 = 2;
    const INDEX_3 = 3;
    const INDEX_4 = 4;
    const INDEX_8 = 8;
    const LENGTH_1 = 1;
    const LENGTH_2 = 2;
    const LENGTH_3 = 3;
    const LENGTH_4 = 4;
    const LENGTH_8 = 8;
    private static $cyrToLat = array();

    private static $Convert = array(
        "AA" => "Аа",
        "BB" => "Бб",
        "VV" => "Вв",
        "HH" => "Гг",
        "GG" => "Ґґ",
        "DD" => "Дд",
        "EE" => "Ее",
        "YeIe" => "Єє",
        "ZhZh" => "Жж",
        "ZZ" => "Зз",
        "YY" => "Ии",
        "II" => "Іі",
        "YiI" => "Її",
        "YI" => "Йй",
        "KK" => "Кк",
        "LL" => "Лл",
        "MM" => "Мм",
        "NN" => "Нн",
        "OO" => "Оо",
        "PP" => "Пп",
        "RR" => "Рр",
        "SS" => "Сс",
        "TT" => "Тт",
        "UU" => "Уу",
        "FF" => "Фф",
        "KhKh" => "Хх",
        "TsTs" => "Цц",
        "ChCh" => "Чч",
        "ShSh" => "Шш",
        "ShchShch" => "Щщ",
        "YuIu" => "Юю",
        "YaIa" => "Яя"
    );
}
?>
