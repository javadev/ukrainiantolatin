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
using System;
 
/**
 * UkrainianToLatin unit test.
 *
 * @author Valentyn Kolesnikov
 * @version $Revision$ $Date$
 */
public class UkrainianToLatinTest {

    /** setUp. */
    private void setup() {
    }

    public void assert_equal(string expected, string actual) {
        if (expected != actual) {
            throw new ArgumentNullException("expected: (" + expected + ") actual: (" + actual + ")");
        }
    }

    /** checkUAH. */
    public void test_checkUAH() {
    }

    static void Main(string[] args) {
        UkrainianToLatinTest test = new UkrainianToLatinTest();
        test.setup();
        test.test_checkUAH();
        System.Console.WriteLine("1 test was run: test_checkUAH()");
    }
}
