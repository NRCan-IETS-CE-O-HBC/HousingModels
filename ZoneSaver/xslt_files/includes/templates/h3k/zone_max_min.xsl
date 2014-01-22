<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="ZMMTemplate" select="$tplLang/h3k/templates/template[ @name = 'zone_max_min' ]"  />
	
	
	<xsl:template match="*" mode="zone_max_min">
		
		<h1><xsl:value-of select="$ZMMTemplate/title[@xml:lang=$lang]" /></h1>
		
		<table cellspacing="0">
		  <col_group span="5">
        <col align="left"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
      </col_group>
			<xsl:call-template name="zone_max_min_header" />
			
			<!-- LOOP ZONES -->
			<xsl:apply-templates select="/system/building/*[ contains( name( ), 'zone_' ) ]" mode="zone_max_min_data" />
	
		</table>
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: zone_max_min_header
	Data Created: MAR.06.2008
	
	Description:
				
		Displays the header row for the Zone Max Min Report.
	
	=============================================================================
	-->
	<xsl:template name="zone_max_min_header">
		<tr class="headerRow">
			<th><xsl:value-of select="$tplLang/zone[ @xml:lang= $lang ]" /></th>
			<th>
				<xsl:value-of select="$ZMMTemplate/headings/max_heat[ @xml:lang= $lang ]" />
				<xsl:call-template name="wattsSuffix" />
			</th>
			<th>
				<xsl:value-of select="$ZMMTemplate/headings/max_cool[ @xml:lang= $lang ]" />
				<xsl:call-template name="wattsSuffix" />
			</th>
			<th>
				<xsl:value-of select="$ZMMTemplate/headings/max_temp[ @xml:lang= $lang ]" />
				<xsl:call-template name="tempSuffix" />
			</th>
			<th>
				<xsl:value-of select="$ZMMTemplate/headings/min_temp[ @xml:lang= $lang ]" />
				<xsl:call-template name="tempSuffix" />
			</th>
		</tr>
	</xsl:template>
	
	<!-- 
	=============================================================================
	
	Template Name: zone_max_min_data
	Data Created: MAR.06.2008
	
	Description:
				
		A: supplied_energy/heating/max
		B: supplied_energy/cooling/max
		C: air_point/temperature/max
		D: air_point/temperature/min

	
	=============================================================================
	-->
	<xsl:template match="*" mode="zone_max_min_data">
		<xsl:param name="zoneNumber" select=" substring-after( local-name( ) , '_' ) " />
		<xsl:param name="zoneLabel" select=" concat( $tplLang/zone[@xml:lang=$lang], ' ', $zoneNumber ) " />
    <xsl:choose>
      <xsl:when test="$zoneNumber mod 2 = 0">
        <tr class="altow">
          <xsl:apply-templates select="." mode="zone_data_row">
            <xsl:with-param name="zoneLabel" select="$zoneLabel" />
          </xsl:apply-templates>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr class="row">
          <xsl:apply-templates select="." mode="zone_data_row">
            <xsl:with-param name="zoneLabel" select="$zoneLabel" />
          </xsl:apply-templates>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="zone_data_row">
    <xsl:param name="zoneLabel" />
			<th><xsl:value-of select="$zoneLabel" /></th>
			<td><xsl:call-template name="kWhFormat">
			       <xsl:with-param name="value" select="supplied_energy/heating/binned_data[@type='annual']/max" />
                            </xsl:call-template> 
			</td>
                            <td><xsl:call-template name="kWhFormat">
                            <xsl:with-param name="value" select="supplied_energy/cooling/binned_data[@type='annual']/max" />
                            </xsl:call-template>
			</td>
			<td> <xsl:call-template name="tempFormat">
				<xsl:with-param name="value" select="air_point/temperature/binned_data[@type='annual']/max" />
			</xsl:call-template> </td>
			<td> <xsl:call-template name="tempFormat">
				<xsl:with-param name="value" select="air_point/temperature/binned_data[@type='annual']/min" />
			</xsl:call-template> </td>
		
	</xsl:template>
	
	
</xsl:stylesheet>