# ukrainiantolatin.test.coffee

conv = require '../../main/coffee/ukrainiantolatin.coffee'

equal = (expected, actual) ->
  throw new Error(expected + " != " + actual) if expected != actual
  
test_generateLat = ()->
#    equal("", conv.UkrainianToLatin.generateLat(""));
    equal("abvhd", conv.UkrainianToLatin.generateLat("абвгд"));
#    equal("abvhd kh", conv.UkrainianToLatin.generateLat("абвгд х"));
#    equal("abvhd kh yulia", conv.UkrainianToLatin.generateLat("абвгд х юля"));
    equal("yizhak", conv.UkrainianToLatin.generateLat("їжак"));
#    equal("yizhaksiryi", conv.UkrainianToLatin.generateLat("їжак-сірий"));
    equal("Rozghon", conv.UkrainianToLatin.generateLat("Розгон"));
    equal("Zghorany", conv.UkrainianToLatin.generateLat("Згорани"));
#    equal("Zghorany", conv.UkrainianToLatin.generateLat("Згорани'"));
#    equal("Zghorany", conv.UkrainianToLatin.generateLat("Згорани’"));

test_generateLat()
console.log "Tests were run test_generateLat()"
