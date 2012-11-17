test( "generateLat", function() {
        equal("", UkrainianToLatin.generateLat(""));
        equal("abvhd", UkrainianToLatin.generateLat("абвгд"));
        equal("abvhd kh", UkrainianToLatin.generateLat("абвгд х"));
        equal("abvhd kh yulia", UkrainianToLatin.generateLat("абвгд х юля"));
        equal("yizhak", UkrainianToLatin.generateLat("їжак"));
        equal("yizhak-siryi", UkrainianToLatin.generateLat("їжак-сірий"));
        equal("Rozhon", UkrainianToLatin.generateLat("Розгон"));
        equal("Zhorany", UkrainianToLatin.generateLat("Згорани"));
        equal("Zhorany'", UkrainianToLatin.generateLat("Згорани'"));
        equal("Zhorany'", UkrainianToLatin.generateLat("Згорани’"));
});
