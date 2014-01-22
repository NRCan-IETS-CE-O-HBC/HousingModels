<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="DHWTemplate" select="$EECSection/templates/template[ @name = 'dhw' ]"  />
	
	
	<!-- 
	=============================================================================
	
	Template Name: dhw
	Data Created: MAR.05.2008
	
	Description:
		
		Main template for the DHW Report.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="dhw">
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
          <xsl:value-of select="$DHWTemplate/title[@xml:lang=$lang]" />
        </th>
      </tr>
      <tr>
        <td colspan="9">
          <p>
            <xsl:value-of select="$DHWTemplate/description[@xml:lang=$lang]" />
          </p>
        </td>
      </tr>


      <tr class="headerRow">
        <td><xsl:call-template name="month_table_header" /></td>


        <td>
          <xsl:value-of select="$DHWTemplate/water_draw[@xml:lang=$lang]" />
          <xsl:call-template name="liquidVolumeSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/avg_sup_temp[@xml:lang=$lang]" />
          <xsl:call-template name="tempSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/avg_del_temp[@xml:lang=$lang]" />
          <xsl:call-template name="tempSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/water_heating_load[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/actual_heat_gen[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/flue_loss[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/skin_loss[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

        <td>
          <xsl:value-of select="$DHWTemplate/energy_input[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </td>

      </tr>

      <!-- get data for each month -->
      <xsl:for-each select="$tplLang/months/month">
        <xsl:apply-templates select="$xmlNode" mode="dhw_row_colour">
          <xsl:with-param name="monthIndex" select="@id" />
        </xsl:apply-templates>
      </xsl:for-each> 


      <tr class="totalRow">
        <td><xsl:call-template name="annual_label" /></td>


        <td>
          <xsl:call-template name="liquidVolumeFormat">
            <xsl:with-param name="value" select="water_draw/integrated_data/bin[@type='annual']" />
          </xsl:call-template>

        </td>

        <td>
          <xsl:call-template name="tempFormat">
            <xsl:with-param name="value" select="supply_temperature/binned_data[@type='annual']/active_average" />
          </xsl:call-template>

        </td>

        <td>
          <xsl:call-template name="tempFormat">
            <xsl:with-param name="value" select="delivery_temperature/binned_data[@type='annual']/active_average" />
          </xsl:call-template>

        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="water_heating_load/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="burner_heat_output/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="flue_loss/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="skin_loss/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="energy_input/integrated_data/bin[@type='annual']" />
          </xsl:call-template>
        </td>

      </tr>
    </table>

    <br /><br />

		

	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: dhw_row
	Data Created: MAR.04.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="dhw_row_colour">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row"> 
					<xsl:apply-templates select="." mode="dhw_row_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="dhw_row_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: dhw_data
	Data Created: MAR.04.2008
	
	Description:
		
		Displays a row of monthly data for the DHW Report.
		
		TAGS USED: 
			
			== TODO ==
			
					
	=============================================================================
	-->
	<xsl:template match="*" mode="dhw_row_data">
		<xsl:param name="monthIndex" />
		
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>

        <td>
          <xsl:call-template name="liquidVolumeFormat">
            <xsl:with-param name="value" select="water_draw/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>

        </td>

        <td>
          <xsl:call-template name="tempFormat">
            <xsl:with-param name="value" select="supply_temperature/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
          </xsl:call-template>

        </td>

        <td>
          <xsl:call-template name="tempFormat">
            <xsl:with-param name="value" select="delivery_temperature/binned_data[@type='monthly' and index=$monthIndex]/active_average" />
          </xsl:call-template>

        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="water_heating_load/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="burner_heat_output/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="flue_loss/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="skin_loss/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>

        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="energy_input/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
          </xsl:call-template>
        </td>

	</xsl:template>

	
</xsl:stylesheet>