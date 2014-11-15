#
#* $Id$
#*
#* Copyright (c) 2014 Valentyn Kolesnikov
#*
#* Licensed under the Apache License, Version 2.0 (the "License");
#* you may not use this file except in compliance with the License.
#* You may obtain a copy of the License at
#*
#*     http://www.apache.org/licenses/LICENSE-2.0
#*
#* Unless required by applicable law or agreed to in writing, software
#* distributed under the License is distributed on an "AS IS" BASIS,
#* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#* See the License for the specific language governing permissions and
#* limitations under the License.
#

###*
UkrainianToLatin utility class.

@author Valentyn Kolesnikov
@version $Revision$ $Date$
###
StringBuilder = (->
  StringBuilder = ->
    @_buffer = []
    return
  StringBuilder::append = (text) ->
    @_buffer[@_buffer.length] = text
    this

  StringBuilder::insert = (index, text) ->
    @_buffer.splice index, 0, text
    this

  StringBuilder::toString = ->
    @_buffer.join ""

  StringBuilder
)()
ConvertCase = (->
  ConvertCase = (convert, lowcase) ->
    @convert = convert
    @lowcase = lowcase
    return
  ConvertCase
)()
UkrainianToLatin = (->
  UkrainianToLatin = ->
  
  ###*
  Generates latinic from cyrilic.
  @param name the name
  @return the result
  ###
  UkrainianToLatin.generateLat = (name) ->
    @initialize()
    result = new StringBuilder()
    prevConvertCase = null

    for index in [0...name.length]
      curChar = name.substring(index, index + UkrainianToLatin.INDEX_1)
      nextChar = (if index is name.length - 1 then null else name.substring(index + UkrainianToLatin.INDEX_1, index + UkrainianToLatin.INDEX_2))
      continue  if curChar.match("[-'’,]")
      unless @cyrToLat[curChar]?
        if " " is curChar
          prevConvertCase = null
          result.append " "
        continue
      convertCase = @cyrToLat[curChar]
      unless prevConvertCase?
        @checkFirstChar result, convertCase, (if not @cyrToLat[nextChar]? then convertCase else @cyrToLat[nextChar])
      else
        @checkMiddleChar result, convertCase, (if not @cyrToLat[nextChar]? then convertCase else @cyrToLat[nextChar])
      prevConvertCase = convertCase
      index += 1
    result.toString()

  UkrainianToLatin.checkFirstChar = (result, convertCase, nextConvertCase) ->
    latName = convertCase.convert
    switch latName.length
      when UkrainianToLatin.LENGTH_2
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1) else latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1).toUpperCase()))
        result.append (if nextConvertCase.lowcase then "g" else "G")  if convertCase.convert is "ZZ" and nextConvertCase.convert is "HH"
      when UkrainianToLatin.LENGTH_3, UkrainianToLatin.LENGTH_4
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2) else latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2).toUpperCase()))
      when UkrainianToLatin.LENGTH_8
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4) else latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4).toUpperCase()))
  
  ###*
  @param result the output string
  @param convertCase the current char
  @param nextConvertCase the next char
  ###
  UkrainianToLatin.checkMiddleChar = (result, convertCase, nextConvertCase) ->
    latName = convertCase.convert
    switch latName.length
      when UkrainianToLatin.LENGTH_2
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2) else latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2).toUpperCase()))
        result.append (if nextConvertCase.lowcase then "g" else "G")  if convertCase.convert is "ZZ" and nextConvertCase.convert is "HH"
      when UkrainianToLatin.LENGTH_3
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3) else latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3).toUpperCase()))
      when UkrainianToLatin.LENGTH_4
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4) else latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4).toUpperCase()))
      when UkrainianToLatin.LENGTH_8
        result.append (if convertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8).toLowerCase() else (if nextConvertCase.lowcase then latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8) else latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8).toUpperCase()))

  UkrainianToLatin.initialize = ->
    @cyrToLat = {}
    for convert of UkrainianToLatin.Convert
      @cyrToLat[UkrainianToLatin.Convert[convert].substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1)] = new ConvertCase(convert, false)
      @cyrToLat[UkrainianToLatin.Convert[convert].substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2)] = new ConvertCase(convert, true)
      if convert is UkrainianToLatin.Convert.EE
        @cyrToLat["Ё"] = new ConvertCase(convert, false)
        @cyrToLat["ё"] = new ConvertCase(convert, true)
    return

  UkrainianToLatin.INDEX_0 = 0
  UkrainianToLatin.INDEX_1 = 1
  UkrainianToLatin.INDEX_2 = 2
  UkrainianToLatin.INDEX_3 = 3
  UkrainianToLatin.INDEX_4 = 4
  UkrainianToLatin.INDEX_8 = 8
  UkrainianToLatin.LENGTH_2 = 2
  UkrainianToLatin.LENGTH_3 = 3
  UkrainianToLatin.LENGTH_4 = 4
  UkrainianToLatin.LENGTH_8 = 8
  UkrainianToLatin.cyrToLat = {}
  UkrainianToLatin.Convert =
    AA: "Аа"
    BB: "Бб"
    VV: "Вв"
    HH: "Гг"
    GG: "Ґґ"
    DD: "Дд"
    EE: "Ее"
    YeIe: "Єє"
    ZhZh: "Жж"
    ZZ: "Зз"
    YY: "Ии"
    II: "Іі"
    YiI: "Її"
    YI: "Йй"
    KK: "Кк"
    LL: "Лл"
    MM: "Мм"
    NN: "Нн"
    OO: "Оо"
    PP: "Пп"
    RR: "Рр"
    SS: "Сс"
    TT: "Тт"
    UU: "Уу"
    FF: "Фф"
    KhKh: "Хх"
    TsTs: "Цц"
    ChCh: "Чч"
    ShSh: "Шш"
    ShchShch: "Щщ"
    YuIu: "Юю"
    YaIa: "Яя"

  UkrainianToLatin
)()

module.exports = 
  UkrainianToLatin: UkrainianToLatin
