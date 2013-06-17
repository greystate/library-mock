<?xml version="1.0" encoding="utf-8" ?>
<!--
	## _UmbracoLibrary.xslt
	
	This file contains a set of mocks for the extension functions
	in the [umbraco.library][1] class, so I can run the exact same XSLT
	files locally on my Mac, as are running within Umbraco on the server.
	
	This works by importing this file in stylesheets that utilize the
	library functions - by way of an [entity trick][2] (surprise) so it only
	happens locally. See the accompanying `Sample.xslt` for how to use this
	along with the `entities.ent` file.
	
	[1]: http://our.umbraco.org/wiki/reference/umbracolibrary/
	[2]: http://pimpmyxslt.com/articles/entity-tricks-part3/
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func="http://exslt.org/functions"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="func umb"
	extension-element-prefixes="func"
>
	<!-- ===========================================================
	Mock for NiceUrl(nodeId)
	============================================================ -->
	<func:function name="umb:NiceUrl">
		<xsl:param name="nodeId" />
		<func:result>
			<xsl:text>/</xsl:text>
			<xsl:for-each select="ancestor-or-self::*[@isDoc][not(parent::root)]">
				<xsl:value-of select="concat(@urlName, '/')" />
			</xsl:for-each>
		</func:result>
	</func:function>
	
	<!-- ===========================================================
	Mock for GetXmlNodeById(nodeId) if you really must use it :-)
	============================================================ -->
	<func:function name="umb:GetXmlNodeById">
		<xsl:param name="nodeId" />
		<func:result select="//*[@id = $nodeId]" />
	</func:function>
	
	<!-- ===========================================================
	GetMedia(mediaId, deep) - depends on a `_media-fixture.xml` file with sample media nodes
	============================================================ -->
	<func:function name="umb:GetMedia">
		<xsl:param name="mediaId" />
		<xsl:param name="deep" />

		<xsl:variable name="mediaNodes" select="document('../app/models/_media-fixture.xml')" />
		
		<!-- Return the node or a dummy for the error that would otherwise happen -->
		<func:result select="($mediaNodes//*[@id = number($mediaId)] | $mediaNodes//*[@id = 'NaN'])[1]" />
	</func:function>
	
	<!-- ===========================================================
	Mock for FormatDateTime(date, format)
	============================================================ -->
	<func:function name="umb:FormatDateTime">
		<xsl:param name="date-value" />
		<xsl:param name="format" />
		
		<!-- Split into parts -->
		<xsl:variable name="year" select="substring($date-value, 1, 4)" />
		<xsl:variable name="month" select="substring($date-value, 6, 2)" />
		<xsl:variable name="date" select="substring($date-value, 9, 2)" />

		<!-- TODO: Handle a couple of common formats, like 'YYYY', 'd-M-Y' etc. ? -->

		<!-- Assemble a return value -->
		<func:result select="concat($year, '-', $month, '-', $date)" />
	</func:function>

</xsl:stylesheet>