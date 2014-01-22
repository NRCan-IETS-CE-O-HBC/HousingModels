<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="EECSection" select="$tplLang/monthly/sections/section[ @name = 'eec']" />
	
	<!-- 
	=============================================================================
	
	Template Name: est_energy_consumption
	Data Created: MAR.04.2008
	
	Description:
		
		Main template for Estimated Energy Consumption Reports.
	
	=============================================================================
	-->
	
	<xsl:template match="*" mode="est_energy_consumption">
		
		<h1><xsl:value-of select="$EECSection/heading" /></h1>

    <h2><xsl:value-of select="$EECSection/sections/conventional_systems/title[@xml:lang=$lang]" /></h2>
    <p><xsl:value-of select="$EECSection/sections/conventional_systems/description[@xml:lang=$lang]" /></p>

    <xsl:apply-templates select="." mode="ideal_hvac" />

    <xsl:apply-templates select="." mode="circulation_ventilation" />

    <xsl:apply-templates select="plant/ideal_DHW_model" mode="dhw" />

    <h2><xsl:value-of select="$EECSection/sections/advanced_systems/title[@xml:lang=$lang]" /></h2>
    <p><xsl:value-of select="$EECSection/sections/advanced_systems/description[@xml:lang=$lang]" /></p>

    <xsl:apply-templates select="building/spmatl/pv-array" mode="pv" />

    <xsl:apply-templates select="plant/solar_collector" mode="sdhw" />

  </xsl:template>

</xsl:stylesheet>