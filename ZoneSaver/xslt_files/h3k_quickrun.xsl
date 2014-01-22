<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="html" />
	
	<!-- VARIABLES -->
	<xsl:include href="setup_params.xsl" />
	
	<xsl:variable name="tplLang" select=" document( 'includes/local/lang.xml')/lang " /> 
	
	<!-- INCLUDES -->
    <xsl:include href="includes/templates/conversions.xsl" />
	<xsl:include href="includes/templates/h3k/annual_quick_run.xsl" />
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

           
      	
			<hr />
			
			<xsl:apply-templates select="." mode="annual_quick_run" />
			

        
			
		</body>
		</html>	 	
	</xsl:template> 
	

	
</xsl:stylesheet>