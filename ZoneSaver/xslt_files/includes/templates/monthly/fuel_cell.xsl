<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="fuelCellSection" select="$tplLang/monthly/sections/section[ @name = 'fuel_cell' ]"  />
	<xsl:variable name="fuelCellTemplate" select="$fuelCellSection/templates/template[ @name = 'fuel_cell' ]"  />
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: fuel_cell
	Data Created: MAR.04.2008
	
	Description:
		
		Main template for displaying Fuel Cell Reports.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="fuel_cell">

		<h1><xsl:value-of select="$fuelCellSection/heading" /></h1>
		
		<xsl:apply-templates select="/system/plant" mode="fuel_cell_monthly" />
	
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: fuel_cell_monthly
	Data Created: MAR.04.2008
	
	Description:
		
		Displays Fuel Cell information.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="fuel_cell_monthly">
		<xsl:param name="zone" />
		<xsl:param name="xmlNode" select="." />
		
		<table border="0" cellpadding="0" cellspacing="0" class="monthly_report">
		
			<!-- Display all the headings using the language xml file. -->
			<tr class="headerRow">
				<th><xsl:value-of select="$tplLang/months/heading[@xml:lang=$lang]" /></th>
				
				<th>
					<xsl:value-of select="$fuelCellTemplate/headings/fuel_con[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$fuelCellTemplate/headings/elec_gen[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$fuelCellTemplate/headings/thermal[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$fuelCellTemplate/headings/cog[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>

			</tr>
			
			<!--  Loop through months and display output. -->
			<xsl:for-each select="$tplLang/months/month">
				<xsl:apply-templates select="$xmlNode" mode="fuel_cell_row">
					<xsl:with-param name="monthIndex" select="@id" />
				</xsl:apply-templates>
			</xsl:for-each>
		
		
			<!-- ANNUAL -->
			<xsl:apply-templates select="." mode="fuel_cell_annual_data" />
		
		</table>
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: fuel_cell_row
	Data Created: MAR.04.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="fuel_cell_row">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="fuel_cell_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="fuel_cell_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: fuel_cell_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays a row of monthly data for the Fuel Cell Report.
		
		TAGS USED:
			
			Change tag to report fuel energy content 	( a )
			plant/fuel-cell/misc_data/Q_electric_net 	( b )
			plant/fuel-cell/misc_data/Q_thermal_net		( c )		
			( b+c ) / a

		
		Note:
			The <td> tags have been seperated into it's own template to allow alternate row colors without duplicating this code.
			
	=============================================================================
	-->
	<xsl:template match="*" mode="fuel_cell_data">
		<xsl:param name="monthIndex" />
		
		<xsl:variable name="a">
			<xsl:call-template name="heatValue">
				<xsl:with-param 
					name="value" 
					select="ideal_hvac_models/component_01_air_source_heat_pump/coil_load/total/binned_data[ @type = 'monthly' and index = $monthIndex ]/sum" 
					/> 
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="b">
			<xsl:call-template name="heatValue">
				<xsl:with-param 
					name="value" 
					select="ideal_hvac_models/component_01_air_source_heat_pump/coil_load/sensible/binned_data[ @type = 'monthly' and index = $monthIndex]/sum" 
					/> 
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="c">
			<xsl:call-template name="heatValue">
				<xsl:with-param 
					name="value" 
					select="ideal_hvac_models/component_01_air_source_heat_pump/coil_load/latent/binned_data[ @type = 'monthly' and index = $monthIndex]/sum" 
					/> 
			</xsl:call-template>
		</xsl:variable>
			
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>
		
		<td><xsl:value-of select="$a" /></td>
		
		<td><xsl:value-of select="$b" /></td>

		<td><xsl:value-of select="$c" /></td>
		
		<td>
			<xsl:if test="$a > 0">
				<xsl:value-of select=" ($a + $b) div $a " />
			</xsl:if>
		</td>
		
		
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: fuel_cell_annual_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays the Annual Fuel Cell information.
		
	=============================================================================
	-->
	<xsl:template match="*" mode="fuel_cell_annual_data">
		<tr class="totalRow">
			
			<!-- Fuel Cell Consumption -->
			<xsl:variable name="a">
				<xsl:call-template name="heatValue">
					<xsl:with-param 
						name="value" 
						select="ideal_hvac_models/component_01_air_source_heat_pump/coil_load/total/binned_data        [ @type = 'annual' ]/sum" 
						/> 
				</xsl:call-template>
			</xsl:variable>
			
			<!-- Electrical generation -->
			<xsl:variable name="b">
				<xsl:call-template name="heatValue">
					<xsl:with-param 
						name="value" 
						select="ideal_hvac_models/component_01_air_source_heat_pump/coil_load/sensible/binned_data [ @type = 'annual' ]/sum" 
						/> 
				</xsl:call-template>
			</xsl:variable>
			
			<!-- Thermal output -->
			<xsl:variable name="c">
				<xsl:call-template name="heatValue">
					<xsl:with-param 
						name="value" 
						select="ideal_hvac_models/component_01_air_source_heat_pump/coil_load/latent/binned_data   [ @type = 'annual' ]/sum" 
						/> 
				</xsl:call-template>
			</xsl:variable>
				
			<th><xsl:call-template name="annual_label" /></th>
			
			<td><xsl:value-of select="$a" /></td>
			
			<td><xsl:value-of select="$b" /></td>
	
			<td><xsl:value-of select="$c" /></td>
			
			<!-- Cogeneration efficiency -->
			<td>
				<xsl:if test="$a > 0">
					<xsl:value-of select=" ($a + $b) div $a " />
				</xsl:if>
			</td>
		
		
		
		</tr>
	</xsl:template>
	
</xsl:stylesheet>