<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="SDHWSection" select="$tplLang/monthly/sections/section[ @name = 'sdhw' ]"  />
	<xsl:variable name="SDHWTemplate" select="$SDHWSection/templates/template[ @name = 'sdhw' ]"  />
	
	<!-- 
	=============================================================================
	
	Template Name: sdhw
	Data Created: MAR.04.2008
	
	Description:
		
		Main template for displaying SDHW Reports.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="sdhw">

		<xsl:apply-templates select="/system/plant" mode="sdhw_monthly" />
	
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: sdhw_monthly
	Data Created: MAR.04.2008
	
	Description:
		
		Displays SDHW information.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="sdhw_monthly">
		<xsl:param name="zone" />
		<xsl:param name="xmlNode" select="." />

    <table>
      <col_group span="7">
        <col align="left"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
      </col_group>
      <tr>
        <th colspan="7">
          <xsl:value-of select="$SDHWSection/title[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="7">
          <p>
            <xsl:value-of select="$SDHWSection/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>

      <tr class="headerRow">
        <td><xsl:call-template name="month_table_header" /></td>

        <td>
          <xsl:value-of select="$SDHWTemplate/headings/avail_solar[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        
        <td>
          <xsl:value-of select="$SDHWTemplate/headings/heat_recovery[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$SDHWTemplate/headings/coll_eff[@xml:lang=$lang]" />
          %
        </td>

        <td>
          <xsl:value-of select="$SDHWTemplate/headings/aux_energy[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$SDHWTemplate/headings/dhw_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$SDHWTemplate/headings/solar_fraction[@xml:lang=$lang]" />
          %
        </td>

      </tr>

      <!-- get data for each month -->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="sdhw_row">
          <xsl:with-param name="monthIndex" select="@id" />
        </xsl:apply-templates>
      </xsl:for-each>


      <!-- Annual data -->
      <tr class="totalRow">
        <td><xsl:call-template name="annual_label" /></td>

        <!--Available solar energy-->
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="//plant/SDHW_summary/available_solar_energy/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        
        <!--Recovered heat-->
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        <!-- collector efficiency-->
        <td>
          <xsl:call-template name="format_percent">
            <xsl:with-param name="value" select="//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual']" />
            <xsl:with-param name="of" select="//plant/SDHW_summary/available_solar_energy/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        <!-- Aux energy input:
             Note: while xpath function number() does not
                   support conversion of null to zero,
                   function sum() does this implicitly. It's
                   used here when adding parameters that may-
                   or may-not be present in the xsl tree.
        -->
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="  sum(//plant/dhw_tank/misc_data/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/collector_pump/misc_data/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/tank_pump/misc_data/energy_input/integrated_data/bin[@type='annual'])" />
          </xsl:call-template>
        </td>

        <!-- Water heater load-->
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="-1 * sum(//plant/mains_water/misc_data/DHW_thermal_load/integrated_data/bin[@type='annual'])" />
          </xsl:call-template>
        </td>

        <!-- Fraction of load met by solar -->
        <td>

       
        
        <xsl:call-template name="format_percent">
            <xsl:with-param name="value" select="//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual']" />
            <xsl:with-param name="of" select="  sum( //plant/dhw_tank/misc_data/energy_input/integrated_data/bin[@type='annual'] )
                                              + sum( //plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual'] )
                                              + sum( //plant/collector_pump/misc_data/energy_input/integrated_data/bin[@type='annual'] )
                                              + sum( //plant/tank_pump/misc_data/energy_input/integrated_data/bin[@type='annual'] )" />
        </xsl:call-template>
        </td>

      </tr>


    </table>

	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: sdhw_row
	Data Created: MAR.04.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="sdhw_row">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="sdhw_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="sdhw_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: sdhw_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays a row of monthly data for the Zone Energy Profile Report.
		
		TAGS USED:
			
			plant/SDHW/Solar_gain	
			plant/SDHW/DHW_tank_elec	
			plant/SDHW/DHW_tank_fule	
			plant/SDHW/pump_elec	
			No tag yet
		
		Note:
			The <td> tags have been seperated into it's own template to allow alternate row colors without duplicating this code.
			
	=============================================================================
	-->
	<xsl:template match="*" mode="sdhw_data">
		<xsl:param name="monthIndex" />
		
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>

    <!--Available solar energy-->
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="//plant/SDHW_summary/available_solar_energy/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>


    <!--Recovered heat-->
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>

    <!-- collector efficiency-->
    <td>
      <xsl:call-template name="format_percent">
        <xsl:with-param name="value" select="//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
        <xsl:with-param name="of" select="//plant/SDHW_summary/available_solar_energy/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>

    <!-- Aux energy input:
          Note: while xpath function number() does not
                support conversion of null to zero,
                function sum() does this implicitly. It's
                used here when adding parameters that may-
                or may-not be present in the xsl tree.
    -->
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="  sum(//plant/dhw_tank/misc_data/energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex])
                                              + sum(//plant/collector_pump/misc_data/energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex])
                                              + sum(//plant/tank_pump/misc_data/energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex])" />
      </xsl:call-template>
    </td>

    <!-- Water heater load-->
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="-1 * sum(//plant/mains_water/misc_data/DHW_thermal_load/integrated_data/bin[@type='monthly' and @number=$monthIndex])" />
      </xsl:call-template>
    </td>

    <!-- Fraction of load met by solar -->
    <td>



    <xsl:call-template name="format_percent">
        <xsl:with-param name="value" select="//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
        <xsl:with-param name="of" select="  sum( //plant/dhw_tank/misc_data/energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex] )
                                          + sum( //plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='monthly' and @number=$monthIndex] )
                                          + sum( //plant/collector_pump/misc_data/energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex] )
                                          + sum( //plant/tank_pump/misc_data/energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex] )" />
    </xsl:call-template>
    </td>

		
		
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: sdhw_annual_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays the Annual SDHW information.
		
	=============================================================================
	-->
	<xsl:template match="*" mode="sdhw_annual_data">
		<tr class="totalRow">
			<th><xsl:call-template name="annual_label" /></th>
			
			<td>
				<xsl:call-template name="heatValue">
					<xsl:with-param name="value" select="Solar_gain/binned_data[@type='annual']/active_average" />
				</xsl:call-template>
			</td>
			
			<td><xsl:value-of select="DHW_tank_elec/adverse/binned_data[@type='annual']/total_average" /></td>
			
			<td>
				<xsl:call-template name="heatValue">
					<xsl:with-param name="value" select="DHW_tank_fuel/binned_data[@type='annual']/sum" />
				</xsl:call-template>
			</td>
			
			<td><xsl:value-of select="DHW_pump_elec/heating/foundation/binned_data[@type='annual']/active_average" /></td>
			<td><xsl:value-of select="'todo'" /></td>
			
		</tr>
	</xsl:template>
	
</xsl:stylesheet>