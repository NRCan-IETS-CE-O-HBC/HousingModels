<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html" />
	
	<!-- VARIABLES -->
	<xsl:include href="setup_params.xsl" />
	
	<xsl:variable name="tplLang" select=" document( 'includes/local/lang.xml')/lang " /> 
	
	<!-- INCLUDES -->
	<xsl:include href="includes/templates/conversions.xsl" />
	<xsl:include href="includes/templates/h3k/building_params.xsl" />
	<xsl:include href="includes/templates/h3k/annual_sh_cooling_infil.xsl" />
	<xsl:include href="includes/templates/h3k/annual_domestic_water_heating.xsl" />
	<xsl:include href="includes/templates/h3k/est_annual_fuel_consumption.xsl" />
	<xsl:include href="includes/templates/h3k/zone_max_min.xsl" />
	<xsl:include href="includes/templates/h3k/header.xsl" />
		  
	<!-- 
	
		ROOT TEMPLATE
	
		This is where the report begins.
	-->
	<xsl:template match="/">
		<html>
		<xsl:call-template name="header" />
		<body>
			
			<table width="100%" border="0">
				<tr>
					<td aign="right">
						<h2 align="right">
              <xsl:value-of select="$tplLang/banner/program[@xml:lang=$lang]" /> <br />
              <xsl:value-of select="$tplLang/banner/agency[@xml:lang=$lang]" />  <br />
              <xsl:value-of select="$tplLang/banner/version[@xml:lang=$lang]" /> 
						</h2>
					</td>
					<td width="170"><img src="logo.gif" /></td>
				</tr>
			</table>


      <h4 align="right">
        <a href="h3k_input_summary.html"><xsl:value-of select="$tplLang/menu/inputs[@xml:lang=$lang]" /></a> |
        <xsl:value-of select="$tplLang/menu/performance[@xml:lang=$lang]" /> | 
        <a href="monthly_results.html"><xsl:value-of select="$tplLang/menu/monthly_results[@xml:lang=$lang]" /></a>
      </h4>
			<hr />
			
			<xsl:apply-templates select="." mode="building_parameters" />
			
			<hr />
			
			<xsl:apply-templates select="." mode="annual_sh_cooling_infil" />
			
			<hr />
			
			<xsl:apply-templates select="." mode="annual_domestic_water_heating" />
			
			<hr />
			
			<xsl:apply-templates select="." mode="est_annual_fuel_consumption" />

			<hr />
			
			<xsl:apply-templates select="." mode="zone_max_min" />
			
		</body>
		</html>	 	
	</xsl:template>
	

	
</xsl:stylesheet>