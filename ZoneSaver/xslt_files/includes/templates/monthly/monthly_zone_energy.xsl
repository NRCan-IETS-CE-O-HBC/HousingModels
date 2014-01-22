<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="MZESection" select="$tplLang/monthly/sections/section[ @name = 'zep' ]"  />
	<xsl:variable name="MZETemplate" select="$MZESection/templates/template[ @name = 'zone_energy' ]"  />
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: all_zones_energy_profile
	Data Created: MAR.04.2008
	
	Description:
		
		Main template for display Monthly Zone Energy Profiles.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="all_zones_energy_profile">
		
		<!-- Template Heading -->
		<h1><xsl:value-of select="$MZESection/heading[@xml:lang=$lang]" /></h1>

		<xsl:apply-templates select="/system/building/*[ contains( local-name( ), 'zone_' ) ]" mode="zone_energy_profile" />
		
		<br/>
		<br/>
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: zone_energy_profile
	Data Created: MAR.04.2008
	
	Description:
		
		Displays energy information about a single zone.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="zone_energy_profile">
  
		<xsl:param name="zoneNumber" select=" substring-after( local-name( ) , '_' ) " />
		<xsl:param name="zoneLabel" select=" concat( $tplLang/zone[@xml:lang=$lang], ' ', $zoneNumber ) " />
		<xsl:param name="xmlNode" select="." />


		<table border="0" cellspacing="0" class="monthly_report">
    <col_group span="8">
      <col align="left"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
    </col_group>
			
			<!-- Zone Heading -->
			<tr><th colspan="7" align ="left"><xsl:value-of select="$zoneLabel" /></th></tr>

			<!-- Table Headings -->
			<tr class="headerRow">
				
				<th><xsl:call-template name="month_table_header" /></th>
				
				<th>
					<xsl:value-of select="$MZETemplate/headings/avg_temp[@xml:lang=$lang]" />
					<xsl:call-template name="tempSuffix" />
				</th>

				<th>
					<xsl:value-of select="$MZETemplate/headings/int_gains[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$MZETemplate/headings/solar_gains[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>

        <th>
          <xsl:value-of select="$MZETemplate/headings/heat_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </th>

        <th>
          <xsl:value-of select="$MZETemplate/headings/heating[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </th>

				<th>
					<xsl:value-of select="$MZETemplate/headings/cool_load[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>

				<th>
					<xsl:value-of select="$MZETemplate/headings/cooling[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
			</tr>
			
			<!--  Loop through months and display output. -->
			<xsl:for-each select="$tplLang/months/month">
				<xsl:apply-templates select="$xmlNode" mode="zone_energy_row">
					<xsl:with-param name="monthIndex" select="@id" />
				</xsl:apply-templates>
			</xsl:for-each>
		
		
			<!-- ANNUAL -->
			<xsl:apply-templates select="." mode="zone_energy_annual_data" />
		
		</table>
		<br/>
		
	</xsl:template>
	
 
	<!-- 
	=============================================================================
	
	Template Name: zone_energy_row
	Data Created: MAR.04.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="zone_energy_row">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="zone_energy_monthly_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="zone_energy_monthly_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: zone_energy_monthly_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays a row of monthly data for the Zone Energy Profile Report.
		
		TAGS USED:
			
			air_point/temperature/binned_data[@type='monthly' and index=$monthIndex]/active_average
			internal_gains/adverse/binned_data[@type='monthly' and index=$monthIndex]/total_average
			insolation/adverse/binned_data[@type='monthly' and index=$monthIndex]/sum
			thermal_loads/heating/foundation/binned_data[@type='monthly' and index=$monthIndex]/active_average
			supplied_energy/heating/binned_data[@type='monthly' and index=$monthIndex]/active_average
			supplied_energy/cooling/binned_data[@type='monthly' and index=$monthIndex]/active_average
		
		Note:
			The <td> tags have been seperated into it's own template to allow alternate row colors without duplicating this code.
			
	=============================================================================
	-->
	<xsl:template match="*" mode="zone_energy_monthly_data">
		<xsl:param name="monthIndex" />
		
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>
		
		<td>
			<xsl:call-template name="tempFormat">
				<xsl:with-param name="value" select="air_point/temperature/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
			</xsl:call-template>
		</td>
		<td>
			<xsl:call-template name="heatFormat">
				<xsl:with-param name="value" select="internal_gains/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
			</xsl:call-template>
		</td>
		<td>
			<xsl:call-template name="heatFormat">
				<xsl:with-param name="value" select="insolation/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
			</xsl:call-template>
		</td>
		<td>
			<xsl:call-template name="heatFormat">
				<xsl:with-param name="value" select="thermal_loads/heating/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
			</xsl:call-template>
		</td>
		<td>
			<xsl:call-template name="heatFormat">
				<xsl:with-param name="value" select="supplied_energy/heating/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
			</xsl:call-template>
		</td>
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="thermal_loads/cooling/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    
		<td>
			<xsl:call-template name="heatFormat">
				<xsl:with-param name="value" select="supplied_energy/cooling/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
			</xsl:call-template>
		</td>
		
		
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: zone_energy_annual_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays the Annual Zone Energy Profile information.
		
	=============================================================================
	-->
	<xsl:template match="*" mode="zone_energy_annual_data">
		<tr class="totalRow">
			<th><xsl:call-template name="annual_label" /></th>
			<td>
				<xsl:call-template name="tempFormat">
					<xsl:with-param name="value" select="air_point/temperature/binned_data[@type='annual']/active_average" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="heatFormat">
					<xsl:with-param name="value" select="internal_gains/total/integrated_data/bin[@type='annual']" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="heatFormat">
					<xsl:with-param name="value" select="insolation/total/integrated_data/bin[@type='annual']" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="heatFormat">
					<xsl:with-param name="value" select="thermal_loads/heating/total/integrated_data/bin[@type='annual']" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:call-template name="heatFormat">
					<xsl:with-param name="value" select="supplied_energy/heating/integrated_data/bin[@type='annual']" />
				</xsl:call-template>
			</td>
      <td>
        <xsl:call-template name="heatFormat">
          <xsl:with-param name="value" select="thermal_loads/cooling/total/integrated_data/bin[@type='annual']" />
        </xsl:call-template>
      </td>
			<td>
				<xsl:call-template name="heatFormat">
					<xsl:with-param name="value" select="supplied_energy/cooling/integrated_data/bin[@type='annual']" />
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>