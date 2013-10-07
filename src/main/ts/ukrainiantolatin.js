var StringBuilder = (function () {
    function StringBuilder() {
        this._buffer = [];
    }
    StringBuilder.prototype.append = function (text) {
        this._buffer[this._buffer.length] = text;
        return this;
    };

    StringBuilder.prototype.insert = function (index, text) {
        this._buffer.splice(index, 0, text);
        return this;
    };

    StringBuilder.prototype.toString = function () {
        return this._buffer.join("");
    };
    return StringBuilder;
})();

var ConvertCase = (function () {
    function ConvertCase(convert, lowcase) {
        this.convert = convert;
        this.lowcase = lowcase;
    }
    return ConvertCase;
})();

var UkrainianToLatin = (function () {
    function UkrainianToLatin() {
    }
    UkrainianToLatin.generateLat = function (name) {
        this.initialize();
        var result = new StringBuilder();
        var prevConvertCase = null;
        for (var index = 0; index < name.length; index += 1) {
            var curChar = name.substring(index, index + UkrainianToLatin.INDEX_1);
            var nextChar = index == name.length - 1 ? null : name.substring(index + UkrainianToLatin.INDEX_1, index + UkrainianToLatin.INDEX_2);
            if (curChar.match("[-'’,]")) {
                continue;
            }
            if (this.cyrToLat[curChar] == null) {
                if (" " == curChar) {
                    prevConvertCase = null;
                    result.append(' ');
                }
                continue;
            }
            var convertCase = this.cyrToLat[curChar];
            if (prevConvertCase == null) {
                this.checkFirstChar(result, convertCase, this.cyrToLat[nextChar] == null ? convertCase : this.cyrToLat[nextChar]);
            } else {
                this.checkMiddleChar(result, convertCase, this.cyrToLat[nextChar] == null ? convertCase : this.cyrToLat[nextChar]);
            }
            prevConvertCase = convertCase;
        }
        return result.toString();
    };
    UkrainianToLatin.checkFirstChar = function (result, convertCase, nextConvertCase) {
        var latName = convertCase.convert;
        switch (latName.length) {
            case UkrainianToLatin.LENGTH_2:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1) : latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1).toUpperCase());
                if (convertCase.convert == "ZZ" && nextConvertCase.convert == "HH") {
                    result.append(nextConvertCase.lowcase ? "g" : "G");
                }
                break;
            case UkrainianToLatin.LENGTH_3:
            case UkrainianToLatin.LENGTH_4:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2) : latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_2).toUpperCase());
                break;
            case UkrainianToLatin.LENGTH_8:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4) : latName.substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_4).toUpperCase());
                break;
            default:
                break;
        }
    };

    UkrainianToLatin.checkMiddleChar = function (result, convertCase, nextConvertCase) {
        var latName = convertCase.convert;
        switch (latName.length) {
            case UkrainianToLatin.LENGTH_2:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2) : latName.substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2).toUpperCase());
                if (convertCase.convert == "ZZ" && nextConvertCase.convert == "HH") {
                    result.append(nextConvertCase.lowcase ? "g" : "G");
                }
                break;
            case UkrainianToLatin.LENGTH_3:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3) : latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_3).toUpperCase());
                break;
            case UkrainianToLatin.LENGTH_4:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4) : latName.substring(UkrainianToLatin.INDEX_2, UkrainianToLatin.INDEX_4).toUpperCase());
                break;
            case UkrainianToLatin.LENGTH_8:
                result.append(convertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8).toLowerCase() : nextConvertCase.lowcase ? latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8) : latName.substring(UkrainianToLatin.INDEX_4, UkrainianToLatin.INDEX_8).toUpperCase());
                break;
            default:
                break;
        }
    };
    UkrainianToLatin.initialize = function () {
        this.cyrToLat = {};
        for (var convert in UkrainianToLatin.Convert) {
            this.cyrToLat[UkrainianToLatin.Convert[convert].substring(UkrainianToLatin.INDEX_0, UkrainianToLatin.INDEX_1)] = new ConvertCase(convert, false);
            this.cyrToLat[UkrainianToLatin.Convert[convert].substring(UkrainianToLatin.INDEX_1, UkrainianToLatin.INDEX_2)] = new ConvertCase(convert, true);
            if (convert == UkrainianToLatin.Convert.EE) {
                this.cyrToLat["Ё"] = new ConvertCase(convert, false);
                this.cyrToLat["ё"] = new ConvertCase(convert, true);
            }
        }
    };
    UkrainianToLatin.INDEX_0 = 0;
    UkrainianToLatin.INDEX_1 = 1;
    UkrainianToLatin.INDEX_2 = 2;
    UkrainianToLatin.INDEX_3 = 3;
    UkrainianToLatin.INDEX_4 = 4;
    UkrainianToLatin.INDEX_8 = 8;
    UkrainianToLatin.LENGTH_2 = 2;
    UkrainianToLatin.LENGTH_3 = 3;
    UkrainianToLatin.LENGTH_4 = 4;
    UkrainianToLatin.LENGTH_8 = 8;

    UkrainianToLatin.Convert = {
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
    };
    return UkrainianToLatin;
})();
