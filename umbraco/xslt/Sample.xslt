<?xml version="1.0" encoding="utf-8" ?>
<!--
	## Sample.xslt
	
	Samples of using the `_UmbracoLibrary.xslt` and `_uComponentsExtensions.xslt` files
	for mocking various extensions when developing locally on OS X.
	
	Serves as a simple test file - just run it using itself as the XML data,
	to see if everything works.
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY % entities SYSTEM "mocks/entities.ent">
	%entities;
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	xmlns:make="http://exslt.org/common"
	xmlns:ucom.xml="urn:ucomponents.xml"
	exclude-result-prefixes="umb make ucom.xml"
>
	&compatibility;
	
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

	<!-- Supplied by Umbraco - the link to the XML (the select attribute is for when Umbraco isn't available, e.g. locally) -->
	<xsl:param name="currentPage" select="//*[@isDoc][1]" />
	
	<!-- Convenience variable - grabs the top node of the current site -->
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::*[@level = 1]" />
	
	<!-- Root template (called automatically) -->
	<xsl:template match="/">
		<!-- Run the misc. samples -->
		
		<h2>umbraco.library Samples</h2>
		<xsl:call-template name="CurrentDateSample" />
		<xsl:call-template name="DateGreaterThanOrEqualTodaySample" />
		<xsl:call-template name="DateGreaterThanOrEqualSample" />
		<xsl:call-template name="DateAddSample" />
		<xsl:call-template name="SplitSample" /> 
		<xsl:call-template name="GetMediaSample" />
		<xsl:call-template name="HasAccessSample" />
		
		<h2>uComponents Samples</h2>
		<xsl:call-template name="RandomChildNodeSample" />
		
	</xsl:template>

	<xsl:template name="SplitSample">
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'Split'" />
			</xsl:call-template>
			<xsl:for-each select="umb:Split('a,b,c,d,e,f', ',')/value">
				<xsl:variable name="color" select="position() * 40" />
				<span style="color:rgb({$color}, {round($color div 2)}, {$color})"><xsl:value-of select="." /></span>
			</xsl:for-each>
		</section>
	</xsl:template>
	
	<xsl:template name="GetMediaSample">
		<xsl:call-template name="SampleHeader">
			<xsl:with-param name="function" select="'GetMedia'" />
		</xsl:call-template>

		<xsl:variable name="media" select="umb:GetMedia(1667, false())" />
		<img src="{$media/umbracoFile}" width="{$media/umbracoWidth}" />
	</xsl:template>
	
	<xsl:template name="CurrentDateSample">
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'CurrentDate'" />
			</xsl:call-template>
			
			<p>Now: <xsl:value-of select="umb:CurrentDate()" /></p>
		</section>
	</xsl:template>
	
	<xsl:template name="RandomChildNodeSample">
		<xsl:variable name="nodesProxy">
			<Website isDoc="">
				<Textpage id="1" isDoc=""></Textpage>
				<Textpage id="2" isDoc=""></Textpage>
				<Textpage id="3" isDoc=""></Textpage>
				<Textpage id="4" isDoc=""></Textpage>
				<Textpage id="5" isDoc=""></Textpage>
				<Textpage id="6" isDoc=""></Textpage>
			</Website>
		</xsl:variable>
		<xsl:variable name="parent" select="make:node-set($nodesProxy)/Website" />
		
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'RandomChildNode'" />
			</xsl:call-template>
			
			<p>
				Here's the id of a “random” child element from a set of 6 nodes:
				<code><xsl:value-of select="ucom.xml:RandomChildNode($parent)/@id" /></code>
			</p>
		</section>
	</xsl:template>
	
	<xsl:template name="HasAccessSample">
		<xsl:call-template name="SampleHeader">
			<xsl:with-param name="function" select="'HasAccess'" />
		</xsl:call-template>
		
		<p>
			By default we have access, so should be 'true':
			<strong><xsl:value-of select="umb:HasAccess(1200, '-1,1300,4500,1200')" /></strong>
		</p>
		<p>
			Trying the sample protected one from the fixture should yield 'false':
			<strong><xsl:value-of select="umb:HasAccess(1200, '-1,1080,1200')" /></strong>
		</p>
	</xsl:template>

	<xsl:template name="DateGreaterThanOrEqualTodaySample">
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'DateGreaterThanOrEqualToday'" />
			</xsl:call-template>
			
			<p>Is my birthday (1970-12-28) greater than today? — <strong><xsl:value-of select="umb:DateGreaterThanOrEqualToday('1970-12-28')" /></strong></p>
			<p>Is today greater than (or equal to) today? - <strong><xsl:value-of select="umb:DateGreaterThanOrEqualToday(umb:CurrentDate())" /></strong></p>
			<p>Is my 80th birthday greater than today? — <strong><xsl:value-of select="umb:DateGreaterThanOrEqualToday('2050-12-28')" /></strong></p>
		</section>
	</xsl:template>
	
	<xsl:template name="DateGreaterThanOrEqualSample">
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'DateGreaterThanOrEqual'" />
			</xsl:call-template>
			
			<p>Is my birthday (1970-12-28) greater than January 1st the year after? — <strong><xsl:value-of select="umb:DateGreaterThanOrEqual('1970-12-28', '1971-01-01')" /></strong></p>
			<p>Is May 4th, 1977 greater than (or equal to) May 4th 1977? <strong><xsl:value-of select="umb:DateGreaterThanOrEqual('1977-05-04', '1977-05-04')" /></strong></p>
			<p>Is July 1st 2013 greater than July 1st 2012? - <strong><xsl:value-of select="umb:DateGreaterThanOrEqual('2013-07-01', '2012-07-01')" /></strong></p>
		</section>
	</xsl:template>
	
	<xsl:template name="DateAddSample">
		<xsl:variable name="today" select="substring-before(umb:CurrentDate(), 'T')" />
		<section class="sample">
			<xsl:call-template name="SampleHeader">
				<xsl:with-param name="function" select="'DateAdd'" />
			</xsl:call-template>
			
			<p>My 50th birthday is: <strong><xsl:value-of select="umb:DateAdd('1970-12-28', 'y', 50)" /></strong></p>
			<p>Tomorrow is: <strong><xsl:value-of select="umb:DateAdd($today, 'd', 1)" /></strong></p>
			<p>Yesterday was: <strong><xsl:value-of select="umb:DateAdd($today, 'h', -24)" /></strong></p>
		</section>
	</xsl:template>
	
	<xsl:template name="SampleHeader">
		<xsl:param name="function" />
		<h1><xsl:value-of select="concat('umb:', $function, '()')" /></h1>
	</xsl:template>
	
</xsl:stylesheet>