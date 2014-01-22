<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  
  <xsl:variable name="IHTemplate" select="$EECSection/templates/template[ @name = 'ideal_hvac' ]"  />
  
  
  <!--
  =============================================================================
  
  Template Name: space_heating
  Data Created: MAR.05.2008
  
  Description:
  
    Main template for HVAC Monthly Report.
  
  =============================================================================
  -->
  <xsl:template match="*" mode="ideal_hvac">
    <xsl:param name="xmlNode" select="." />

    <xsl:apply-templates select="plant/ideal_hvac_models/*[ contains( local-name( ), 'component_' ) ]" mode="ideal_hvac_component_data" />

  </xsl:template>

 <!--
      ========================================================
                       Baseboard Table
      ========================================================
   -->

  <xsl:template match="*[ contains( local-name( ), 'baseboard' ) ]"
                mode="ideal_hvac_component_data">

    <xsl:param name="xmlNode" select="." />

    <table>
      <col_group span="4">
        <col align="left"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
      </col_group>
      <tr>
        <th colspan="4">
          <xsl:value-of select="$IHTemplate/baseboard/name[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="4">
          <p>
            <xsl:value-of select="$IHTemplate/baseboard/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>
      <tr class="headerRow">
        <td>Month</td>
        <td>
          <xsl:value-of select="$IHTemplate/baseboard/energy_input[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/baseboard/consumption[@xml:lang=$lang]" />
          <xsl:call-template name="kwhSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/baseboard/part_load_ratio[@xml:lang=$lang]" /> (%)
        </td>
      </tr>


      <!-- get data for each month -->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="row_colour">
          <xsl:with-param name="monthIndex" select="@id" />
          <xsl:with-param name="type" select="'ideal_hvac_baseboard_row'" />
        </xsl:apply-templates>
      </xsl:for-each>

      <!-- get annual data -->
      <tr class="totalRow">
        <td>Annual</td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="fuel_use/energy_input/heating/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
         <td>
          <xsl:call-template name="kWhFormat">
            <xsl:with-param name="value" select="fuel_use/electricity/amount/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="convert_ratio_to_percent">
            <xsl:with-param name="value" select="part_load_ratio/binned_data[@type='annual']/active_average" />
          </xsl:call-template>
        </td>
      </tr>

    </table>

    <br /><br />
  </xsl:template>

  <!-- Baseboard monthly data -->
  <xsl:template match="*" mode="ideal_hvac_baseboard_row">
    <xsl:param name="monthIndex" />
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="fuel_use/energy_input/heating/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
      <td>
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name="value" select="fuel_use/electricity/amount/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="convert_ratio_to_percent">
        <xsl:with-param name="value" select="part_load_ratio/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
      </xsl:call-template>
    </td>
  </xsl:template>



 <!--
      ========================================================
                      Furnace/boiler Table
      ========================================================
   -->

  <xsl:template match="*[ contains( local-name( ), 'furnace' ) or
                          contains( local-name( ), 'boiler' )  ]"
                mode="ideal_hvac_component_data" >
    <xsl:param name="monthIndex" />
    <xsl:param name="xmlNode" select="." />
    <xsl:param name="hvac_type" select="furnace" />
    <!-- Determine if this is a boiler or furnace-->

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

    <xsl:choose>

      <xsl:when test="contains( local-name( ), 'furnace' )" >
        <tr>
          <th colspan="7">
            <xsl:value-of select="$IHTemplate/furnace/name[@xml:lang=$lang]" />
          </th>
        </tr>
        <tr>
          <td colspan="7">
            <p>
              <xsl:value-of select="$IHTemplate/furnace/description[@xml:lang=$lang]" />
            </p>
          </td>
        </tr>
      </xsl:when>

      <xsl:otherwise>
        <tr>
          <th colspan="7">
            <xsl:value-of select="$IHTemplate/boiler/name[@xml:lang=$lang]" />
          </th>
        </tr>
        <tr>
          <td colspan="7">
            <p>
              <xsl:value-of select="$IHTemplate/boiler/description[@xml:lang=$lang]" />
            </p>
          </td>
        </tr>
      </xsl:otherwise>

    </xsl:choose>

      <tr class="headerRow">
        <td>Month</td>
        <td>
          <xsl:value-of select="$IHTemplate/furnace/thermal_output[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/furnace/energy_input[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/furnace/average_efficiency[@xml:lang=$lang]" />
          (%)
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/furnace/part_load_ratio[@xml:lang=$lang]" />
          (%)
        </td>
      </tr>

      <!--get data for each month-->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="row_colour">
          <xsl:with-param name="monthIndex" select="@id" />
          <xsl:with-param name="type" select="'ideal_hvac_furnace_row'" />
        </xsl:apply-templates>
      </xsl:for-each>

      <!--Annual total row-->
      <tr class="totalRow">
        <td>Annual</td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="thermal_output/heating/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="fuel_use/energy_input/heating/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="convert_ratio_to_percent">
            <xsl:with-param name="value" select="efficiency/binned_data[@type='annual']/active_average" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="convert_ratio_to_percent">
             <xsl:with-param name="value" select="part_load_ratio/heating/binned_data[@type='annual']/active_average" /> 
          </xsl:call-template>
        </td>

      </tr>

    </table>

    <br /><br />
  </xsl:template>



  <!-- Monthly data for Furnace -->
  <xsl:template match="*" mode="ideal_hvac_furnace_row">
    <xsl:param name="monthIndex" />
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="thermal_output/heating/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="fuel_use/energy_input/heating/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="convert_ratio_to_percent">
            <xsl:with-param name="value" select="efficiency/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="convert_ratio_to_percent">
            <xsl:with-param name="value" select="part_load_ratio/heating/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
          </xsl:call-template>
        </td>

  </xsl:template>

 <!--
      ========================================================
                          ASHP Table
      ========================================================
   -->

 <xsl:template name="hp_table_format">
    <col_group span="9">
      <col align="left"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
      <col align="right"></col>
    </col_group>
 </xsl:template>

 <xsl:template match="*[ contains( local-name( ), 'air_source_heat_pump' ) ]" mode="ideal_hvac_component_data">
    <xsl:param name="xmlNode" select="." />

    <table>
      <xsl:call-template name="hp_table_format" />
      <tr>
        <th colspan="9">
          <xsl:value-of select="$IHTemplate/air_source_heat_pump/name[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="9">
          <p>
            <xsl:value-of select="$IHTemplate/air_source_heat_pump/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>

      <xsl:apply-templates select="$xmlNode" mode="ideal_hvac_heat_pump_data" />

    </table>

    <br /><br />

  </xsl:template>


<!--
      ========================================================
                          GSHP Table
      ========================================================
   -->


 <xsl:template match="*[ contains( local-name( ), 'ground_source_heat_pump' ) ]" mode="ideal_hvac_component_data">
    <xsl:param name="xmlNode" select="." />

    <table>
      <xsl:call-template name="hp_table_format" />
      <tr>
        <th colspan="9">
          <xsl:value-of select="$IHTemplate/ground_source_heat_pump/name[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="9">
          <p>
            <xsl:value-of select="$IHTemplate/ground_source_heat_pump/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>

      <xsl:apply-templates select="$xmlNode" mode="ideal_hvac_heat_pump_data" />

    </table>

    <br /><br />

  </xsl:template>


  <xsl:template match="*" mode="ideal_hvac_heat_pump_data">
    <xsl:param name="monthIndex" />
    <xsl:param name="xmlNode" select="." />

      <tr class="headerRow">
        <td>Month</td>

        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/heating_total_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/cooling_total_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/cooling_sensible_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/cooling_latent_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/energy_input[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/consumption[@xml:lang=$lang]" />
          <xsl:call-template name="kwhSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/average_COP_heating[@xml:lang=$lang]" /> (-)
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/average_COP_cooling[@xml:lang=$lang]" /> (-)
        </td>
        <!-- Part-load-ratio: not presently reported.
        <td>
          <xsl:value-of select="$IHTemplate/heat_pump/part_load_ratio[@xml:lang=$lang]" /> (%)
        </td>-->
      </tr>

      <!-- get data for each month -->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="row_colour">
          <xsl:with-param name="monthIndex" select="@id" />
          <xsl:with-param name="type" select="'ideal_hvac_hp_row'" />
        </xsl:apply-templates>
      </xsl:for-each>


      <tr class="totalRow">
        <td>Annual</td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="thermal_output/heating/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="coil_load/cooling/total/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="coil_load/cooling/sensible/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="coil_load/cooling/latent/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="fuel_use/energy_input/total/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="kWhFormat">
            <xsl:with-param name="value" select="fuel_use/electricity/amount/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="format_ratio">
            <xsl:with-param name="value" select="COP/heating/binned_data[@type='annual']/active_average" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="format_ratio">
            <xsl:with-param name="value" select="COP/cooling/binned_data[@type='annual']/active_average" />
          </xsl:call-template>
        </td>
<!--    Part-load-ratio: not presently reported.
        <td>
          <xsl:call-template name="convert_ratio_to_percent">
            <xsl:with-param name="value" select="part_load_ratio/binned_data[@type='annual']/active_average" />
          </xsl:call-template>
        </td>-->

      </tr>
      
  </xsl:template>

  <!-- Monthly data for HP -->
  <xsl:template match="*" mode="ideal_hvac_hp_row">
    <xsl:param name="monthIndex" />
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="thermal_output/heating/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="coil_load/cooling/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="coil_load/cooling/sensible/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="coil_load/cooling/latent/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="fuel_use/energy_input/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name="value" select="fuel_use/electricity/amount/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
            <td>
          <xsl:call-template name="format_ratio">
            <xsl:with-param name="value" select="COP/heating/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="format_ratio">
            <xsl:with-param name="value" select="COP/cooling/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
          </xsl:call-template>
        </td>
<!-- Part-load-ratio: not presently reported.
    <td>
      <xsl:call-template name="convert_ratio_to_percent">
        <xsl:with-param name="value"
                        select="part_load_ratio/binned_data[@type='monthly' and index=$monthIndex]/active_average"
        />
      </xsl:call-template>
    </td>-->
  </xsl:template>


<!--
      ========================================================
                          Fans & ventilation 
      ========================================================
   -->


 <xsl:template match="*" mode="circulation_ventilation">
    <xsl:param name="xmlNode" select="." />

    <table>

      <col_group span="9">
          <col align="left"></col>
          <col align="right"></col>
          <col align="right"></col>
          <col align="right"></col>
          <col align="right"></col>
          <col align="right"></col>
          <col align="right"></col>
          <col align="right"></col>
          <col align="right"></col>
        </col_group>

      <tr>
        <th colspan="9">
          <xsl:value-of select="$IHTemplate/ventilation/name[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="9">
          <p>
            <xsl:value-of select="$IHTemplate/ventilation/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>


      <tr class="headerRow">
        <td>Month</td>

        <td>
          <xsl:value-of select="$IHTemplate/ventilation/circ_fan_heat_gain[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/ventilation/circ_fan_consumption[@xml:lang=$lang]" />
          <xsl:call-template name="kwhSuffix" />
        </td>
        <td>
          <xsl:value-of select="$IHTemplate/ventilation/vent_fan_consumption[@xml:lang=$lang]" />
          <xsl:call-template name="kwhSuffix" />
        </td>

      </tr>

      <!-- get data for each month -->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="row_colour">
          <xsl:with-param name="monthIndex" select="@id" />
          <xsl:with-param name="type" select="'ideal_hvac_fans_row'" />
        </xsl:apply-templates>
      </xsl:for-each>


      <tr class="totalRow">
        <td>Annual</td>
        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="plant/ideal_hvac_models/circulation_fans/heat_transfer/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="kWhFormat">
            <xsl:with-param name="value" select="plant/ideal_hvac_models/circulation_fans/fuel_use/electricity/amount/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
        <td>
          <xsl:call-template name="kWhFormat">
            <xsl:with-param name="value" select="plant/ideal_hvac_models/HRV/elec_load/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>
      </tr>

    </table>

    <br /><br />

  </xsl:template>

  
  <xsl:template match="*" mode="ideal_hvac_fans_row">
    <xsl:param name="monthIndex" />
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value"
                        select="plant/ideal_hvac_models/circulation_fans/heat_transfer/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name="value"
                        select="plant/ideal_hvac_models/circulation_fans/fuel_use/electricity/amount/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
    <td>
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name="value"
                        select="plant/ideal_hvac_models/HRV/elec_load/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>
    </td>
  </xsl:template>

  
 <!--
      ========================================================
        Monthly row: this template calls the appropriate
                     subordinate 'row' template to populate
                     a monthly table row depending on
                     the value of the type varaible (that is,
                     the type of HVAC system)
      ========================================================
   -->


  <!-- Switch according to hvac type -->
  <xsl:template match="*" mode="ideal_hvac_switch">
    <xsl:param name="monthIndex" />
    <xsl:param name="type" />
    <th>
      <xsl:call-template name="month_name">
        <xsl:with-param name="index" select="$monthIndex" />
      </xsl:call-template>
    </th>
    <xsl:choose>
      <xsl:when test="$type = 'ideal_hvac_baseboard_row' " >
        <xsl:apply-templates select="." mode="ideal_hvac_baseboard_row">
          <xsl:with-param name="monthIndex" select="$monthIndex" />
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$type = 'ideal_hvac_furnace_row' " >
        <xsl:apply-templates select="." mode="ideal_hvac_furnace_row">
          <xsl:with-param name="monthIndex" select="$monthIndex" />
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$type = 'ideal_hvac_hp_row' " >
        <xsl:apply-templates select="." mode="ideal_hvac_hp_row">
          <xsl:with-param name="monthIndex" select="$monthIndex" />
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$type = 'ideal_hvac_fans_row' " >
        <xsl:apply-templates select="." mode="ideal_hvac_fans_row">
          <xsl:with-param name="monthIndex" select="$monthIndex" />
        </xsl:apply-templates>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

 <!--
      ========================================================
        Row colours: this template switches between white
                     and grey row colours.
      ========================================================
   -->

  <!-- alternate row colours -->
  <xsl:template match="*" mode="row_colour">
    <xsl:param name="monthIndex" />
    <xsl:param name="type" />
    <xsl:choose>
      <xsl:when test="$monthIndex mod 2 = 0">
        <tr class="row">
          <xsl:apply-templates select="." mode="ideal_hvac_switch">
            <xsl:with-param name="monthIndex" select="$monthIndex" />
            <xsl:with-param name="type" select="$type" />
          </xsl:apply-templates>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr class="altRow">
          <xsl:apply-templates select="." mode="ideal_hvac_switch">
            <xsl:with-param name="monthIndex" select="$monthIndex" />
            <xsl:with-param name="type" select="$type" />
          </xsl:apply-templates>
        </tr>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


</xsl:stylesheet>
