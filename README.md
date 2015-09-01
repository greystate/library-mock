# Library Mock

This setup enables me to develop [Umbraco][UMBRACO] macros locally on OS X, by mocking the commonly used
extensions in the `urn:umbraco.library` and `urn:ucomponents.*` namespaces.

## How it works

It works by using a cunning and *award-winning* (yes, I wish) trick that makes the local file import the
mocks, but leaves the remote file untouched.

The actual mocks are written as simple [EXSLT functions][EXSLTFUNC] that either mimic the corresponding
library function, or just makes sure to return something that [looks like a duck][DUCK].

## Extensions currently being mocked

### From *umbraco.library*

<!-- #tminclude "/Users/chriz/Development/lib/tm-support/transform.rb"
    #xml#="umbraco/xslt/mocks/_UmbracoLibrary.xslt"
    #xslt#="lib/MocksList.xslt" -->

- [x] `CurrentDate()`
- [x] `DateAdd()`
- [x] `DateGreaterThanOrEqual()`
- [x] `DateGreaterThanOrEqualToday()`
- [x] `FormatDateTime()`
- [x] `GetMedia()`
- [x] `GetXmlNodeById()`
- [x] `HasAccess()`
- [x] `IsLoggedOn()`
- [x] `NiceUrl()`
- [ ] `Replace()`
- [x] `RequestQueryString()`
- [x] `RequestServerVariables()`
- [x] `Split()`

<!-- end tminclude -->

### From _ucomponents.*_

<!-- #tminclude "/Users/chriz/Development/lib/tm-support/transform.rb"
    #xml#="umbraco/xslt/mocks/_uComponentsExtensions.xslt"
    #xslt#="lib/MocksList.xslt" -->

- [ ] `GetRandomNumbersAsXml()` (random)
- [x] `RandomChildNode()` (xml)

<!-- end tminclude -->

(Unchecked items are extensions that have an empty stub in the file, but no real implementation yet.)

Here is the [reference for the umbraco.library functions][REF] on **Our Umbraco.**

Here is the [reference for the uComponents Extensions][UCOMREF] on **ucomponents.org**

## Installing

To install these, just copy the `mocks` folder into your `xslt` folder *OR...* you can use this super-handy link to get a couple of nifty Terminal commands (who doesn't love those?):

[greystate.dk/resources/subtree-merge](http://greystate.dk/resources/subtree-merge/?rf=umbraco/xslt/mocks&u=greystate&b=master&r=library-mock&lf=umbraco/xslt/mocks)



[UMBRACO]: https://github.com/umbraco/Umbraco-CMS
[EXSLTFUNC]: http://exslt.org/func/
[DUCK]: http://en.wikipedia.org/wiki/Duck_test
[REF]: http://our.umbraco.org/wiki/reference/umbracolibrary/
[UCOMREF]: http://ucomponents.org/xslt-extensions/
