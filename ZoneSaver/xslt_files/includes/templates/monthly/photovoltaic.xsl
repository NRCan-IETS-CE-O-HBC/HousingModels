<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="PVSection" select="$tplLang/monthly/sections/section[ @name = 'pv' ]"  />
	<xsl:variable name="PVTemplate" select="$PVSection/templates/template[ @name = 'pv' ]"  />
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: pv
	Data Created: MAR.04.2008
	
	Description:
		
		Main template for displaying Photovoltaic Reports.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="pv">

		
		<xsl:apply-templates select="/system/climate" mode="pv_monthly" />
	
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: pv_monthly
	Data Created: MAR.04.2008
	
	Description:
		
		Displays Photovoltaic information.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="pv_monthly">
		<xsl:param name="zone" />
		<xsl:param name="xmlNode" select="." />

    <table>
      <col_group span="6">
        <col align="left"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
      </col_group>
      <tr>
        <th colspan="6">
          <xsl:value-of select="$PVTemplate/title[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="6">
          <p>
            <xsl:value-of select="$PVTemplate/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>
      <tr class="headerRow">
        <td><xsl:call-template name="month_table_header" /></td>
        <td>
          <xsl:value-of select="$PVTemplate/headings/air_temp[@xml:lang=$lang]" />
          <xsl:call-template name="tempSuffix" />
        </td>
        <td>
          <xsl:value-of select="$PVTemplate/headings/solar_tilted[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$PVTemplate/headings/gross_generation[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$PVTemplate/headings/inverter_loss[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>
        <td>
          <xsl:value-of select="$PVTemplate/headings/net_generation[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>        
      </tr>

      <!-- get data for each month -->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="pv_row_colour">
          <xsl:with-param name="monthIndex" select="@id" />
        </xsl:apply-templates>
      </xsl:for-each> 





      <tr class="totalRow">
        <td><xsl:call-template name="annual_label" /></td>

        <td>
          <xsl:call-template name="tempFormat">
            <xsl:with-param name="value" select="//climate/dry_bulb_temperature/binned_data[@type='annual']/total_average" />
          </xsl:call-template>
        </td>
        <!-- solar radiation on PV surface -->
        <td>
         <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="//building/spmatl/pv-array/misc_data/total_incident_irradiance/total/integrated_data/bin[@type='annual']" />
          </xsl:call-template>

        </td>
        <!-- PV generation -->
        <td>

          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="//electrical_net/nodes/node_001/generation/real/integrated_data/bin[@type='annual']" />
          </xsl:call-template>

        </td>



        <td>

          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="//electrical_net/power_only_components/DC-AC-inv/misc_data/PCU_power_loss/integrated_data/bin[@type='annual']" />
          </xsl:call-template>

        </td>

        <td>

          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="//electrical_net/nodes/node_002/generation/real/integrated_data/bin[@type='annual']" />
          </xsl:call-template>

        </td>


      </tr>
      
    </table>

    <br /><br />
  </xsl:template>
 
	<!-- 
	=============================================================================
	
	Template Name: pv_row
	Data Created: MAR.04.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="pv_row_colour">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="pv_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="pv_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: pv_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays a row of monthly data for the Photovoltaic Report.
		
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
	<xsl:template match="*" mode="pv_data">
		<xsl:param name="monthIndex" />
	
		<td>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</td>
    
    <td>
      <xsl:call-template name="tempFormat">
        <xsl:with-param name="value" select="//climate/dry_bulb_temperature/binned_data[@type='monthly' and index=$monthIndex]/total_average" />
      </xsl:call-template>
    </td>
    <!-- solar radiation on PV surface -->
    <td>
      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="//building/spmatl/pv-array/misc_data/total_incident_irradiance/total/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>

    </td>
    <!-- PV generation -->
    <td>

      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="//electrical_net/nodes/node_001/generation/real/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>

    </td>



    <td>

      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="//electrical_net/power_only_components/DC-AC-inv/misc_data/PCU_power_loss/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>

    </td>

    <td>

      <xsl:call-template name="heatFormat">
        <xsl:with-param name="value" select="//electrical_net/nodes/node_002/generation/real/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
      </xsl:call-template>

    </td>

	</xsl:template>
	
	
</xsl:stylesheet>