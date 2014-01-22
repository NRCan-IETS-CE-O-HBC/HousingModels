<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="QRTemplate" select="$tplLang/h3k/templates/template[ @name = 'annual_quick_run' ]"  />
	
	
	<xsl:template match="*" mode="annual_quick_run">
		
		
		<xsl:apply-templates select="/system/plant/ideal_DHW_model" mode="quickrun_data" />
  
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: quickrun_data
	Data Created: OCT.01.2009
	
	Description:
		
    This stylesheet sums all the energy used by the end-uses and reports the total.
        
        
        
	=============================================================================
	-->
	<xsl:template match="*" mode="quickrun_data">

		<table cellspacing="0">
		  <col_group span="2">
        <col align="left"></col>
        <col align="right"></col>
      </col_group>

			          
            
			<!-- TOTAL -->
			<tr class="row">

				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="sum(/system/plant/ideal_DHW_model/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/circulation_fans/fuel_use/energy_input/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/HRV/elec_load/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_boiler/fuel_use/amount/auxiliaries/integrated_data/bin[@type='annual']) 
                                                  + sum(/system/plant/ideal_hvac_models/component_01_boiler/fuel_use/energy_input/heating/integrated_data/bin[@type='annual']) 
                                                  + sum(/system/plant/ideal_hvac_models/component_01_boiler/fuel_use/energy_input/cooling/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_boiler/fuel_use/energy_input/pilot/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_furnace/fuel_use/amount/auxiliaries/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_furnace/fuel_use/energy_input/heating/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_furnace/fuel_use/energy_input/cooling/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_furnace/fuel_use/energy_input/pilot/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_02_air_source_heat_pump/fuel_use/energy_input/heating/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_02_air_source_heat_pump/fuel_use/energy_input/cooling/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_02_ground_source_heat_pump/fuel_use/energy_input/heating/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_02_ground_source_heat_pump/fuel_use/energy_input/cooling/integrated_data/bin[@type='annual'])
                                                  + sum(/system/plant/ideal_hvac_models/component_01_baseboard/fuel_use/energy_input/heating/integrated_data/bin[@type='annual'])                                                                                              
                                                  + sum(/system/building/all_zones/lighting_power/total/integrated_data/bin[@type='annual'])
                                                  + sum(/system/building/all_zones/equipment_power/total/integrated_data/bin[@type='annual'])" />                                                                                                                                                 
                                                  
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" /> 
				</td>
			</tr>
            
			
		</table>
		
		<br />
		
	</xsl:template>
	
	
</xsl:stylesheet>