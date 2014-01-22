<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="AFCTemplate" select="$tplLang/h3k/templates/template[ @name = 'est_annual_fuel_consumption' ]"  />
	
	
	<xsl:template match="*" mode="est_annual_fuel_consumption">
		
		<h1><xsl:value-of select="$AFCTemplate/title[@xml:lang=$lang]" /></h1>
		
		<xsl:apply-templates select="/system/total_fuel_use" mode="est_annual_fuel_consumption_data" />

	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: est_annual_fuel_consumption_data
	Data Created: MAR.06.2008
	
	Description:
				
		A: total_fuel_use/natural_gas/space_heating/quantity
		B: total_fuel_use/natural_gas/water_heating/quantity
		D: total_fuel_use/natural_gas/all_end_uses/quantity
		E: total_fuel_use/oil/space_heating/quantity
		G: total_fuel_use/oil/water_heating/quantity
		H: total_fuel_use/oil/all_end_uses/quantity
		I: total_fuel_use/propane/space_heating/quantity
		J: total_fuel_use/propane/water_heating/quantity
		K: total_fuel_use/propane/all_end_uses/quantity
		L: total_fuel_use/mixed_wood/space_heating/quantity
		M: total_fuel_use/mixed_wood/water_heating/quantity
		N: total_fuel_use/mixed_wood/all_end_uses/quantity
		O: total_fuel_use/electricity/space_heating/quantity
		P: total_fuel_use/electricity/space_cooling/quantity
		Q: total_fuel_use/electricity/water_heating/quantity
		R: total_fuel_use/electricity/ventilation/quantity
		S: total_fuel_use/electricity/all_end_uses/quantity
			
		
	
	=============================================================================
	-->
	<xsl:template match="*" mode="est_annual_fuel_consumption_data">
	
		<!-- m3 -->
		<xsl:variable name="A">
			<xsl:call-template name="cubicSizeFormat">
				<xsl:with-param name="value" select="natural_gas/space_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="B">
			<xsl:call-template name="cubicSizeFormat">
				<xsl:with-param name="value" select="sum(natural_gas/water_heating/quantity/integrated_data/bin[@type='annual'])
                                             +sum(natural_gas/uncatagorized/quantity/integrated_data/bin[@type='annual'])" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="D">
			<xsl:call-template name="cubicSizeFormat">
				<xsl:with-param name="value" select="natural_gas/all_end_uses/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		
		<!-- L -->
		<xsl:variable name="E">
			<xsl:call-template name="liquidVolumeFormat">
				<xsl:with-param name="value" select="oil/space_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="G">
			<xsl:call-template name="liquidVolumeFormat">
				<xsl:with-param name="value" select="oil/water_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="H">
			<xsl:call-template name="liquidVolumeFormat">
				<xsl:with-param name="value" select="oil/all_end_uses/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- L -->
		<xsl:variable name="I">
			<xsl:call-template name="liquidVolumeFormat">
				<xsl:with-param name="value" select="propane/space_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="J">
			<xsl:call-template name="liquidVolumeFormat">
				<xsl:with-param name="value" select="propane/water_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="K">
			<xsl:call-template name="liquidVolumeFormat">
				<xsl:with-param name="value" select="propane/all_end_uses/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- Tonne -->
		<xsl:variable name="L">
			<xsl:call-template name="massFormat">
				<xsl:with-param name="value" select="mixed_wood/space_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="M">
			<xsl:call-template name="massFormat">
				<xsl:with-param name="value" select="mixed_wood/water_heating/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="N">
			<xsl:call-template name="massFormat">
				<xsl:with-param name="value" select="mixed_wood/all_end_uses/quantity/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>
		
		<!-- Kwh -->
    
		<xsl:variable name="O">
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name ="value" select="electricity/space_heating/quantity/integrated_data/bin[@type='annual']" />
      </xsl:call-template>
    </xsl:variable>
		<xsl:variable name="P">
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name ="value" select="electricity/space_cooling/quantity/integrated_data/bin[@type='annual']" />
      </xsl:call-template>
    </xsl:variable>
    <!-- electric power for DHW: includes uncatagorized energy consumption
         reported from plant domain -->
    <xsl:variable name="Q">
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name ="value" select="sum(electricity/water_heating/quantity/integrated_data/bin[@type='annual'])
                                              +sum(electricity/uncatagorized/quantity/integrated_data/bin[@type='annual'])" />
		  </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="R">
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name ="value" select="electricity/ventilation/quantity/integrated_data/bin[@type='annual']" />
		  </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="S">
      <xsl:call-template name="kWhFormat">
        <xsl:with-param name ="value" select="electricity/all_end_uses/quantity/integrated_data/bin[@type='annual']" />
		  </xsl:call-template>
    </xsl:variable>
    
		<table cellspacing="0">
			<colgroup span="6">
        <col align="left"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
        <col align="right"></col>
      </colgroup>

      <tr class="headerRow">
        <th><xsl:value-of select="$AFCTemplate/headings/end_uses/label[ @xml:lang= $lang ]" />
        </th>
        <th><xsl:value-of select="$AFCTemplate/headings/fuels/natural_gas[ @xml:lang= $lang ]" />
            <xsl:call-template name="cubicSizeSuffix" />
        </th>
        <th><xsl:value-of select="$AFCTemplate/headings/fuels/oil[ @xml:lang= $lang ]" />
            <xsl:call-template name="liquidVolumeSuffix" />
        </th>
        <th><xsl:value-of select="$AFCTemplate/headings/fuels/propane[ @xml:lang= $lang ]" />
            <xsl:call-template name="liquidVolumeSuffix" />
        </th>
        <th><xsl:value-of select="$AFCTemplate/headings/fuels/mixed_wood[ @xml:lang= $lang ]" />
            <xsl:call-template name="massSuffix" />
        </th>
        <th><xsl:value-of select="$AFCTemplate/headings/fuels/electricity[ @xml:lang= $lang ]" />
            <xsl:call-template name="kwhSuffix"/>
        </th>
      </tr>

      <tr class="row">
        <th>
          <xsl:value-of select="$AFCTemplate/headings/end_uses/space_heating[ @xml:lang= $lang ]" />
        </th>
        <td> <xsl:value-of select="$A" /> </td>
        <td> <xsl:value-of select="$E" /> </td>
        <td> <xsl:value-of select="$I" /> </td>
        <td> <xsl:value-of select="$L" /> </td>
        <td> <xsl:value-of select="$O" /> </td>
      </tr>
      <tr class="altRow">
        <th>
          <xsl:value-of select="$AFCTemplate/headings/end_uses/space_cooling[ @xml:lang= $lang ]" />
        </th>
        <td> &#x2013; </td>
        <td> &#x2013; </td>
        <td> &#x2013; </td>
        <td> &#x2013; </td>
        <td> <xsl:value-of select="$P" /> </td>
      </tr>
      <tr class="row">
        <th>
          <xsl:value-of select="$AFCTemplate/headings/end_uses/dhw_heating[ @xml:lang= $lang ]" />
        </th>
        <td> <xsl:value-of select="$B" /> </td>
        <td> <xsl:value-of select="$G" /> </td>
        <td> <xsl:value-of select="$J" /> </td>
        <td> <xsl:value-of select="$M" /> </td>
        <td> <xsl:value-of select="$Q" /> </td>
      </tr>
      <tr class="altRow">
        <th>
          <xsl:value-of select="$AFCTemplate/headings/end_uses/ventilation[ @xml:lang= $lang ]" />
        </th>
        <td> &#x2013; </td>
        <td> &#x2013; </td>
        <td> &#x2013; </td>
        <td> &#x2013; </td>
        <td> <xsl:value-of select="$R" /> </td>
      </tr>
      <tr class="totalRow">
        <th>
          <xsl:value-of select="$AFCTemplate/headings/end_uses/total[ @xml:lang= $lang ]" />
        </th>
        <td> <xsl:value-of select="$D" /> </td>
        <td> <xsl:value-of select="$H" /> </td>
        <td> <xsl:value-of select="$K" /> </td>
        <td> <xsl:value-of select="$N" /> </td>
        <td> <xsl:value-of select="$S" /> </td>
      </tr>

		</table>
		
		<br />
		
	</xsl:template>
	
	
</xsl:stylesheet>