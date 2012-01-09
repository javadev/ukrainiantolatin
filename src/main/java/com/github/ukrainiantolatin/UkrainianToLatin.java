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
package com.github.ukrainiantolatin;

import java.util.HashMap;
import java.util.Map;

/**
 * UkrainianToLatin utility class.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
public class UkrainianToLatin {

    private static final int INDEX_0 = 0;
    private static final int INDEX_1 = 1;
    private static final int INDEX_2 = 2;
    private static final int INDEX_3 = 3;
    private static final int INDEX_4 = 4;
    private static final int LENGTH_2 = 2;
    private static final int LENGTH_3 = 3;
    private static final int LENGTH_4 = 4;

    private enum Convert {
        Aa("Аа"),
        Bb("Бб"),
        Vv("Вв"),
        Hh("Гг"),
        Gg("Ґґ"),
        Dd("Дд"),
        Ee("Ее"),
        Yeie("Єє"),
        Zhzh("Жж"),
        Zz("Зз"),
        Yy("Ии"),
        Ii("Іі"),
        Yii("Її"),
        Yi("Йй"),
        Kk("Кк"),
        Ll("Лл"),
        Mm("Мм"),
        Nn("Нн"),
        Oo("Оо"),
        Pp("Пп"),
        Rr("Рр"),
        Ss("Сс"),
        Tt("Тт"),
        Uu("Уу"),
        Ff("Фф"),
        Khkh("Хх"),
        Tsts("Цц"),
        Chch("Чч"),
        Shsh("Шш"),
        Shchshch("Щщ"),
        Yuiu("Юю"),
        Yaia("Яя");
        private String cyrilic;
        private Convert(String cyrilic) {
            this.cyrilic = cyrilic;
        }
        /**
         * Gets cyrilic.
         * @return the cyrilic
         */
        public String getCyrilic() {
            return cyrilic;
        }

    }
    private static Map<String, Convert> cyrToLat;

    static {
        cyrToLat = new HashMap<String, Convert>();
        for (Convert convert : Convert.values()) {
            cyrToLat.put(convert.getCyrilic().substring(INDEX_0, INDEX_1), convert);
            cyrToLat.put(convert.getCyrilic().substring(INDEX_1, INDEX_2), convert);
        }
    }
    private UkrainianToLatin() {
        super();
    }

    /**
     * Generates latinic from cyrilic.
     * @param name the name
     * @return the result
     */
    public static String generateLat(String name) {
        StringBuffer result = new StringBuffer();
        String prevChar = "";
        for (int index = 0; index < name.length(); index += 1) {
            String s = name.substring(index, index + 1);
            if (s.matches("[-'’]")) {
                result.append("’".equals(s) ? "'" : s);
                continue;
            }
            if (cyrToLat.get(s) == null) {
                if (" ".equals(s)) {
                    prevChar = "";
                    result.append(' ');
                }
                continue;
            }
            String latName = cyrToLat.get(s).name().toLowerCase();
            if ("".equals(prevChar)) {
                checkFirstChar(result, latName);
            } else {
                checkMiddleChar(result, prevChar, s, latName);
            }
            prevChar = s;
        }
        return result.toString();
    }

    /**
     * @param result
     * @param latName
     */
    private static void checkFirstChar(StringBuffer result, String latName) {
        switch (latName.length()) {
        case LENGTH_2:
            result.append(latName.substring(INDEX_0, INDEX_1));
            break;
        case LENGTH_3:
        case LENGTH_4:
            result.append(latName.substring(INDEX_0, INDEX_2));
            break;
        default:
            break;
        }
    }

    /**
     * @param result
     * @param prevChar
     * @param s
     * @param latName
     */
    private static void checkMiddleChar(StringBuffer result, String prevChar, String s, String latName) {
        switch (latName.length()) {
        case LENGTH_2:
            if ("г".equals(s) && "з".equalsIgnoreCase(prevChar)) {
                result.append("gh");
            } else {
                result.append(latName.substring(INDEX_1, INDEX_2));
            }
            break;
        case LENGTH_3:
            result.append(latName.substring(INDEX_2, INDEX_3));
            break;
        case LENGTH_4:
            result.append(latName.substring(INDEX_2, INDEX_4));
            break;
        default:
            break;
        }
    }
}
