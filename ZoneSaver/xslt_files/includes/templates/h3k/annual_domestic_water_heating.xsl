<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="ADWHTemplate" select="$tplLang/h3k/templates/template[ @name = 'annual_domestic_water_heating' ]"  />
	
	
	<xsl:template match="*" mode="annual_domestic_water_heating">
		
		<h1><xsl:value-of select="$ADWHTemplate/title[@xml:lang=$lang]" /></h1>
		
		<xsl:apply-templates select="/system/plant/ideal_DHW_model" mode="adhw_data" />
    <xsl:apply-templates select="/system/plant/mains_water" mode="adhw_data" />
	  
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: adhw_data
	Data Created: MAR.06.2008
	
	Description:
		
		plant/ideal_DHW_model/water_draw
		plant/ideal_DHW_model/delivery_temperature/average
		plant/ideal_DHW_model/supply_temperature/average
		plant/ideal_DHW_model/water_heating_load
		plant/ideal_DHW_model/energy_input

		
	
	=============================================================================
	-->
	<xsl:template match="*" mode="adhw_data">

		<table cellspacing="0">
		  <col_group span="2">
        <col align="left"></col>
        <col align="right"></col>
      </col_group>
			<!-- DAILY HOT WATER -->
			<tr class="row">
				<th> <xsl:value-of select="$ADWHTemplate/headings/daily_hot_water[@xml:lang=$lang]" />	</th>
				<td> 
					<xsl:call-template name="liquidVolumeFormat">
						<xsl:with-param name="value" select="sum(/system/plant/ideal_DHW_model/water_draw/integrated_data/bin[@type='annual'])
                                                 + sum(/system/plant/mains_water/node_1/water_flow/integrated_data/bin[@type='annual']) " />
					</xsl:call-template>
					<xsl:call-template name="liquidVolumeSuffixNoBrackets" />
				</td>
			</tr>
			
			<!-- HOT WATER DELIVERY TEMP -->
			<tr class="altRow">
				<th><xsl:value-of select="$ADWHTemplate/headings/hot_water_delivery_temp[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="tempFormat">
						<xsl:with-param name="value" select="sum(/system/plant/ideal_DHW_model/delivery_temperature/binned_data[@type='annual']/active_average)
                                                  + sum(/system/plant/mains_water/node_1/connection_1/temperature/binned_data[@type='annual']/active_average)" />
					</xsl:call-template>
					<xsl:call-template name="tempSuffixNoBrackets" /> 
				</td>
			</tr>
			
			<!-- MAKEUP WATER TEMP -->
			<tr class="row">
				<th><xsl:value-of select="$ADWHTemplate/headings/makeup_water_temp[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="tempFormat">
						<xsl:with-param name="value" select="sum(/system/plant/ideal_DHW_model/supply_temperature/binned_data[@type='annual']/active_average)
                                                  + sum(/system/plant/mains_water/node_1/temperature/binned_data[@type='annual']/active_average)" />
					</xsl:call-template>
					<xsl:call-template name="tempSuffixNoBrackets" /> 
				</td>
			</tr>
			
			<!-- ESTIMATED DOMESTIC WATER HEAT -->
			<tr class="altRow">
				<th><xsl:value-of select="$ADWHTemplate/headings/est_domestic_water_heat[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="sum(/system/plant/ideal_DHW_model/water_heating_load/integrated_data/bin[@type='annual'])
                                                  + -1.0*sum(/system/plant/mains_water/misc_data/DHW_thermal_load/integrated_data/bin[@type='annual'])" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" /> 
				</td>
			</tr>
			
			<!-- PRIMARY DOMESTIC WATER HEAT -->
			<tr class="row">
				<th><xsl:value-of select="$ADWHTemplate/headings/primary_domestic_water_heat[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="sum(/system/plant/ideal_DHW_model/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/dhw_tank/misc_data/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/collector_pump/misc_data/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/tank_pump/misc_data/energy_input/integrated_data/bin[@type='annual'])" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" /> 
				</td>
			</tr>

      <!-- Supplemental solar energy -->
      <tr class="altRow">
        <th><xsl:value-of select="$ADWHTemplate/headings/solar_energy[@xml:lang=$lang]" /></th>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="sum(//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual'])" />
          </xsl:call-template>
          <xsl:call-template name="heatSuffixNoBrackets" />
        </td>
      </tr>

      <!-- Solar fraction -->
      <tr class="row">
        <th><xsl:value-of select="$ADWHTemplate/headings/solar_fraction[@xml:lang=$lang]" /></th>
        <td>
          <xsl:call-template name="format_percent">
            <xsl:with-param name="value" select="sum(//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual'])" />

            <xsl:with-param name="of" select="sum(//plant/SDHW_summary/recovered_heat/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_DHW_model/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/dhw_tank/misc_data/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/collector_pump/misc_data/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(//plant/tank_pump/misc_data/energy_input/integrated_data/bin[@type='annual'])" />
          </xsl:call-template>

        </td>
      </tr>

			
		</table>
		
		<br />
		
	</xsl:template>
	
	
</xsl:stylesheet>