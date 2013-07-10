<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY newline "&#10;">
	<!ENTITY tick "`">
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:func="http://exslt.org/functions"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="func umb"
>
	<xsl:output method="text" indent="yes" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:text>&newline;</xsl:text>
		
		<xsl:apply-templates select="xsl:stylesheet/func:function" />
		
		<xsl:text>&newline;</xsl:text>
	</xsl:template>
	
	<!-- Show implemented functions as completed tasks -->
	<xsl:template match="func:function">
		<xsl:variable name="completed" select="substring('x| ', not(func:result) * 2 + 1, 1)" />
		<xsl:value-of select="concat('- [', $completed, '] &tick;', substring-after(@name, 'umb:'), '()&tick;')" />
		<xsl:text>&newline;</xsl:text>
	</xsl:template>
	
</xsl:stylesheet>