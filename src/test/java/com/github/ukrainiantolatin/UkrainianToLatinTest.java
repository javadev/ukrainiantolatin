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

import org.junit.Test;
import static org.junit.Assert.assertEquals;

/**
 * UkrainianToLatin unit test.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
public class UkrainianToLatinTest {
    /**
     * Checks string converter.
     */
    @Test public void generateLat() {
        assertEquals("", UkrainianToLatin.generateLat(""));
        assertEquals("abvhd", UkrainianToLatin.generateLat("абвгд"));
        assertEquals("abvhd kh", UkrainianToLatin.generateLat("абвгд х"));
        assertEquals("abvhd kh yulia", UkrainianToLatin.generateLat("абвгд х юля"));
        assertEquals("yizhak", UkrainianToLatin.generateLat("їжак"));
        assertEquals("yizhak-siryi", UkrainianToLatin.generateLat("їжак-сірий"));
        assertEquals("Rozghon", UkrainianToLatin.generateLat("Розгон"));
        assertEquals("Zghorany", UkrainianToLatin.generateLat("Згорани"));
        assertEquals("Zghorany'", UkrainianToLatin.generateLat("Згорани'"));
        assertEquals("Zghorany'", UkrainianToLatin.generateLat("Згорани’"));
    }

}
