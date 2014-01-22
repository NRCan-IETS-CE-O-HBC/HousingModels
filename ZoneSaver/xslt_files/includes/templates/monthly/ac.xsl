<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="ACTemplate" select="$EECSection/templates/template[ @name = 'ac' ]"  />
	
	
	<!-- 
	=============================================================================
	
	Template Name: ac
	Data Created: MAR.05.2008
	
	Description:
		
		Main template for the A/C Report.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="ac">
		<xsl:param name="xmlNode" select="." />

		<table border="0" cellspacing="0" cellpadding="0" class="monthly_report">
		
			<!-- Display all the headings using the language xml file. -->
			<tr class="title">
				<td colspan="5" align="center"><xsl:value-of select="$ACTemplate/title[@xml:lang=$lang]" /></td>
			</tr>
			
			<tr class="headerRow">
				<td></td>
				<td align="center"></td>
				<th align="center"><xsl:value-of select="$ACTemplate/headings/fans_pumps[@xml:lang=$lang]" /></th>
			</tr>
			
			<tr class="headerRow">
				<th><xsl:call-template name="month_table_header" /></th>

				<th>
					<xsl:value-of select="$ACTemplate/headings/fuel[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$ACTemplate/headings/elec[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
			</tr>
			
			<!--  Loop through months and display output. -->
			<xsl:for-each select="$tplLang/months/month">
				<xsl:apply-templates select="$xmlNode" mode="ac_row">
					<xsl:with-param name="monthIndex" select="@id" />
				</xsl:apply-templates>
			</xsl:for-each>
		
		
			<!-- ANNUAL -->
			<xsl:apply-templates select="." mode="ac_annual_data" />
		
		</table>
		
		
		
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: ac_row
	Data Created: MAR.04.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="ac_row">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="ac_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="ac_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: ac_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays a row of monthly data for the A/C Report.
		
		TAGS USED:
			
			FUEL: 	plant/ideal_hvac_models/component_01_air_source_heat_pump/energy_input/cooling/
			ELECT: 	plant/ideal_hvac_models/component_01_air_source_heat_pump/fuel_use/electricity/amount
			
					
	=============================================================================
	-->
	<xsl:template match="*" mode="ac_data">
		<xsl:param name="monthIndex" />
		
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>
		
		<td>
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="energy_input/cooling/binned_data[@type = 'monthly' and index = $monthIndex]/sum" />
			</xsl:call-template>
		</td>
		<td>
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="fuel_use/electricity/amount/binned_data[@type = 'monthly' and index = $monthIndex]/sum" />
			</xsl:call-template>
		</td>
		
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: ac_annual_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays the Annual A/C information.
		
	=============================================================================
	-->
	<xsl:template match="*" mode="ac_annual_data">
		<tr class="totalRow">
			<th><xsl:call-template name="annual_label" /></th>
			
			<td>
				<xsl:call-template name="heatValue">
					<xsl:with-param name="value" select="energy_input/cooling/binned_data[@type = 'annual' ]/sum" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="heatValue">
					<xsl:with-param name="value" select="fuel_use/electricity/amount/binned_data[@type = 'annual' ]/sum" />
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>