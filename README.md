# kd
kd stands for Klass Diagram. In some programming languages, the spelling "klass" is sometimes used instead of "class" to name a variable when the latter is already used as a syntactic keyword, that's why I decided to go with this name. Also kd sounds kool.

kd's goal is to generate class diagrams for the web from a simple language. Ultimately, it should be embeddable as simply as [Mathjax](http://www.mathjax.org/) and generate SVG or canvas or HTML or image or all of these (I didn't decide yet) in a clean way. Due to its strict syntax, it should also be able to generate arbitrary code (Java, C++, PHP, etc.).

kd uses [Jison](http://zaach.github.io/jison/) to generate the language parser.

**This project is currently a WIP and far from usable.**

## Example codes
### Simplest class declaration
    | ClassName

### Class with attributes
    | ClassName
        - privateAttr: int
        # protectedAttribute: int
        ~ packageAttribute: int
        + publicAttribute: int
        +_ publicStaticAttribute: int
        -/ privateDerivedAttr: int
        -/_ privateDerivedStaticAttribute: int
        - array: int[10]
        - list: int[1..*]

### Class with operations
    | ClassName
        <<constructor>> +_ ClassName(): ClassName
        - privateMethod(): void
        + abstractMethod(): void {abstract}
        + publicMethodWithParams(param1: int, paramList: int[*]): int

### Class with stereotype
    | <<interface>> ClassName

### Class with constraint
    | ClassName {abstract}

### Template class
    | TemplateClass[key:K, value:V]

## Features
### Implemented
* Class declaration
    - Simple class
    - Template class
    - Stereotype
    - Constraint
* Attribute declaration
    - Stereotype
    - Visibility
    - Derivable/Classifier
    - Name
    - Type
    - Constraint
    - Multiplicity
* Operation declaration
    - Stereotype
    - Visibility
    - Derivable/Classifier
    - Name
    - Type
    - Parameters (including multiplicity)
    - Constraint

### To do
* **Attribute the grammar**
    - Native support of `<<interface>>`
        + if a class has this stereotypes, all its operations become abstract
    - Native support of `<<constructor>>`
        + its name must match the class name
        + its return value must be the same as the class name
        + it's static
    - Native support of `{abstract}`
        + if a method is abstract, the class is set as abstract
* **Diagram generation**
* Attributes
    - default value
* Operation parameters
    - default value
    - direction? (`in`, `out`, `inout`)
* Package
    - the standard syntax is `Package1::...::PackageN::ClassName` but it will hardly be possible to follow it exactly
* Notes/comments
    - Syntax: `"comment goes here"`
* Relations
    - Support of inheritance with `extends` and implementation with `implements`
    - Smart relations when a class A has an attribute of type B and B is defined in the diagram
    - Other relations with a sub-grammar (ie. `ClassA [0..1]---[*] ClassB`)

## Notes and limitations
1. The difference between [stereotypes](http://en.wikipedia.org/wiki/Stereotype_%28UML%29) and [classifiers](http://en.wikipedia.org/wiki/Classifier_%28UML%29) won't be made since they both use the same syntax.
2. Only one stereotype at most can be used per class/member, because I don't know if the standard allows multiple stereotypes. It's easy to change though.
3. You **have to** specify a return type to an operation, even if it's simply void.
4. For parsing reasons, the visibility is always mandatory.

## References
[UML 2 - De l'apprentissage à la pratique](http://laurent-audibert.developpez.com/Cours-UML/?page=diagramme-classes)

## License
The MIT License (MIT)

Copyright (c) 2014 Thibaut Rousseau

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
