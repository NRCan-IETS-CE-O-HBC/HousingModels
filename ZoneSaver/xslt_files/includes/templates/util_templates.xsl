<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:template name="month_name">
		<xsl:param name="index" />
		
		<xsl:value-of select="$tplLang/months/month[@id = $index]/label[@xml:lang=$lang]" />
		
	</xsl:template>
	
	<xsl:template name="month_table_header">
		<xsl:value-of select="$tplLang/months/heading[ @xml:lang=$lang ]" />
	</xsl:template>
	
	<xsl:template name="annual_label">
		<xsl:value-of select="$tplLang/annual/label[@xml:lang=$lang]" />
	</xsl:template>
	
	
</xsl:stylesheet>