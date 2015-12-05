//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var s:[String] = [String]()

s.append("asdf")
s.append("ttt")

var d:[Int:String] = [Int:String]()

d[4] = "abc"

print(d)

d[724] = "Peter"

print(d)

var j:[String: AnyObject] = [String: AnyObject]()

j["Oliver"] = "Coder"

print(j)

j["Will"] = 14

print(j)

j["s"] = s

print(j)
j["d"] = d

print(j)


var w = j["Will"]

