
JS the best place to break is after an operator

All JS have a toString()

JS Hoisting : all variables are put at the top of the block (declaration). Watch out (not initialised). Let and const will not work in the bottom because not initialised

At the beginning of the script :
"use strict";

With arrow functions, 'this' always represents the object that defined the arrow function.

Arrow functions do not have their own 'this'

Arrow functions are not hoisted

Regular functions :
- 'this' represents the object that calls the function

Arrow functions :
- 'this' represents the owner of the function

JS 
names in camelCase (variables and functions)
Object Constructor with Upper Letter (use function key word.. !)

Line < 80
See JS convention

Jsbeautifier exists in python

https://beautifier.io

JS you must test for not undefined before you can test for not null

JS access DOM once
Reduce activity (in for loop)
Avoid unnecessary variables

JS objects are mutable

In JS, (attributes are called properties?)
Properties have name and value. The value is one of the properties attributes. Other attributes are enumerable, configurable, writable

Methods are function stored as object properties.

You can add a method to an existing object with the "function" and "this" synthax

Setter and getter example
Object defineProperty

Property has a lot of common with python decorator

Example get and set property

Never modify the prototype of standard JS objects

JS Iterable in for loops need iterator symbols

Because of hoisting, JS can be called before declared (declaration goes to the top)

const is safer than using var for function expression since function expression is always a const value

Function you can omit the return if it is a single statement

In JavaScript function can be invoked without being called

JS function invocation : 
1) function as function
2) function as method not an object
3) function as a constructor

In JavaScript, all function are object methods

Check carefully when using apply in strict and non strict mode

JS private variables with closures. A closure is a function having access to the parent scope, even after the parent function has closed.

JS synthax in class must be written in strict mode

JS class declaration are not hoisted

JS callback (.. giving function as argument)

JS Promises can be simplified with Async and await

JS (Async await) suppress the expression promise.then(myResolve(value),myMistake(Error))

HTML DOM (document object model)

?Language neutral interface? Probably just an interface for any languages

Html JS DOM 
Bubbling is the inner most element's event (default)
Capturing is the outer most element's event

BOM allows JS to "talk to the browser"

BOM: windows do not include toolbars and scrollbars

Web worker have no access to windows/document/parent object