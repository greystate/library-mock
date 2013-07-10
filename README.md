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
    #xml#="umbraco/xslt/_UmbracoLibrary.xslt"
    #xslt#="lib/MocksList.xslt" -->

- [x] `NiceUrl()`
- [x] `GetXmlNodeById()`
- [x] `GetMedia()`
- [x] `FormatDateTime()`
- [x] `CurrentDate()`
- [x] `Split()`
- [ ] `Replace()`

<!-- end tminclude -->

### From *ucomponents.\**

<!-- #tminclude "/Users/chriz/Development/lib/tm-support/transform.rb"
    #xml#="umbraco/xslt/_uComponentsExtensions.xslt"
    #xslt#="lib/MocksList.xslt" -->

- [x] `RandomChildNode()` (xml)

<!-- end tminclude -->

(Unchecked items are extensions that have an empty stub in the file, but no real implementation yet.)

Here is the [reference for the original functions][REF] on **Our Umbraco.**

## Would this be useful as a submodule?

If I can somehow figure out how to use this as a [git submodule][SUBMODULE] and it makes sense, I'll be
sure to write some instructions here:

*(This space available for description)*



[UMBRACO]: https://github.com/umbraco/Umbraco-CMS
[EXSLTFUNC]: http://exslt.org/func/
[DUCK]: http://en.wikipedia.org/wiki/Duck_test
[SUBMODULE]: http://git-scm.com/book/en/Git-Tools-Submodules
[REF]: http://our.umbraco.org/wiki/reference/umbracolibrary/