<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="SHCITemplate" select="$tplLang/h3k/templates/template[ @name = 'annual_sh_cooling_infiltration' ]"  />
	
	
	<xsl:template match="*" mode="annual_sh_cooling_infil">
		
		<h1><xsl:value-of select="$SHCITemplate/title[@xml:lang=$lang]" /></h1>
		
		<xsl:apply-templates select="/system/building/all_zones" mode="annual_shci_data" />
	
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: annual_shci_data
	Data Created: MAR.06.2008
	
	Description:
		
		building/all_zones/thermal_loads/heating/total
		building/all_zones/internal_gains/useful
		building/all_zones/insolation/useful
		building/all_zones/supplied_energy/heating
		building/all_zones/thermal_loads/cooling/total
		building/all_zones/internal_gains/adverse
		building/all_zones/insolation/adverse
		building/all_zones/supplied_energy/cooling
		
	
	=============================================================================
	-->
	<xsl:template match="*" mode="annual_shci_data">
		
		<table cellspacing="0">
		  <col_group span="2">
        <col align="left"></col>
        <col align="right"></col>
      </col_group>
			<!-- HEAT LOSS THROUGH ENVELOPE -->
			<tr class="row">
				<th> <xsl:value-of select="$SHCITemplate/headings/heat_loss_env[@xml:lang=$lang]" /></th>
				<td> 
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="thermal_loads/heating/total/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
			
			<!-- USABLE INTERNAL GAINS -->
			<tr class="altRow">
				<th><xsl:value-of select="$SHCITemplate/headings/usable_internal_gains[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="internal_gains/useful/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>

			</tr>
			
			<!-- USABLE SOLAR GAINS -->
			<tr class="row">
				<th><xsl:value-of select="$SHCITemplate/headings/usable_solar_gains[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="insolation/useful/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
			
			<!-- SUPPLIED HEATING -->
			<tr class="altRow">
				<th><xsl:value-of select="$SHCITemplate/headings/supplied_heating[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="supplied_energy/heating/integrated_data/bin[@type='annual']"  />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
			
			<!-- HEAT GAINS ENVELOPE -->
			<tr class="row">
				<th><xsl:value-of select="$SHCITemplate/headings/heat_gains_env[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="thermal_loads/cooling/total/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
			
			<!-- ADVERSE INTERNAL GAINS -->
			<tr class="altRow">
				<th><xsl:value-of select="$SHCITemplate/headings/adverse_internal_gains[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="internal_gains/adverse/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
		
			<!-- ADVERSE SOLAR GAINS -->
			<tr class="row">
				<th><xsl:value-of select="$SHCITemplate/headings/adverse_solar_gains[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="insolation/adverse/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
			
			<!-- SUPPLIED COOLING -->
			<tr class="altRow">
				<th><xsl:value-of select="$SHCITemplate/headings/supplied_cooling[@xml:lang=$lang]" /></th>
				<td>
					<xsl:call-template name="heatFormat">
						<xsl:with-param name="value" select="supplied_energy/cooling/integrated_data/bin[@type='annual']" />
					</xsl:call-template>
					<xsl:call-template name="heatSuffixNoBrackets" />
				</td>
			</tr>
			
		</table>
		
		<br />
		
	</xsl:template>
	
	
</xsl:stylesheet>