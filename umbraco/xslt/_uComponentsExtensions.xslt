<?xml version="1.0" encoding="utf-8" ?>
<!--
	## _uComponentsExtensions.xslt
	
	This file contains mocks for various extension functions in the
	[uComponents namespaces][1] (see the `_UmbracoLibrary.xslt` file for
	more info on how this works).
	
	[1]: http://ucomponents.org/xslt-extensions/
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func="http://exslt.org/functions"
	xmlns:dates="http://exslt.org/dates-and-times"
	xmlns:str="http://exslt.org/strings"
	xmlns:make="http://exslt.org/common"
	xmlns:math="http://exslt.org/math"
	xmlns:ucom.xml="urn:ucomponents.xml"
	exclude-result-prefixes="func dates make math ucom.xml"
	extension-element-prefixes="func"
>

<!-- :: Extensions in urn:ucomponents.xml :: -->

	<!-- ===========================================================
	Mock for RandomChildNode()
	============================================================ -->
	<func:function name="ucom.xml:RandomChildNode">
		<xsl:param name="node" />
		<xsl:variable name="childNodes" select="$node/*[@isDoc]" />
		<xsl:message><xsl:value-of select="math:random()" /></xsl:message>
		<xsl:variable name="count" select="count($childNodes)" />
		<xsl:variable name="randomChild" select="$childNodes[position() = floor(math:random() * $count) + 1]" />
		<func:result select="$randomChild" />
	</func:function>

</xsl:stylesheet>