<?xml version="1.0" encoding="utf-8" ?>
<!--
	## Sample.xslt
	
	Sample of an XSLT macro using the `_UmbracoLibrary.xslt` file for
	mocking the extensions when developing locally on OS X.
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY % entities SYSTEM "entities.ent">
	%entities;
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>
	&compatibility;
	
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

	<!-- Supplied by Umbraco - the link to the XML (the select attribute is for when Umbraco isn't available, e.g. locally) -->
	<xsl:param name="currentPage" select="//*[@isDoc][1]" />
	
	<!-- Convenience variable - grabs the top node of the current site -->
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::*[@level = 1]" />
	
	<!-- Root template (called automatically) -->
	<xsl:template match="/">
		<!-- Process the current page -->
		<xsl:call-template name="SplitSample" /> 
	</xsl:template>

	<xsl:template name="SplitSample">
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'Split'" />
			</xsl:call-template>
			<xsl:for-each select="umb:Split('a,b,c,d,e,f', ',')/value">
				<p><xsl:value-of select="." /></p>
			</xsl:for-each>
		</section>
	</xsl:template>
	
	<xsl:template name="SampleHeader">
		<xsl:param name="function" />
		<h1><xsl:value-of select="$function" /></h1>
	</xsl:template>
	
</xsl:stylesheet>