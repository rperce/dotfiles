#!/usr/bin/env python
#coding:utf-8
"""
  Author:  Sir Garbagetruck --<truck@notonfire.co.uk>
  Purpose: tmux compose key
  Created: 19/12/14
"""
from __future__ import print_function
import sys

#----------------------------------------------------------------------
def keynamelookup(key):
    """return the character for a descriptive key name"""
    table = { 'space':' ',
              'period':'.',
              'comma':',',
              'colon':':',
              'dead_tilde':'~',
              'dead_acute':'´',
              'apostrophe':'\'',
              'dead_grave':'`',
              'dead_circumflex':'^',
              'quotedbl':'"',
              'less':'<',
              'greater':'>',
              'minus':'-',
              'plus':'+',
              'parenleft':'[',
              'parenright':']',
              'slash':"\\",
              'exclam':'!',
              'question':'?',
              'asterisk':'*',
              'percent':'%',
              'equal':'=',
              'numbersign':'#',
              'diaeresis':':',
              'asciitilde':'~',
              'dead_currency':'cur',
              'dead_belowcomma':',',
              'dead_abovedot':';',
              'asciicircum':'^^',
              'bar':'|',
              'underbar':'_',
              'dead_abovering':'o',
              'dead_belowdot':'.',
              'dead_hook':'hook',
              'dead_horn':'horn',
              'dead_macron':'=',
              'dead_greek':'greek',
              'dead_ogonek':'og',
              'underscore':'_'
    }
    try:
        return table[key]
    except:
        return '|null| - ' + key

#----------------------------------------------------------------------
def breakout(string):
    """break out the keys and result given a utf8 key def line"""
    s = string.split(':')
    rside = s[1].split()
    result = {}
    result['char'] = rside[0].replace('"','')
    try:
        result['charname'] = rside[1]
    except:
        pass
    try:
        result['utf8name'] = rside[3]
    except:
        pass
    lside = s[0].split()
    if lside[0].startswith('<Multi_key'):
        lside.pop(0)
    stroke = ""
    for i in lside:
        j = i.replace("<","")
        j = j.replace(">","")
        if len(j) > 1:
            j = keynamelookup(j)
        stroke = stroke + j
    result['stroke'] = stroke
    return result

#----------------------------------------------------------------------
def utf8keys(input):
    """read in and return the utf8 x11 key defs"""
    f = open('/usr/share/X11/locale/en_US.UTF-8/Compose','r')
    r = f.read().splitlines()
    f.close()
    table = {}
    for i in r:
        if i.startswith('<'):
            result = breakout(i)
            table[result['stroke']] = result['char']
    if input == 'dump':
        a = []
        ky = table.keys()
        for i in iter(ky):
            a.append(i)
        a.sort()
        for i in a:
            print(i,table[i])
    else:
        try:
            print(table[input],end='')
        except:
            pass

#----------------------------------------------------------------------
def main(strokes):
    """given 2 keystrokes, return the utf8 character from the x11 file"""
    keystrokes = utf8keys(strokes)


if __name__ == '__main__':
    s = ""
    x = sys.argv
    x.pop(0)
    for i in x:
        s = s+i
    main(s)
