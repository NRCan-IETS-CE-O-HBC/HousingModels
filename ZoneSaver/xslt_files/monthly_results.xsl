<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- VARIABLES -->
	<xsl:include href="setup_params.xsl" />
	
	<xsl:variable name="tplLang" select=" document( 'includes/local/lang.xml')/lang " /> 
	
	<!-- INCLUDES -->
	<xsl:include href="includes/templates/conversions.xsl" />
	<xsl:include href="includes/templates/util_templates.xsl" />
	
	<xsl:include href="includes/templates/monthly/monthly_zone_energy.xsl" />
	<xsl:include href="includes/templates/monthly/est_energy_consumption.xsl" />
	<xsl:include href="includes/templates/monthly/space_heating.xsl" />
  <xsl:include href="includes/templates/monthly/ideal_hvac.xsl" />
	<xsl:include href="includes/templates/monthly/dhw.xsl" />
	<xsl:include href="includes/templates/monthly/ac.xsl" />
	<xsl:include href="includes/templates/monthly/sdhw.xsl" />
	<xsl:include href="includes/templates/monthly/photovoltaic.xsl" />
	<xsl:include href="includes/templates/monthly/fuel_cell.xsl" />
	<xsl:include href="includes/templates/monthly/lights_appliances.xsl" />
	
	<xsl:include href="includes/templates/monthly/header.xsl" />
	<xsl:include href="includes/templates/monthly/footer.xsl" />
	  
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

    <!-- This is a menu allowing the user to switch between three reports-->
    <h4 align="right">
      <a href="h3k_input_summary.html"><xsl:value-of select="$tplLang/menu/inputs[@xml:lang=$lang]" /></a> |
      <a href="annual_results.html"><xsl:value-of select="$tplLang/menu/performance[@xml:lang=$lang]" /></a> |
      <xsl:value-of select="$tplLang/menu/monthly_results[@xml:lang=$lang]" />
    </h4>

    <hr />
		
		<xsl:apply-templates select="." mode="all_zones_energy_profile" />
		
    <br/>
    <hr />
    
		<xsl:apply-templates select="." mode="est_energy_consumption" />
<!--		
		<br/>
		<hr />
		
		<xsl:apply-templates select="." mode="sdhw" />

		<br />
		<hr />

		<xsl:apply-templates select="." mode="pv" />
	
		<br />
		<hr />

		<xsl:apply-templates select="." mode="fuel_cell" />-->

		<xsl:call-template name="footer" />
		
		</body>
		</html>	 	
	</xsl:template>
	
</xsl:stylesheet>